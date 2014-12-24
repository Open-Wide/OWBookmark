{def
    $min_class_count = ezini( 'OwBookmarkSettings', 'MinClassCountComboList', 'owbookmark.ini' )
    $use_quick_add_objects = ezini( 'OwBookmarkSettings', 'UseQuickAddObjects', 'owbookmark.ini' )
    $bookmark_list = fetch( 'content', 'bookmarks' )
    $bookmark_node = 0
    $can_create_class_list = false
    $temp_node = false
    $path_string = false
    $popin_id = false
    $bookmark_title = ''
}

{if $bookmark_list}
    <h2>{'Bookmarks'|i18n( 'design/admin/pagelayout' )}</h2>
    <table class="list owbookmark_list">
        <tr>
            <th class="tight"></th>
            <th>{'Name'|i18n( 'design/admin/dashboard/drafts' )}</th>
            <th class="tight"></th>
        </tr>
        {foreach $bookmark_list as $bookmark sequence array( 'bglight', 'bgdark' ) as $style}
            {set
                $bookmark_node = $bookmark.node
                $can_create_class_list = $bookmark_node.object.can_create_class_list
                $path_string = hash()
                $popin_id = concat("fancybox_bookmark_", $bookmark_node.object.id)
                $bookmark_title = '@TODO'
            }
            {foreach $bookmark_node.path_array as $k => $id}
                {if $k|lt(3)} {continue} {/if}
                {set
                    $temp_node = fetch('content', 'node', hash('node_id', $id))
                    $path_string = $path_string|append($temp_node.name)
                }
            {/foreach}

            <tr class="{$style}">
                <td class="star"><a href="#{$popin_id}" class="fancybox fancybox_inline" title="{$bookmark_node.name|wash}"><img src={'icons/star-16-on.png'|ezimage} /></a></td>
                <td>
                    <span><a href={$bookmark_node.url_alias|ezurl} title="{$path_string|implode(' &raquo; ')}" class="tooltip">{$bookmark_node.name|wash}</a></span>
                    {if and($use_quick_add_objects|eq(true()), $can_create_class_list|count|gt(0))}
                        <br />
                        <div class="class_list">

                        {if $can_create_class_list|count|ge($min_class_count)}
                            <form id="menu-form-create-here-{$bookmark_node.object.id}-{$class.id}" method="post" action="/content/action">
                                <input type="hidden" name="NewButton" value="x" />
                                <input type="hidden" name="ContentNodeID" value="{$bookmark_node.node_id}" />
                                <input type="hidden" name="NodeID" value="{$bookmark_node.node_id}" />
                                <input type="hidden" name="ContentObjectID" value="{$bookmark_node.object.id}" />
                                <input type="hidden" name="ClassID" value="{$class.id}" />
                                <input type="hidden" name="ViewMode" value="full" />
                                <select name="ClassID">
                                    {foreach $can_create_class_list as $class}
                                    <option value="{$class.id}">{$class.name|wash}</option>
                                    {/foreach}
                                </select>
                                <input type="submit" value="{'Add'|i18n( 'owbookmark' )}" class="button button_add" />
                            </form>
                        {else}
                            {foreach $can_create_class_list as $class}
                                <form id="menu-form-create-here-{$bookmark_node.object.id}-{$class.id}" method="post" action="/content/action">
                                    {*<input type="hidden" name="ezxform_token" value="" />*}
                                    <input type="hidden" name="NewButton" value="x" />
                                    <input type="hidden" name="ContentNodeID" value="{$bookmark_node.node_id}" />
                                    <input type="hidden" name="NodeID" value="{$bookmark_node.node_id}" />
                                    <input type="hidden" name="ContentObjectID" value="{$bookmark_node.object.id}" />
                                    <input type="hidden" name="ClassID" value="{$class.id}" />
                                    <input type="hidden" name="ViewMode" value="full" />
                                    <input type="submit" value="{$class.name}" class="button button_add" />
                            </form>
                            {/foreach}
                        {/if}

                        </div>
                    {/if}

                    {include uri="design:owbookmark/popin_update.tpl" popin_id=$popin_id node=$bookmark_node title=$bookmark_title}
                </td>
                <td>
                    {if $bookmark_node.can_edit}
                        <a href="{concat( '/content/edit/', $bookmark_node.object.id, '/f/', $bookmark_node.object.default_language )|ezurl('no')}" title="{'Edit <%draft_name>.'|i18n( 'design/admin/dashboard/drafts',, hash( '%draft_name', $bookmark_node.name ) )|wash()}">
                            <img src={'edit.gif'|ezimage} width="16" height="16" border="0" alt="{'Edit'|i18n( 'design/admin/dashboard/drafts' )}" />
                        </a>
                    {else}
                        <img src="{'edit-disabled.gif'|ezimage('no')}" alt="{'Edit'|i18n( 'design/admin/dashboard/latest_content' )}" title="{'You do not have permission to edit <%child_name>.'|i18n( 'design/admin/dashboard/latest_content',, hash( '%child_name', $bookmark_node.name ) )|wash}" />
                    {/if}
                </td>
            </tr>
        {/foreach}
    </table>
{/if}
{undef $bookmark_list $bookmark_node}
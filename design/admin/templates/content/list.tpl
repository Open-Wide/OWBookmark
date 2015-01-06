{def
    $min_class_count = ezini( 'OwBookmarkSettings', 'MinClassCountComboList', 'owbookmark.ini' )
    $display_class_icon = ezini( 'OwBookmarkSettings', 'DisplayClassIcon', 'owbookmark.ini' )
    $display_content_type_column = ezini( 'OwBookmarkSettings', 'DisplayContentTypeColumn', 'owbookmark.ini' )
    $use_quick_add_objects = fetch( 'user', 'has_access_to', hash( 'module', 'owbookmark', 'function', 'quickaddchild' ) )
    $bookmark_list = fetch( 'content', 'bookmarks' )
    $bookmark_node = false
    $can_create_class_list = false
    $temp_node = false
    $path_string = false
    $owbookmark_custom = false
    $bookmark_title = ''
}

<h2>{'My bookmarks'|i18n( 'design/admin/parts/my/menu' )}</h2>
{if $bookmark_list}
    <table class="list owbookmark_list">
        <tr>
            <th class="tight"></th>
            <th>{'Name'|i18n( 'design/admin/content/bookmark' )}</th>
            {if $display_content_type_column|eq(true())}
            <th>{'Type'|i18n( 'design/admin/content/bookmark' )}</th>
            {/if}
            <th class="tight"></th>
        </tr>
        {foreach $bookmark_list as $bookmark sequence array( 'bglight', 'bgdark' ) as $style}
            {set
                $bookmark_node = $bookmark.node
                $can_create_class_list = $bookmark_node.object.can_create_class_list
                $path_string = hash()
                $owbookmark_custom = owbookmark_get($bookmark.id)
            }
            {if $owbookmark_custom}
                {set $bookmark_title = $owbookmark_custom.name}
            {else}
                {set $bookmark_title = $bookmark_node.name}
            {/if}
            {undef $owbookmark_custom}
            {foreach $bookmark_node.path_array as $k => $id}
                {if $k|lt(3)} {continue} {/if}
                {set
                    $temp_node = fetch('content', 'node', hash('node_id', $id))
                    $path_string = $path_string|append($temp_node.name)
                }
            {/foreach}

            <tr class="{$style}">
                <td class="star">
                    {include uri='design:owbookmark/popin_update.tpl' icon_size='16'}
                </td>
                <td>
                    {if $display_class_icon|eq(true())}
                        {$bookmark_node.class_identifier|class_icon( small, $bookmark_node.class_name )}
                    {/if}
                    <span><a href={$bookmark_node.url_alias|ezurl} title="{$path_string|implode(' &raquo; ')}" class="tooltip">{$bookmark_title|wash}</a></span>
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
                                <input type="submit" value="{'Add'|i18n( 'design/admin/owbookmark' )}" class="button button_add" />
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
                </td>

                {if $display_content_type_column|eq(true())}
                    <td>{$bookmark_node.class_name|wash()}</td>
                {/if}

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
{else}
    <p>{"You have no bookmarks"|i18n("design/standard/content/view")}</p>
{/if}
{undef $bookmark_list $bookmark_node}
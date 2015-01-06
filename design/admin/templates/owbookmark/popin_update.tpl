{def
    $icon_state = 'on'
    $current_bookmark = false
}

{if is_set($bookmark_title)|not}
    {def $bookmark_title = ''}
{/if}

{if and(is_set($bookmark_node)|not, is_set($bookmark))}
    {def
        $bookmark_node = $bookmark.node
    }
    {set $current_bookmark = $bookmark}
{else}
    {set $icon_state = 'off'}

    {if is_set($bookmark_list)|not}
        {def $bookmark_list = fetch( 'content', 'bookmarks' )}
    {/if}

    {if is_set($bookmark_node)|not}
        {def $bookmark_node = $node}
    {/if}

    {if $bookmark_node}
        {foreach $bookmark_list as $bookmark_list_item}
            {if $bookmark_list_item.node.node_id|eq($bookmark_node.node_id)}
                {set $current_bookmark = $bookmark_list_item}
                {set $icon_state = 'on'}
            {/if}
        {/foreach}
    {/if}
{/if}

{def $owbookmark_custom = owbookmark_get($current_bookmark.id)}
{if $owbookmark_custom}
    {set $bookmark_title = $owbookmark_custom.name}
{else}
    {set $bookmark_title = $bookmark_node.name}
{/if}

{def
    $popin_id = concat("fancybox_bookmark_", $bookmark_node.object.id)
}
<a href="#{$popin_id}" class="fancybox fancybox_inline" title="{"Edit"|i18n("design/admin/popupmenu")}">
    <img src={concat('icons/star-', $icon_size, '-', $icon_state, '.png')|ezimage} />
</a>

<div class="owbookmark popin" id="{$popin_id}">
    <form action={"/owbookmark/update"|ezurl} method="post" class="form_bookmark">

        <input type="hidden" name="RedirectURI" value="{$redirect_uri}" />
        <input type="hidden" name="nodeID" value="{$bookmark_node.node_id}" />
        {if $current_bookmark}
        <input type="hidden" name="bookmarkID" value="{$current_bookmark.id}" />
        {/if}

        <div class="fancybox-title fancybox-title-inside-wrap">
            {$bookmark_node.class_identifier|class_icon( small, $bookmark_node.class_name )} {$bookmark_node.name}
        </div>

        <div class="block">
            <label>{'Customize the name of the bookmark'|i18n( 'design/admin/owbookmark' )} :</label>
            <input type="text" value="{$bookmark_title|wash}" name="bookmarkName" class="box" />
        </div>

        <hr />

        <input type="button" value="{'Cancel'|i18n( 'design/admin/settings' )}" class="button button_close" />
        <input type="submit" name="ActionUpdate" value="{'Save'|i18n( 'design/admin/settings' )}" class="defaultbutton button_save" />

        {if is_set($current_bookmark)}
        <input type="submit" name="ActionDelete" value="{"Remove bookmark"|i18n("design/admin/popupmenu")}" class="button button_delete" />
        {/if}

    </form>

</div>

{undef $current_bookmark $icon_state $bookmark_title}
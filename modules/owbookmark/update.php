<?php

$Module = $Params['Module'];
$http = eZHTTPTool::instance();
$user = eZUser::currentUser();
$userID = $user->id();

$keys = array('nodeID', 'bookmarkID', 'bookmarkName', 'RedirectURI');
foreach ($keys as $key) {
    $$key = false;
    if ( $Module->hasActionParameter( $key ) ) {
        $$key = $Module->actionParameter( $key );
    } elseif ( isset( $Params[ $key ] ) ) {
        $$key = $Params[ $key ];
    }
}
$node = eZContentObjectTreeNode::fetch($nodeID);

if( !is_null( $nodeID ) ) {
    if( $Module->isCurrentAction( 'Delete' ) ) {
        OwBookmarkCustom::delete($bookmarkID);
        eZContentBrowseBookmark::removeObject(eZContentBrowseBookmark::definition(), array('id' => $bookmarkID));
        cleanViewFullCache($node);
    } elseif( $Module->isCurrentAction( 'Update' ) ) {
        if ($bookmarkName) {
            if (!$bookmarkID) {
                // Save new ez bookmark
                $bookmark = eZContentBrowseBookmark::createNew( $userID, $nodeID, $node->Name );
                $bookmarkID = $bookmark->ID;
            }

            OwBookmarkCustom::createOrUpdate(array(
              'bookmark_id' => $bookmarkID,
              'name' => $bookmarkName,
            ));
            cleanViewFullCache($node);
        } else {
            // Removing entry with customizing data, eZ bookmark is still available
            OwBookmarkCustom::delete($bookmarkID);
            cleanViewFullCache($node);
        }
    }
    $Module->redirectTo( $http->postVariable( 'RedirectURI' ) );
}

function cleanViewFullCache($node) {
    $objectID = $node->attribute( 'contentobject_id' );
    eZContentCacheManager::clearContentCache( $objectID );
}
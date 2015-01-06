<?php

$Module = array( 'name' => 'Bookmarks' );

$ViewList = array();

$ViewList['update'] = array(
    'script' => 'update.php',
    'ui_context' => 'view',
    'functions' => array( 'edit' ),
    'params' => array( 'nodeID', 'bookmarkID', 'bookmarkName', 'RedirectURI' ),
    'single_post_actions' => array(
      'ActionDelete' => 'Delete',
      'ActionUpdate' => 'Update',
    ),
    'post_action_parameters' => array(
      'Update' => array(
        'nodeID' => 'nodeID',
        'bookmarkID' => 'bookmarkID',
        'bookmarkName' => 'bookmarkName',
        'RedirectURI' => 'RedirectURI',
      ),
      'Delete' => array(
        'nodeID' => 'nodeID',
        'bookmarkID' => 'bookmarkID',
        'RedirectURI' => 'RedirectURI',
      ),
    ),
);

$FunctionList['edit'] = array();
$FunctionList['quickaddchild'] = array();


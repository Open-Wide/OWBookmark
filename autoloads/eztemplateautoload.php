<?php

// Operator autoloading

$eZTemplateOperatorArray = array( );

$eZTemplateOperatorArray[] = array(
    'script' => 'extension/owbookmark/autoloads/owbookmarkoperators.php',
    'class' => 'OwBookmarkOperators',
    'operator_names' => array(
        'owbookmark_get',
    )
);
?>
<?php

/**
 * @author fjarnet
 */
class OwBookmarkCustom extends eZPersistentObject {

    /**
     * @return array
     */
    public static function definition() {
        return array(
            'class_name' => 'OwBookmarkCustom',
            'name' => 'owbookmark_custom',
            'fields' => array(
              'bookmark_id' => array(
                'name' => 'bookmark_id',
                'datatype' => 'integer',
                'default' => null,
                'required' => true,
              ),
              'name' => array(
                'name' => 'name',
                'datatype' => 'string',
                'default' => null,
                'required' => true,
              ),
            ),
            'keys' => array( 'bookmark_id' ),
            'function_attributes' => array(
            ),
            'sort' => array(
              'type' => 'asc',
              'date' => 'desc',
            ),
            'set_functions' => array(),
            'grouping' => array()
        );
    }

    /**
     * @param array $row
     * @return OwBookmarkCustom
     */
    public static function createOrUpdate( array $row ) {
        $def = self::definition();
        $keys = $def["keys"];
        $fetchCond = array();
        foreach ( $keys as $key ) {
            if ( isset( $row[$key] ) ) {
                $fetchCond[$key] = $row[$key];
            }
        }
        if ( count( $fetchCond ) == count( $keys ) ) {
            $object = self::fetch( $fetchCond );
        }
        if ( isset( $object ) && $object ) {
            
        } else {
            $object = new self( $row );
        }
        foreach ( $row as $attr => $val ) {
            $object->setAttribute( $attr, $val );
        }
        $object->store();
        return $object;
    }

    /**
     * @param array $conds
     * @return OwBookmarkCustom
     */
    static function fetch( array $conds, $asObject = true ) {
        return self::fetchObject( self::definition(), null, $conds, $asObject );
    }

    /**
     * @param $bookmarkID
     */
    static function delete($bookmarkID) {
        eZPersistentObject::removeObject(self::definition(), array('bookmark_id' => $bookmarkID));
    }

    /**
     * @param array $conds
     * @param integer $limit
     * @param integer $offset
     * @param boolean $asObject
     * @return OwBookmarkCustom[]
     */
    static function fetchList( $conds = array(), $limit = false, $offset = false, $sortArr = null, $asObject = true ) {
        $limitArr = null;
        if ( (int) $limit != 0 ) {
            $limitArr = array(
                'limit' => $limit,
                'offset' => $offset );
        }
        $objectList = eZPersistentObject::fetchObjectList( self::definition(), null, $conds, $sortArr, $limitArr, $asObject, null, null, null, null );
        return $objectList;
    }

    /**
     * @param array $conds
     * @return integer
     */
    static function countList( $conds = array() ) {
        $objectList = eZPersistentObject::count( self::definition(), $conds );
        return $objectList;
    }
}

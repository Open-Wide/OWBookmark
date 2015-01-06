<?php

class OwBookmarkOperators {

    /**
     * @var array
     */
    public $Operators;

    /**
     * Constructor
     */
    public function __construct() {
        $this->Operators = array(
            'owbookmark_get',
        );
    }

    /**
     * Returns the operators in this class.
     *
     * @return mixed
     */
    public function & operatorList() {
        return $this->Operators;
    }

    /**
     * Return true to tell the template engine that the parameter list
     * exists per operator type, this is needed for operator classes
     * that have multiple operators.
     *
     * @return bool
     */
    public function namedParameterPerOperator() {
        return true;
    }

    /**
     * Both operators have one parameter.
     * See eZTemplateOperator::namedParameterList()
     *
     * @return array
     */
    public function namedParameterList() {
        return array(
            'owbookmark_get' => array(
                'bookmarkID' => array(),
            ),
        );
    }

    /**
     * Executes the needed operator(s).
     * Checks operator names, and calls the appropriate functions.
     *
     * @param $tpl
     * @param $operatorName
     * @param $operatorParameters
     * @param $rootNamespace
     * @param $currentNamespace
     * @param $operatorValue
     * @param $namedParameters
     */
    public function modify($tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters) {
        switch ($operatorName) {
            case 'owbookmark_get' :
                $operatorValue = $this->getBookmark($operatorValue, $namedParameters['bookmarkID']);
                break;
        }
    }

    /**
     * Get the custom bookmark, if exists
     *
     * @param $operatorValue
     * @param $params
     * @return OwBookmarkCustom
     */
    public function getBookmark($operatorValue, $bookmarkID) {
        $obj = OwBookmarkCustom::fetch(array(
          'bookmark_id' => $bookmarkID,
        ));
        return $obj;
    }
}

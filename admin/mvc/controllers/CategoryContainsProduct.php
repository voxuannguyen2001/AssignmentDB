<?php
class CategoryContainsProduct extends Controller
{
    public $data = array();
    protected $CategoryContainsProductModel;
    function __construct()
    {
        $this->CategoryContainsProductModel = $this->model('CategoryContainsProductModel');
    }
    function CategoryContainsProductPage($categoryID)
    {
        $list = $this->CategoryContainsProductModel->get_list_by($categoryID);
        $this->data['render'] = 'CategoryContainsProduct';
        $this->data['list'] = $list;
        $this->data['categoryID'] = $categoryID;
        $this->view('layout', $this->data);
    }
}

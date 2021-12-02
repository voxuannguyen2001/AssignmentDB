<?php
class Category extends Controller
{
    public $data = array();
    protected $CategoryModel;
    function __construct()
    {
        $this->CategoryModel = $this->model('CategoryModel');
    }
    function CategoryPage()
    {
        $Categories = $this->CategoryModel->get_category();
        $this->data['render'] = 'category';
        $this->data['CategoryList'] = $Categories;
        $this->view('layout', $this->data);
    }
    function insertCategory()
    {
        $this->data['render'] = 'insertCategory';
        $this->view('layout', $this->data);
    }
}
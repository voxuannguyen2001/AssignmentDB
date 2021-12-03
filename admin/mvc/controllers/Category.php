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
    function doInsertCategory()
    {
        if (empty($_POST['category_id']) || empty($_POST['name_category']) || empty($_POST['total_product'])) 
        {
            echo 'failed';
        } 
        else 
        {
            $check = $this->CategoryModel->insert_category(
                $_POST['category_id'],
                $_POST['name_category'],
                $_POST['total_product'],
            );
            echo $check;
        }
    }
    function deleteCategory($categoryID)
    {
        $this->CategoryModel->remove_category($categoryID);
        header("Location: http://localhost/AssignmentDB/admin/Category/Categorypage");
    }
}
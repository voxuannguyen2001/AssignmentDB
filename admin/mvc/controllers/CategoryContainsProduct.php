<?php
class CategoryContainsProduct extends Controller
{
    public $data = array();
    protected $CategoryContainsProductModel;
    function __construct()
    {
        $this->CategoryContainsProductModel = $this->model('CategoryContainsProductModel');
    }
    function CategoryContainsProductPage($orderID)
    {
        $list = $this->CategoryContainsProductModel->get_list_by($categoryID);
        $this->data['render'] = 'CategoryContainsProduct';
        $this->data['list'] = $list;
        $this->data['categoryID'] = $categoryID;
        $this->view('layout', $this->data);
    }

    function delete( $shopID, $productID)
    {
        $this->CategoryContainsProductModel->remove( $shopID, $productID);
        header("Location: http://localhost/AssignmentDB/admin/OrderContainsProduct/OrderContainsProductPage/" . $shopID);
    }
    function insert($categoryID)
    {
        $this->data['render'] = 'insertCategoryContainsProductModel';
        $this->data['orderID'] = $categoryID;
        $this->view('layout', $this->data);
    }
    function doInsert($categoryID)
    {
        if ( empty($_POST['shop_id']) || empty($_POST['product_id'])) {
            echo 'failed';
        } else {
            $check = $this->CategoryContainsProductModel->do_insert( $_POST['shop_id'], $_POST['product_id'], $_POST['category_id']);
            echo $check;
        }
    }
}

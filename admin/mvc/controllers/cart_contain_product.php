<?php
class cart_contain_product extends Controller
{
    public $data = array();
    protected $cartContainProductModel;
    function __construct()
    {
        $this->cartContainProductModel = $this->model('CartContainProductModel');
    }
    function cart_contain_product_page()
    {
        $ccps = $this->cartContainProductModel->get_all_ccp();
        $this->data['render'] = 'ccp';
        $this->data['ccpList'] = $ccps;
        $this->view('layout', $this->data);
    }
    function delete_ccp($cart_id, $user_id, $product_id, $shop_id)
    {
        $this->cartContainProductModel->remove_ccp($cart_id, $user_id, $product_id, $shop_id);
        header("Location: http://localhost/AssignmentDB/admin/cart_contain_product/cart_contain_product_page");
    }
    function insert_ccp()
    {
        $this->data['render'] = 'insertCartContainProduct';
        $this->view('layout', $this->data);
    }
    function doInsert_ccp()
    {
        if (empty($_POST['cart_id']) || empty($_POST['user_id']) || empty($_POST['product_id'])
            || empty($_POST['shop_id']) || empty($_POST['product_count']) || empty($_POST['saleprice']))
        {
            echo 'failed';
        } 
        else {
            $check = $this->cartContainProductModel->insert_record_into_ccp(
                $_POST['cart_id'],
                $_POST['user_id'],
                $_POST['product_id'],
                $_POST['shop_id'],
                $_POST['product_count'],
                $_POST['saleprice']
            );
            echo $check;
        }
    }
    // function removeAll()
    // {
    //     $orderModel = $this->model('OrderModel');
    //     $orderModel->remove_all();
    //     header("Location: http://localhost/AssignmentDB/admin/Order/OrderPage");
    // }
}

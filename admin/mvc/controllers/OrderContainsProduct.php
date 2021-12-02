<?php
class OrderContainsProduct extends Controller
{
    public $data = array();
    protected $orderContainsProductModel;
    function __construct()
    {
        $this->orderContainsProductModel = $this->model('OrderContainsProductModel');
    }
    function OrderContainsProductPage($orderID)
    {
        $list = $this->orderContainsProductModel->get_list_by($orderID);
        $this->data['render'] = 'orderContainsProduct';
        $this->data['list'] = $list;
        $this->data['orderID'] = $orderID;
        $this->view('layout', $this->data);
    }
    function edit($orderID, $shopID, $productID)
    {
        $this->data['render'] = 'editOrderContainsProduct';
        $this->data['orderID'] = $orderID;
        $this->data['shopID'] = $shopID;
        $this->data['productID'] = $productID;
        $this->view('layout', $this->data);
    }
    function doEdit($orderID, $shopID, $productID)
    {
        if (empty($_POST['amount']) || empty($_POST['price'])) {
            echo 'failed';
        } else {
            $check = $this->orderContainsProductModel->do_edit($orderID, $shopID, $productID, $_POST['amount'], $_POST['price']);
            echo $check;
        }
    }
    function delete($orderID, $shopID, $productID)
    {
        $this->orderContainsProductModel->remove($orderID, $shopID, $productID);
        header("Location: http://localhost/AssignmentDB/admin/OrderContainsProduct/OrderContainsProductPage/" . $orderID);
    }
    function insert()
    {
        $this->data['render'] = 'insertOrderContainsProduct';
        $this->view('layout', $this->data);
    }
    function doInsert($orderID)
    {
        if (empty($_POST['amount']) || empty($_POST['price']) || empty($_POST['shop_id']) || empty($_POST['product_id'])) {
            echo 'failed';
        } else {
            $check = $this->orderContainsProductModel->do_insert($orderID, $_POST['shop_id'], $_POST['product_id'], $_POST['amount'], $_POST['price']);
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

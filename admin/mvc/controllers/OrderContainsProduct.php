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
    // function deleteOrder($orderID)
    // {
    //     $this->orderModel->remove_order($orderID);
    //     header("Location: http://localhost/AssignmentDB/admin/Order/OrderPage");
    // }
    // function insertOrder()
    // {
    //     $this->data['render'] = 'insertOrder';
    //     $this->view('layout', $this->data);
    // }
    // function doInsertOrder()
    // {
    //     if (
    //         empty($_POST['shipping_id']) || empty($_POST['create_date']) || empty($_POST['the_user_id'])
    //         || empty($_POST['sname']) || empty($_POST['saddress']) || empty($_POST['sphone_number']) || empty($_POST['status'])
    //     ) {
    //         echo 'failed';
    //     } else {
    //         $check = $this->orderModel->insert_order(
    //             $_POST['shipping_id'],
    //             $_POST['create_date'],
    //             $_POST['the_user_id'],
    //             $_POST['sname'],
    //             $_POST['saddress'],
    //             $_POST['sphone_number'],
    //             $_POST['status']
    //         );
    //         echo $check;
    //     }
    // }
    // function removeAll()
    // {
    //     $orderModel = $this->model('OrderModel');
    //     $orderModel->remove_all();
    //     header("Location: http://localhost/AssignmentDB/admin/Order/OrderPage");
    // }
}

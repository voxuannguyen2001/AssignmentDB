<?php
class Order extends Controller
{
    public $data = array();
    protected $orderModel;
    function __construct()
    {
        $this->orderModel = $this->model('OrderModel');
    }
    function OrderPage()
    {
        $orders = $this->orderModel->get_all_order();
        $this->data['render'] = 'order';
        $this->data['orderList'] = $orders;
        $this->view('layout', $this->data);
    }
    function deleteOrder($orderID)
    {
        $this->orderModel->remove_order($orderID);
        header("Location: http://localhost/AssignmentDB/admin/Order/OrderPage");
    }
    function insertOrder()
    {
        $this->data['render'] = 'insertOrder';
        $this->view('layout', $this->data);
    }
    function doInsertOrder()
    {

        if (empty($_POST['shipping_id']) || empty($_POST['create_date']) || empty($_POST['the_user_id']) || empty($_POST['sname']) || empty($_POST['saddress']) || empty($_POST['sphone_number']) || empty($_POST['status'])) {
            echo 'failed';
        } else {
            $check = $this->orderModel->insert_order($_POST['shipping_id'], $_POST['create_date'], $_POST['the_user_id'], $_POST['sname'], $_POST['saddress'], $_POST['sphone_number'], $_POST['status']);
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

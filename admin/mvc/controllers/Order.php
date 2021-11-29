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
    // function removeAll()
    // {
    //     $orderModel = $this->model('OrderModel');
    //     $orderModel->remove_all();
    //     header("Location: http://localhost/CPP_Assignment_CNPM/SourceMVC/admin/Order/OrderPage");
    // }
}

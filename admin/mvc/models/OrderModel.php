<?php
class OrderModel extends Database
{
    function get_all_order()
    {
        $sql = "SELECT * From order_detail";
        return $this->get_list($sql);
    }
    function get_order($orderID)
    {
        $sql = "SELECT * FROM order_detail WHERE order_id = '$orderID' ";
        return $this->get_one($sql);
    }
    function remove_order($orderID)
    {
        $sql = "DELETE FROM order_detail WHERE order_id = '$orderID'";
        $this->query($sql);
    }
    function insert_order($shipping_id, $create_date, $the_user_id, $sname, $saddress, $sphone_number, $status)
    {
        $sql = "INSERT INTO order_detail(shipping_id, order_status, create_date, the_user_id, sname, saddress, sphone_number ) VALUES($shipping_id, '$status', '$create_date', $the_user_id,'$sname', '$saddress', '$sphone_number')";
        return $this->query($sql);
    }
    function remove_all()
    {
        $sql = "DELETE FROM order_detail";
        $this->query($sql);
    }
}

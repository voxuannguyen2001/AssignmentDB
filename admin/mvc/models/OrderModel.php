<?php
class OrderModel extends Database
{
    function get_all_order()
    {
        $sql = "SELECT * From order_detail";
        $data = $this->get_list($sql);
        foreach ($data as $key => $value)
        {
            $total = $this->get_total($value['order_id']);
            $data[$key]['total'] = $total['total'];
        }
        return $data;
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
    function get_total($orderID)
    {
        $sql = "select calculate_total_of_order($orderID) as total";
        return $this->get_one($sql);
    }
}

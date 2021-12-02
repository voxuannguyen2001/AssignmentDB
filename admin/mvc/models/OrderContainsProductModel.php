<?php
class OrderContainsProductModel extends Database
{
    function get_all()
    {
        $sql = "SELECT * From order_contain_products";
        return $this->get_list($sql);
    }
    function get_list_by($orderID)
    {
        $sql = "SELECT * From order_contains_product WHERE order_id = $orderID";
        return $this->get_list($sql);
    }
    function get_one_by($orderID, $shopID, $productID)
    {
        $sql = "SELECT * FROM order_contains_product WHERE order_id = $orderID AND shop_id = $shopID AND product_id = $productID";
        return $this->get_one($sql);
    }
    function do_edit($orderID,$shopID,$productID,$amount,$price)
    {
        $sql = "UPDATE order_contains_product SET amount = $amount, selling_price = $price WHERE order_id = $orderID AND shop_id = $shopID AND product_id = $productID";
        return $this->query($sql);
    }
    // function remove_order($orderID)
    // {
    //     $sql = "DELETE FROM order_detail WHERE order_id = '$orderID'";
    //     $this->query($sql);
    // }
    // function insert_order($shipping_id, $create_date, $the_user_id, $sname, $saddress, $sphone_number, $status)
    // {
    //     $sql = "INSERT INTO order_detail(shipping_id, order_status, create_date, the_user_id, sname, saddress, sphone_number ) VALUES($shipping_id, '$status', '$create_date', $the_user_id,'$sname', '$saddress', '$sphone_number')";
    //     return $this->query($sql);
    // }
    // function remove_all()
    // {
    //     $sql = "DELETE FROM order_detail";
    //     $this->query($sql);
    // }
}

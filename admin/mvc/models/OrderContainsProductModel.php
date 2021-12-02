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
    function remove($orderID, $shopID, $productID)
    {
        $sql = "DELETE FROM order_contains_product WHERE order_id = $orderID AND shop_id = $shopID AND product_id = $productID";
        $this->query($sql);
    }
    function do_insert($orderID, $shopID, $productID, $amount, $price)
    {
        $sql = "INSERT INTO order_contains_product(order_id, shop_id, product_id, amount_id, price) VALUES($orderID, $shopID, $productID, $amount, $price)";
        return $this->query($sql);
    }
    // function remove_all()
    // {
    //     $sql = "DELETE FROM order_detail";
    //     $this->query($sql);
    // }
}

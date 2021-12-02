<?php
class ProductModel extends Database
{
    function get_all_product()
    {
        $sql = "SELECT * FROM product";
        return $this->get_list($sql);
    }
    function get_product_by_shop($shopID)
    {
        $sql = "SELECT * FROM product WHERE shop_id = $shopID";
        return $this->get_list($sql);
    }
    function remove_product($shopID, $productID)
    {
        $sql = "DELETE FROM product WHERE shop_id = $shopID AND product_id = $productID";
        $this->query($sql);
    }
    function get_products_ordered_by_user_in_order_of_price($userID)
    {
        $sql = "call get_products_ordered_by_user_in_order_of_price($userID)";
        return $this->get_list($sql);
    }
}

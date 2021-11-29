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
}

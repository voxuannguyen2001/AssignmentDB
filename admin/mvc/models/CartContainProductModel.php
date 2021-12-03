<?php
class CartContainProductModel extends Database
{
    function get_all_ccp()
    {
        $sql = "SELECT * From cart_contain_product";
        return $this->get_list($sql);
    }

    function get_ccp($cart_id, $user_id, $product_id, $shop_id)
    {
        $sql = "SELECT * FROM cart_contain_product WHERE cart_id = '$cart_id' and user_id = '$user_id' and product_id = '$product_id' and shop_id = '$shop_id' ";
        return $this->get_one($sql);
    }
    function remove_ccp($cart_id,$user_id,$product_id,$shop_id)
    {
        $sql = "DELETE FROM cart_contain_product WHERE cart_id = '$cart_id' and user_id = '$user_id' and product_id = '$product_id' and shop_id = '$shop_id' ";
        $this->query($sql);
    }
    function insert_record_into_ccp($cart_id, $user_id, $product_id, $shop_id, $product_count, $saleprice)
    {
        $sql = "INSERT INTO cart_contain_product(cart_id,user_id, product_id, shop_id, product_count, saleprice) VALUES($cart_id, $user_id, $product_id, $shop_id, $product_count, $saleprice)";
        return $this->query($sql);
    }
    function remove_all()
    {
        $sql = "DELETE FROM cart_contain_product";
        $this->query($sql);
    }
}

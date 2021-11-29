<?php
class ShopModel extends Database
{
    function get_all_shop()
    {
        $sql = "SELECT * FROM shop";
        return $this->get_list($sql);
    }
    function get_shop_by($shopID)
    {
        $sql = "SELECT * FROM shop Where shop_id = $shopID";
        return $this->get_one($sql);
    }
}

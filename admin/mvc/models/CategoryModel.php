<?php
class CategoryModel extends database
{
    function get_category()
    {
        $sql = "SELECT * From category";
        return $this->get_list($sql);
    }
    function insert_Category($category_id, $name_category, $total_product)
    {
        $sql = "INSERT INTO order_detail(category_id, name_category, total_product) VALUES($category_id, '$name_category', '$total_product')";
        return $this->query($sql);
    }
}
<?php
class CategoryModel extends database
{
    function get_category()
    {
        $sql = "SELECT * From category";
        return $this->get_list($sql);
    }
    function insert_category($category_id, $name_category, $total_product)
    {
        $sql = "INSERT INTO order_detail(category_id, name_category, total_product) VALUES($category_id, '$name_category', '$total_product')";
        return $this->query($sql);
    }
    function get_one_category($categoryID)
    {
        $sql = "SELECT * FROM category WHERE category_id = '$categoryID' ";
        return $this->get_one($sql);
    }
    function remove_category($orderID)
    {
        $sql = "DELETE FROM category WHERE category_id = '$categoryID'";
        $this->query($sql);
    }
}
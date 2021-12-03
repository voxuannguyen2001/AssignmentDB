<?php
class CategoryContainsProductModel extends Database
{
    function get_all()
    {
        $sql = "SELECT * From product_category";
        return $this->get_list($sql);
    }
    function get_list_by($categoryID)
    {
        $sql = "SELECT * From product_category WHERE category_id = $categoryID";
        return $this->get_list($sql);
    }
}

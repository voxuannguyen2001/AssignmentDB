<?php

class FeedbackModel extends Database
{
    function get_all_feedback()
    {
        $sql = "SELECT * From feedback";
        return $this->get_list($sql);
    }
    function get_feedback($feedbackID)
    {
        $sql = "SELECT * FROM feedback WHERE feedback_id = '$feedbackID' ";
        return $this->get_one($sql);
    }
    function remove_feedback($feedbackID)
    {
        $sql = "DELETE FROM feedback WHERE feedback_id = '$feedbackID'";
        $this->query($sql);
    }
    function remove_all()
    {
        $sql = "DELETE FROM feedback";
        $this->query($sql);
    }    
    function addFeedback($sql)
	{
        return $this->query($sql); 
	}
    // function getShopByProductId($product_id)
    // {
    //   $sql = "SELECT shop_id FROM PRODUCT where product_id = '$product_id'";
    //   print($sql);
    //   return $this->get_one($sql);
    // }
    function update_feedback($feedback_id, $review_content, $rating) 
    {   
        $sql = "UPDATE feedback SET review_content=$review_content, rating=$rating WHERE feedback_id=$feedback_id";
        return $this->query($sql);
    }
    function view_feedback($feedbackID)
    {
        $sql = "call getFeedbackOfProduct($feedbackID, 'ASC')";
        $this->query($sql);
    }
    function get_numfeedback_by_shop($shopID)
    {
        $sql = "CALL getFeedbackOfShop('$shopID','')";
        return $this->get_list($sql);
    }

}

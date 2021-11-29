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
        $result = $this->query($sql); 
        if (!$result) {
            die (" hihi ERROR: Adding record failed: " . mysqli_error($this->conn));
            // Thông báo lỗi nếu thực thi câu lệnh thất bại
        } else {
            echo "Add feedbacksuccessful";
            return $result;
        }
	}

}

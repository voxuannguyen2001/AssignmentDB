<?php
class Feedback extends Controller
{
    public $data = array();
    protected $feedbackModel;
    function __construct()
    {
        $this->feedbackModel = $this->model('FeedbackModel');
    }
    function FeedbackPage()
    {
        $feedbacks = $this->feedbackModel->get_all_feedback();
        $this->data['render'] = 'feedback';
        $this->data['feedbackList'] = $feedbacks;
        $this->view('layout', $this->data);
    }
    function deletefeedback($feedbackID)
    {
        $this->feedbackModel->remove_feedback($feedbackID);
        header("Location: http://localhost/AssignmentDB/admin/feedback/feedbackPage");
    }
    function insertfeedback()
    {
        $this->data['render'] = 'insertfeedback';
        $this->view('layout', $this->data);
    }
    function edit_submit()
    {

        $action = $_POST['submit'];
        if ($action == 'submit') {
            echo '$action';
            $shop_id = $_POST['shop_id'];
            $product_id = $_POST['product_id'];
            $review_content = $_POST['review_content'];
            $rating = $_POST['rating'];
            $create_date = date("Y/m/d");
            $user_id = $_POST['user_id'];
            $sql = "INSERT INTO feedback(shop_id, product_id, review_content, rating, create_date, user_id) VALUES ('$shop_id', '$product_id','$review_content','$rating','$create_date','$user_id')";
            $success = $this->feedbackModel->addFeedback($sql);
            if ($success) {
                $message = "great answer";
            } else {
                $message = "failed";
            }
            echo "<script type='text/javascript'>alert('$message');</script>";
        }
        header('location: http://localhost/AssignmentDB/admin/feedback/feedbackPage');
    }
    function viewfeedback($feedbackID)
    {
        $this->feedbackModel->view_feedback($feedbackID);
        // header("Location: http://localhost/AssignmentDB/admin/feedback/feedbackPage");
    }
}

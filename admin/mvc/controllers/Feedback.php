<?php
class Feedback extends Controller
{
    public $data = array();
    protected $feedbackModel;
    protected $shopModel;
    function __construct()
    {
        $this->feedbackModel = $this->model('FeedbackModel');
        $this->shopModel = $this->model('ShopModel');
    }
    function FeedbackPage()
    {
        $feedbacks = $this->feedbackModel->get_all_feedback();
        $shops = $this->shopModel->get_all_shop();
        $this->data['render'] = 'feedback';
        $this->data['feedbackList'] = $feedbacks;
        $this->data['shopList'] = $shops;
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

        }
        header('location: http://localhost/AssignmentDB/admin/feedback/feedbackPage');
    }
    function FeedbackInShop($shopID)
    {
        // $feedback = $this->feedbackModel->
    }
    function viewfeedback($feedbackID)
    {
        $this->feedbackModel->view_feedback($feedbackID);
        // header("Location: http://localhost/AssignmentDB/admin/feedback/feedbackPage");
    }
}

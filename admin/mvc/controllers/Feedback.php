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
  function FeedbackInShop($shopID)
  {
    // $link = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
    // $tmp = explode("/", $link);
    // if ($tmp) echo sizeof($tmp);

    // $e = end($tmp);
    // if (strlen($e) < 3) $shopID = $e;
    // else $shopID = 1;
    // $type = $tmp[1];

    // echo "\n";

    // echo "hihi";
    // echo $type;
    // // echo "input";
    // echo $shopID;

    $products = $this->feedbackModel->get_numfeedback_by_shop($shopID,"");
    $shops = $this->shopModel->get_all_shop();
    $shop = $this->shopModel->get_shop_by($shopID);
    $this->data['render'] = 'feedbackInShop';
    $this->data['shopList'] = $shops;
    $this->data['shop'] = $shop;
    $this->data['productList'] = $products;
    $this->view('layout', $this->data);
  }
  function FeedbackInShopASC($shopID)
  {
    $products = $this->feedbackModel->get_numfeedback_by_shop($shopID,"ASC");
    $shops = $this->shopModel->get_all_shop();
    $shop = $this->shopModel->get_shop_by($shopID);
    $this->data['render'] = 'feedbackInShop';
    $this->data['shopList'] = $shops;
    $this->data['shop'] = $shop;
    $this->data['productList'] = $products;
    $this->view('layout', $this->data);
  }
  function FeedbackInShopDESC($shopID)
  {
    $products = $this->feedbackModel->get_numfeedback_by_shop($shopID,"DESC");
    $shops = $this->shopModel->get_all_shop();
    $shop = $this->shopModel->get_shop_by($shopID);
    $this->data['render'] = 'feedbackInShop';
    $this->data['shopList'] = $shops;
    $this->data['shop'] = $shop;
    $this->data['productList'] = $products;
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
  function doInsertFeedback()
  {
    if (
      empty($_POST['product_id'])
      || empty($_POST['review_content'])
      || empty($_POST['rating'])
      || empty($_POST['user_id'])
    ) {
      echo 'failed';
    } else {
      echo '$action';

      $product_id = $_POST['product_id'];

      $shop_id = 1;


      $review_content = $_POST['review_content'];
      $rating = $_POST['rating'];
      $create_date = date("Y/m/d");
      $user_id = $_POST['user_id'];

      $sql = "call add_feedback('$shop_id', '$product_id','$review_content','$rating','$create_date','$user_id')";
      $success = $this->feedbackModel->addFeedback($sql);
      // if ($success == 1) $success = " Add successfully";
      echo $success;
    }
    //header('location: http://localhost/AssignmentDB/admin/feedback/feedbackPage');

  }
  function editFeedback($feedback_id)
  {
    $this->data['feedback'] = $this->feedbackModel->get_feedback($feedback_id);
    $this->data['render'] = 'editFeedback';
    $this->view('layout', $this->data);
  }

  function doEditFeedback()
  {
    // if (
    //     empty($_POST['fullname'])
    // ) {
    //     echo 'failed';
    // } else {

    $check = $this->feedbackModel->update_feedback(
      $_POST['feedback_id'],
      $_POST['review_content'],
      $_POST['rating']
    );
    echo $check;
    // }
  }

  function viewfeedback($feedbackID)
  {
    $this->feedbackModel->view_feedback($feedbackID);
    // header("Location: http://localhost/AssignmentDB/admin/feedback/feedbackPage");
  }
}

<?php
class User extends Controller
{
    public $data = array();
    protected $userModel;
    function __construct()
    {
        $this->userModel = $this->model('UserModel');
    }
    function UserPage()
    {
        $users = $this->userModel->get_all_users();
        $this->data['render'] = 'user';
        $this->data['userList'] = $users;
        $this->view('layout', $this->data);
    }
    function deleteUser($user_id)
    {
        $this->userModel->remove_user($user_id);
        header("Location: http://localhost/AssignmentDB/admin/User/userPage");
    }

    function insertUser()
    {
        $this->data['render'] = 'insertUser';
        $this->view('layout', $this->data);
    }

    function doInsertUser()
    {
        if (
            empty($_POST['username']) || empty($_POST['password'])
            || empty($_POST['fullname'])
        ) {
            echo 'failed';
        } else {

            $check = $this->userModel->insert_user(
                $_POST['username'],
                $_POST['password'],
                $_POST['mobile'],
                $_POST['email'],
                $_POST['fullname'],
                $_POST['dob'],
                $_POST['sex'],
                $_POST['avatar'],
                $_POST['is_seller'],
                $_POST['is_buyer']
            );
            echo $check;
        }
    }

    function doEditUserInfo()
    {
        if (
            empty($_POST['fullname'])
        ) {
            echo 'failed';
        } else {

            $check = $this->userModel->update_user(
                $_POST['user_id'],
                $_POST['mobile'],
                $_POST['email'],
                $_POST['fullname'],
                $_POST['dob'],
                $_POST['sex'],
                $_POST['avatar'],
                $_POST['is_seller'],
                $_POST['is_buyer']
            );
            echo $check;
        }
    }

    function editUser($user_id) {
        $this->data['user'] = $this->userModel->get_user($user_id);
        $this->data['render'] = 'editUser';
        $this->view('layout', $this->data);
    }

    function removeAll() {
        $this->userModel->remove_all();
        header("Location: http://localhost/AssignmentDB/admin/User/userPage");
    }

    function getShops($user_id) {
        $this->data['shopList'] = $this->userModel->get_shops_managed_by_user($user_id);
        $this->data['render'] = 'shopsManagedByUser';
        $this->view('layout', $this->data);
    }
}
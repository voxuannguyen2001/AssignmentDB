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
                $_POST['avatar']
            );
            echo $check;
        }
    }

}

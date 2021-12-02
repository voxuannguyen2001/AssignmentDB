<?php
class UserModel extends Database
{
    function get_all_users()
    {
        $sql = "SELECT * From the_user";
        return $this->get_list($sql);
    }

    function get_user($user_id)
    {
        $sql = "SELECT * FROM the_user WHERE user_id = '$user_id' ";
        return $this->get_one($sql);
    }

    function remove_user($user_id)
    {
        $sql = "DELETE FROM the_user WHERE user_id = '$user_id'";
        $this->query($sql);
    }

    function remove_all()
    {
        $sql = "DELETE FROM the_user";
        $this->query($sql);
    }

    function insert_user($username, $password, $mobile, $email, $fullname, $dob, $sex, $avatar, $is_seller, $is_buyer) 
    {   
        $mobile = !empty($mobile) ? "'$mobile'" : "NULL";
        $email = !empty($email) ? "'$email'" : "NULL";
        $dob = !empty($dob) ? "'$dob'" : "NULL";
        $sex = !empty($sex) ? "'$sex'" : "NULL";
        $avatar = !empty($avatar) ? "'$avatar'" : "NULL";
        $is_buyer = intval($is_buyer);
        $is_seller = intval($is_seller);
        $sql = "call add_user('$username', '$password', $mobile, $email, '$fullname', $sex, $dob, $avatar, $is_seller, $is_buyer)";
        return $this->query($sql);
    }

    function update_user($user_id, $mobile, $email, $fullname, $dob, $sex, $avatar, $is_seller, $is_buyer) 
    {   
        $mobile = !empty($mobile) ? "'$mobile'" : "NULL";
        $email = !empty($email) ? "'$email'" : "NULL";
        $dob = !empty($dob) ? "'$dob'" : "NULL";
        $sex = !empty($sex) ? "'$sex'" : "NULL";
        $avatar = !empty($avatar) ? "'$avatar'" : "NULL";
        $is_buyer = intval($is_buyer);
        $is_seller = intval($is_seller);

        $sql = "call update_user_info('$user_id', $mobile, $email, '$fullname', $sex, $dob, $avatar, $is_seller, $is_buyer)";
        return $this->query($sql);
    }

    function get_shops_managed_by_user($user_id) {
        $sql = "call get_shops_managed_by_user('$user_id')";
        return $this->get_list($sql);
    }

    function search_user_by_username($username) {
        if ($username == '') {
            $username = "'.*'";
        }
        else {
            $username = "'$username'";
        }
        $sql = "select * from the_user where username regexp $username";
        return $this->get_list($sql);
    }

    function get_order_count_all_users($min_order_count) {
        $sql = "call get_order_count_all_users($min_order_count)";
        return $this->get_list($sql);
    }
}

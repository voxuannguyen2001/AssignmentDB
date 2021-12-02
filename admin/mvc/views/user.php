<div class="table-title">All Users</div>

<div class="input-group mt-3 w-50 ">
  <input type="text" class="form-control" placeholder="Search user by username" id="searchuser-input">
  <a class="btn btn-primary" id="searchuser-btn">Seach</a>
</div>

<div class="table-responsive mt-4 table-bordered" id="manage-user">
    <table class="table table-striped table-hover mh-100">
    <thead>
        <tr>
        <th scope="col">User ID</th>
        <th scope="col">UserName</th>
        <th scope="col">Password</th>
        <th scope="col">Mobile</th>
        <th scope="col">Email</th>
        <th scope="col">Fullname</th>
        <th scope="col">Sex</th>
        <th scope="col">Data of birth</th>
        <th scope="col">Avatar</th>
        <th scope="col">Seller</th>
        <th scope="col">Buyer</th>
        <th scope="col">Date Created</th>
        <th scope="col">Action</th>
        </tr>
    </thead>
    <tbody>

        <?php if ($data['userList']) {
        foreach ($data['userList'] as $key => $value) { ?>
            <tr>
            <td><?php echo $value['user_id'] ?> </td>
            <td><?php echo $value['username'] ?></td>
            <td><?php echo $value['pass'] ?></td>
            <td><?php echo $value['mobile'] ?></td>
            <td><?php echo $value['email'] ?></td>
            <td><?php echo $value['fullname'] ?></td>
            <td><?php echo $value['sex'] ?></td>
            <td><?php echo $value['dob'] ?></td>
            <td><?php echo $value['avatar'] ?></td>
            <td><?php echo ($value['seller_flag'] ? 'Yes' : 'No') ?></td>
            <td><?php echo ($value['buyer_flag'] ? 'Yes' : 'No') ?></td>
            <td><?php echo $value['date_created'] ?></td>

            <td>
                <div class="d-flex align-items-center">
                    <a href="<?php echo $DOMAIN ?>/User/deleteUser/<?php echo $value['user_id'] ?>">
                        <button type="button" class="btn btn-danger btn-action">Delete</button>
                    </a>
                    <a href="<?php echo $DOMAIN ?>/User/editUser/<?php echo $value['user_id'] ?>">
                        <button type="button" class="btn btn-success btn-action">Edit</button>
                    </a>
                    <a href="<?php echo $DOMAIN ?>/User/getShops/<?php echo $value['user_id'] ?>">
                        <button type="button" class="btn btn-success btn-action text-nowrap">Get Shops</button>
                    </a>
                </div>
            </td>
            </tr>
        <?php  }
        } ?>
    </tbody>
    </table>
</div>

<div class="user-function-btn mt-3">
    <div class="btn btn-primary btn-lg active">
        <a class="text-light text-decoration-none" role="button" href="<?php echo $DOMAIN ?>/User/removeAll">
        Delete All
        </a>
    </div>
    <div class="btn btn-primary btn-lg active ms-3">
        <a class="text-light text-decoration-none" href="<?php echo $DOMAIN ?>/User/insertUser">
        Add User
        </a>
    </div>
    <div class="btn btn-primary btn-lg active ms-3">
        <a class="text-light text-decoration-none" href="<?php echo $DOMAIN ?>/User/userStats">
        User statistics
        </a>
    </div>
</div>

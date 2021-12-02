<div class="table-title">Shops Managed By Users</div>


<?php if(empty($data['shopList'])): ?>
    <div class="alert alert-info mt-3" role="alert">
        This user does not manage any shops!
    </div>

<?php else: ?>
    <div class="table-responsive" id="manage-user">
        <table class="table table-striped mt-4 table-hover mh-100">
        <thead>
            <tr>
            <th scope="col">Username</th>
            <th scope="col">Fullname</th>
            <th scope="col">Shop name</th>
            <th scope="col">Shop creation date</th>
            <th scope="col">Start date</th>
            </tr>
        </thead>
        <tbody>

            <?php if ($data['shopList']) {
            foreach ($data['shopList'] as $key => $value) { ?>
                <tr>
                <td><?php echo $value['username'] ?> </td>
                <td><?php echo $value['fullname'] ?></td>
                <td><?php echo $value['shop_name'] ?></td>
                <td><?php echo $value['create_date'] ?></td>
                <td><?php echo $value['start_date'] ?></td>

                <!-- <td>
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
                </td> -->
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
        
    </div>
<?php endif; ?>
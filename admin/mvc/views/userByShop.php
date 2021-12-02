<div class="table-title">Products Table</div>

<br />

<div>
    <label for="input-shop_id" class="form-label">Get all users ordered by the number of order from a shop: </label>
    <input type="number" min="1" class="form-control" id="input-shop_id_for_procedure" placeholder="Shop ID" />
    <div class="dropdown">
        <button class="dropbtn btn-Thang_procedure2">Submit</button>
    </div>
</div>

<table class="table table-striped mt-4">
    <thead>
        <tr>
            <th scope="col">User ID</th>
            <th scope="col">UserName</th>
            <th scope="col">Total Num</th>
            <!-- <th scope="col">Action</th> -->
        </tr>
    </thead>
    <tbody>

        <?php if ($data['userList']) {
            foreach ($data['userList'] as $key => $value) { ?>
                <tr>
                    <td><?php echo $value['the_user_id'] ?> </td>
                    <td><?php echo $value['the_username'] ?></td>
                    <td><?php echo $value['total_num'] ?></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <!-- <td style="display:flex">
                        <a class="text-danger" href="<?php echo $DOMAIN ?>/Product/deleteProduct/<?php echo $data['shop']['shop_id'] ?>/<?php echo $value['product_id'] ?>">
                            <button type="button" class="btn btn-danger">Delete</button>
                        </a>
                    </td> -->
                </tr>
        <?php  }
        } ?>
    </tbody>
</table>
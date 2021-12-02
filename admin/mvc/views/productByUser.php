<div class="table-title">Products Table</div>

<br />

<div>
    <label for="input-user_id" class="form-label">Get all products ordered by user in order of price: </label>
    <input type="number" min="1" class="form-control" id="input-user_id_for_procedure" placeholder="User ID"/>
    <div class="dropdown">
        <button class="dropbtn btn-Thang_procedure1">Submit</button>
    </div>
</div>

<table class="table table-striped mt-4">
    <thead>
        <tr>
            <th scope="col">ID</th>
            <th scope="col">Name</th>
            <th scope="col">Listed Price</th>
            <th scope="col">Origin</th>
            <th scope="col">Amount</th>
            <th scope="col">Information</th>
            <!-- <th scope="col">Action</th> -->
        </tr>
    </thead>
    <tbody>

        <?php if ($data['productList']) {
            foreach ($data['productList'] as $key => $value) { ?>
                <tr>
                    <td><?php echo $value['product_id'] ?> </td>
                    <td><?php echo $value['product_name'] ?></td>
                    <td><?php echo $value['listed_price'] ?></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <!-- <td style="display:flex">
                        <a class="text-danger" href="<?php echo $DOMAIN ?>/Product/deleteProduct/<?php echo $data['shop']['shop_id']?>/<?php echo $value['product_id']?>">
                            <button type="button" class="btn btn-danger">Delete</button>
                        </a>
                    </td> -->
                </tr>
        <?php  }
        } ?>
    </tbody>
</table>
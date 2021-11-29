<div class="table-title">All Orders</div>

<br />

<div class="dropdown">
    <button class="dropbtn">Choose the shop</button>
    <div class="dropdown-content">
        <?php if ($data['shopList']) {
            foreach ($data['shopList'] as $key => $value) { ?>
                <a href="<?php echo $DOMAIN ?>/Product/ProductTable/<?php echo $value['shop_id'] ?>"><?php echo $value['shop_name'] ?></a>
        <?php }
        } ?>
    </div>
</div>

<br />

<h2 style="text-align: center;"> <?php echo $data['shop']['shop_name'] ?> Shop</h2>

<table class="table table-striped mt-4">
    <thead>
        <tr>
            <th scope="col">ID</th>
            <th scope="col">Name</th>
            <th scope="col">Listed Price</th>
            <th scope="col">Origin</th>
            <th scope="col">Amount</th>
            <th scope="col">Information</th>
            <th scope="col">Action</th>
        </tr>
    </thead>
    <tbody>

        <?php if ($data['productList']) {
            foreach ($data['productList'] as $key => $value) { ?>
                <tr>
                    <td><?php echo $value['product_id'] ?> </td>
                    <td><?php echo $value['product_name'] ?></td>
                    <td><?php echo $value['listed_price'] ?></td>
                    <td><?php echo $value['origin'] ?></td>
                    <td><?php echo $value['remaining_amount'] ?></td>
                    <td><?php echo $value['information'] ?></td>
                    <td style="display:flex">
                        <a class="text-danger" href="<?php echo $DOMAIN ?>/Product/deleteProduct/<?php echo $data['shop']['shop_id']?>/<?php echo $value['product_id']?>">
                            <button type="button" class="btn btn-danger">Delete</button>
                        </a>
                    </td>
                </tr>
        <?php  }
        } ?>
    </tbody>
</table>
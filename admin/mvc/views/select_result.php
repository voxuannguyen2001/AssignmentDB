<div class="table-title mt-4">Select Result</div>

<table class="table table-striped mt-4">
  <thead>
    <tr>
      <th scope="col">Cart ID</th>
      <th scope="col">User ID</th>
      <th scope="col">Product ID</th>
      <th scope="col">Shop ID</th>
      <th scope="col">Amount</th>
      <th scope="col">Saleprice</th>
    </tr>
  </thead>
  <tbody>

    <?php if ($data) {
      foreach ($data as $key => $value) { ?>
        <tr>
          <td><?php echo $value['cart_id'] ?> </td>
          <td><?php echo $value['the_user_id'] ?></td>
          <td><?php echo $value['product_id'] ?></td>
          <td><?php echo $value['shop_id'] ?></td>
          <td><?php echo $value['product_count'] ?></td>
          <td><?php echo $value['saleprice'] ?></td>
          <td style="display:flex">
            <a class="text-danger" href="<?php echo $DOMAIN ?>/cart_contain_product/delete_ccp/<?php echo $value['cart_id']?>/<?php echo $value['the_user_id']?>/<?php echo $value['product_id']?>/<?php echo $value['shop_id']?>">
              <button type="button" class="btn btn-danger">Delete</button>
            </a>
          </td>
        </tr>
    <?php  }
    } ?>
  </tbody>
</table>
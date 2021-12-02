<div class="table-title">The Order Has: </div>

<table class="table table-striped mt-4">
  <thead>
    <tr>
      <th scope="col">Shop ID</th>
      <th scope="col">Product ID</th>
      <th scope="col">Amount</th>
      <th scope="col">Price</th>
      <th scope="col">Action</th>
    </tr>
  </thead>
  <tbody>

    <?php if ($data['list']) {
      foreach ($data['list'] as $key => $value) { ?>
        <tr>
          <td><?php echo $value['shop_id'] ?> </td>
          <td><?php echo $value['product_id'] ?></td>
          <td><?php echo $value['amount'] ?></td>
          <td><?php echo $value['selling_price'] ?></td>
          <td style="display:flex">
            <a href="<?php echo $DOMAIN ?>/OrderContainsProduct/delete/<?php echo $data['orderID'] ?>/<?php echo $value['shop_id'] ?>/<?php echo $value['product_id'] ?>">
              <button type="button" class="btn btn-danger btn-action">Delete</button>
            </a>
            <a href="<?php echo $DOMAIN ?>/OrderContainsProduct/edit/<?php echo $data['orderID'] ?>/<?php echo $value['shop_id'] ?>/<?php echo $value['product_id'] ?>">
              <button type="button" class="btn btn-success btn-action">Edit</button>
            </a>
          </td>
        </tr>
    <?php  }
    } ?>
  </tbody>
</table>

<div class="manage-order">
  <div class="function-text">
    <a class="text-danger" href="<?php echo $DOMAIN ?>/OrderContainsProduct/removeAll/<?php echo $data['orderID']?>">
      Delete All
    </a>
  </div>
  <div class="function-text">
    <a class="text-primary" href="<?php echo $DOMAIN ?>/OrderContainsProduct/insert/<?php echo $data['orderID']?>">
      Insert New
    </a>
  </div>
</div>

<style>
<div class="table-title">All Orders</div>

<table class="table table-striped mt-4">
  <thead>
    <tr>
      <th scope="col">Order ID</th>
      <th scope="col">Shipping ID</th>
      <th scope="col">Date</th>
      <th scope="col">Name</th>
      <th scope="col">Phone</th>
      <th scope="col">Address</th>
      <th scope="col">Total Price</th>
      <th scope="col">Status</th>
      <th scope="col">Action</th>
    </tr>
  </thead>
  <tbody>

    <?php if ($data['orderList']) {
      foreach ($data['orderList'] as $key => $value) { ?>
        <tr>
          <td><?php echo $value['order_id'] ?> </td>
          <td><?php echo $value['shipping_id'] ?></td>
          <td><?php echo $value['create_date'] ?></td>
          <td><?php echo $value['sname'] ?></td>
          <td><?php echo $value['sphone_number'] ?></td>
          <td><?php echo $value['saddress'] ?></td>
          <td><?php echo $value['total'] ?></td>
          <td><?php echo $value['order_status'] ?></td>
          <td style="display:flex">
            <a href="<?php echo $DOMAIN ?>/Order/deleteOrder/<?php echo $value['order_id'] ?>">
              <button type="button" class="btn btn-danger btn-action">Delete</button>
            </a>
            <a href="<?php echo $DOMAIN ?>/OrderContainsProduct/OrderContainsProductPage/<?php echo $value['order_id'] ?>">
              <button type="button" class="btn btn-success btn-action">View</button>
            </a>
          </td>
        </tr>
    <?php  }
    } ?>
  </tbody>
</table>

<div class="manage-order">
  <div class="function-text">
    <a class="text-danger" href="<?php echo $DOMAIN ?>/Order/removeAll">
      Delete All
    </a>
  </div>
  <div class="function-text">
    <a class="text-primary" href="<?php echo $DOMAIN ?>/Order/insertOrder">
      Insert Oder
    </a>
  </div>
</div>

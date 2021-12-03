<div class="table-title">The Category Has: </div>

<table class="table table-striped mt-4">
  <thead>
    <tr>
      <th scope="col">Shop ID</th>
      <th scope="col">Product ID</th>
      <th scope="col">Category ID</th>
    </tr>
  </thead>
  <tbody>

    <?php if ($data['list']) {
      foreach ($data['list'] as $key => $value) { ?>
        <tr>
          <td><?php echo $value['shop_id'] ?> </td>
          <td><?php echo $value['product_id'] ?></td>
          <td><?php echo $value['category_id'] ?></td>
        </tr>
    <?php  }
    } ?>
  </tbody>
</table>

<div class="manage-order">
  <div class="function-text">
    <a class="text-primary" href="<?php echo $DOMAIN ?>/CategoryContainsProduct/insert/<?php echo $data['categoryID']?>">
      Insert New
    </a>
  </div>
</div>

<style>
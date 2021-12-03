<div class="table-title">All Category</div>

<table class="table table-striped mt-4">
  <thead>
    <tr>
      <th scope="col">Category ID</th>
      <th scope="col">Name Category</th>
      <th scope="col">Total Product</th>
    </tr>
  </thead>
  <tbody>

    <?php if ($data['CategoryList']) {
      foreach ($data['CategoryList'] as $key => $value) { ?>
        <tr>
          <td><?php echo $value['category_id'] ?> </td>
          <td><?php echo $value['name_category'] ?></td>
          <td><?php echo $value['total_product'] ?></td>
          <td style="display:flex">
            <a href="<?php echo $DOMAIN ?>/Category/deleteCategory/<?php echo $value['category_id'] ?>">
              <button type="button" class="btn btn-danger btn-action">Delete</button>
            </a>
            <a href="<?php echo $DOMAIN ?>/CategoryContainsProduct/CategoryContainsProductPage/<?php echo $value['category_id'] ?>">
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
    <a class="text-primary" href="<?php echo $DOMAIN ?>/Category/insertCategory">
      Insert Category
    </a>
  </div>
</div>
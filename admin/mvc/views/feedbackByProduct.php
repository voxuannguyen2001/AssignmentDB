<div class="table-title">All feedbacks</div>
<div>
    <label 
    for="input-product_id" 
    class="form-label">Get all feedbacks of product </label>
    <input 
    type="number" 
    min="1" 
    class="form-control" 
    id="input-product_id_for_procedure" placeholder="Product ID" />
    <div class="dropdown">
      <button class="dropbtn btn-Trang_procedure1">Submit</button>
    </div>
  </div>


<table class="table table-striped mt-4">
  <thead>
    <tr>
      <th scope="col">feedback ID</th>
      <th scope="col">Shop ID</th>
      <th scope="col">Product ID</th>
      <th scope="col">Content</th>
      <th scope="col">Rating</th>
      <th scope="col">Created</th>
      <th scope="col">By User</th>
      <th scope="col">Action</th>
    </tr>
  </thead>
  <tbody>

    <?php if ($data['feedbackList']) {
      foreach ($data['feedbackList'] as $key => $value) { ?>
        <tr>
          <td><?php echo $value['feedback_id'] ?> </td>
          <td><?php echo $value['shop_id'] ?></td>
          <td><?php echo $value['product_id'] ?></td>
          <td><?php echo $value['review_content'] ?></td>
          <td><?php echo $value['rating'] ?></td>
          <td><?php echo $value['create_date'] ?></td>
          <td><?php echo $value['user_id'] ?></td>
          <td>
            <div class="d-flex align-items-center">
              <a class="text-danger" href="<?php echo $DOMAIN ?>/feedback/deletefeedback/<?php echo $value['feedback_id'] ?>">
                <button type="button" class="btn btn-danger">Delete</button>
              </a>
              <a href="<?php echo $DOMAIN ?>/feedback/editFeedback/<?php echo $value['feedback_id'] ?>">
                <button type="button" class="btn btn-success btn-action">Edit</button>
              </a>
              <!-- <a href="<?php echo $DOMAIN ?>/User/getShops/<?php echo $value['feedback_id'] ?>">
                <button type="button" class="btn btn-success btn-action text-nowrap">Get Shops</button>
              </a> -->
            </div>
          </td>

        </tr>

    <?php  }
    } ?>
  </tbody>
</table>


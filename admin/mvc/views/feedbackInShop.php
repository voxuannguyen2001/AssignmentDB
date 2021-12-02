<div class="table-title">All feedbacks in shop</div>
<div class="dropdown">
    <button class="dropbtn">Choose the shop</button>
    <div class="dropdown-content">
        <?php if ($data['shopList']) {
            foreach ($data['shopList'] as $key => $value) { ?>
                <a href="<?php echo $DOMAIN ?>/Feedback/FeedbackInShop/<?php echo $value['shop_id'] ?>"><?php echo $value['shop_name'] ?></a>
        <?php }
        } ?>
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
                    <td style="display:flex">
                        <a class="text-danger" href="<?php echo $DOMAIN ?>/feedback/deletefeedback/<?php echo $value['feedback_id'] ?>">
                            <button type="button" class="btn btn-danger">Delete</button>
                        </a>
                    </td>

                </tr>

        <?php  }
        } ?>
    </tbody>
</table>

<div class="manage-feedback">
    <div class="function-text">
        <a class="text-danger" href="<?php echo $DOMAIN ?>/feedback/removeAll">
            Delete All
        </a>
    </div>
    <div class="function-text">
        <a class="text-primary" href="<?php echo $DOMAIN ?>/feedback/insertFeedback">
            Insert Feedback
        </a>
    </div>
</div>
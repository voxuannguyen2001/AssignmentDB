<div class="table-title">User statitistics</div>


<?php if(empty($data['userStats'])): ?>
    <div class="alert alert-info mt-3" role="alert">
        There are no users whose number of orders is at least <?php echo $data['min_order_count'] ?>
    </div>

<?php else: ?>
    <div class="form-group mt-3">
        <label class="form-label">Minimum Number of Orders: </label>
        <div class="input-group w-50">
            <input type="number" class="form-control" placeholder="0" id="userstats-input">
            <a class="btn btn-primary" id="userstats-btn">Seach</a>
        </div>
    </div>
    <div class="table-responsive">
        <table class="table table-striped mt-4 table-hover mh-100">
        <thead>
            <tr>
            <th scope="col">User ID</th>
            <th scope="col">Username</th>
            <th scope="col">Fullname</th>
            <th scope="col">Number of orders</th>
            <th scope="col">Total money spent</th>
            <th scope="col">Membership</th>

            </tr>
        </thead>
        <tbody>

            <?php if ($data['userStats']) {
            foreach ($data['userStats'] as $key => $value) { ?>
                <tr>
                <td><?php echo $value['user_id'] ?></td>
                <td><?php echo $value['username'] ?></td>
                <td><?php echo $value['fullname'] ?></td>
                <td><?php echo $value['order_count'] ?></td>
                <td><?php echo $value['total_money'] ?></td>
                <td><?php echo $value['membership'] ?></td>

                </tr>
            <?php  }
            } ?>
        </tbody>
        </table>
    </div>
<?php endif; ?>
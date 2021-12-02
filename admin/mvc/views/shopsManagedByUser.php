<div class="table-title">Shops Managed By Users</div>


<?php if(empty($data['shopList'])): ?>
    <div class="alert alert-info mt-3" role="alert">
        This user does not manage any shops!
    </div>

<?php else: ?>
    <div class="table-responsive">
        <table class="table table-striped mt-4 table-hover mh-100">
        <thead>
            <tr>
            <th scope="col">Owner</th>
            <th scope="col">Owner's fullname</th>
            <th scope="col">Shop name</th>
            <th scope="col">Shop creation date</th>
            <th scope="col">Start date</th>
            </tr>
        </thead>
        <tbody>

            <?php if ($data['shopList']) {
            foreach ($data['shopList'] as $key => $value) { ?>
                <tr>
                <td><?php echo $value['username'] ?></td>
                <td><?php echo $value['owner_name'] ?></td>
                <td><?php echo $value['shop_name'] ?></td>
                <td><?php echo $value['create_date'] ?></td>
                <td><?php echo $value['start_date'] ?></td>
                </tr>
            <?php  }
            } ?>
        </tbody>
        </table>
    </div>
<?php endif; ?>
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
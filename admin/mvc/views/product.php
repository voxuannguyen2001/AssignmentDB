<div class="table-title">Products Table</div>

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

<br />
<br />

<div>
    <label for="input-user_id" class="form-label">Get all products ordered by user in order of price: </label>
    <input type="number" min="1" class="form-control" id="input-user_id_for_procedure" placeholder="User ID"/>
    <div class="dropdown">
        <button class="dropbtn btn-Thang_procedure1">Submit</button>
    </div>
</div>

<br />

<div>
    <label for="input-shop_id" class="form-label">Get all users ordered by the number of order from a shop: </label>
    <input type="number" min="1" class="form-control" id="input-shop_id_for_procedure" placeholder="Shop ID"/>
    <div class="dropdown">
        <button class="dropbtn btn-Thang_procedure2">Submit</button>
    </div>
</div>
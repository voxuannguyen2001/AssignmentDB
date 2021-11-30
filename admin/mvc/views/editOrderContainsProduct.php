<div class="table-title">Edit</div>

<br />

<div class="form">
<form action="" onsubmit="return false" id="form_edit-ocp">
        <div class="alert alert-edit-ocp mt-4 mb-4">
            <strong class="alert-edit-ocp-text"></strong>
        </div>
        <div class="row" >
            <div class="col-lg-8 form_edit-ocp">
                <div>
                    <label for="input-order_id" class="form-label">Order ID: </label>
                    <text type="number" class="form-control input-order_id" readonly><?php echo $data['orderID']?></text>
                </div>
                <div>
                    <label for="input-shop_id" class="form-label">Shop ID: </label>
                    <text type="number" class="form-control input-shop_id" readonly><?php echo $data['shopID']?></text>
                </div>
                <div>
                    <label for="input-product_id" class="form-label mt-2">Product ID: </label>
                    <text type="number" class="form-control input-product_id" readonly><?php echo $data['productID']?></text>
                </div>
                <div>
                    <label for="input-amount" class="form-label mt-2">Amount: </label>
                    <input type="number" class="form-control input-amount" />
                </div>
                <div>
                    <label for="input-price" class="form-label mt-2">Price: </label>
                    <input type="text" class="form-control input-price" />
                </div>

                <div class="contain-button">
                    <button class="btn btn-primary btn-edit-ocp mt-3" id = "btn-edit-ocp<?php echo $data['orderID'] ?>/<?php echo $data['shopID'] ?>/<?php echo $data['productID'] ?>">Submit</button>
                </div>
            </div>
        </div>

    </form>
</div>
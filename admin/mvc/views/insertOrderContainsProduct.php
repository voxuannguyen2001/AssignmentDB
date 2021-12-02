<div class="table-title">Insert new order contains product</div>

<br />

<div class="form">
<form action="" onsubmit="return false" id="form_insert-ocp">
        <div class="alert alert-edit-ocp mt-4 mb-4">
            <strong class="alert-edit-ocp-text"></strong>
        </div>
        <div class="row" >
            <div class="col-lg-8 form_insert-ocp">
                <div>
                    <label for="input-order_id" class="form-label">Order ID: </label>
                    <input type="number" class="form-control input-order_id" />
                </div>
                <div>
                    <label for="input-shop_id" class="form-label">Shop ID: </label>
                    <input type="number" class="form-control input-shop_id" />
                <div>
                    <label for="input-product_id" class="form-label mt-2">Product ID: </label>
                    <text type="number" class="form-control input-product_id">
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
                    <button class="btn btn-primary btn-edit-ocp mt-3" id = "btn-insert-ocp">Insert New</button>
                </div>
            </div>
        </div>

    </form>
</div>
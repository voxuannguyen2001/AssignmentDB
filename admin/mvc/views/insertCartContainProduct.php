<div class="table-title">Insert record into Carts contain Products</div>

<br />

<div class="form">
<form action="" onsubmit="return false" id="form_insert_ccp">
        <div class="alert alert-insert-ccp mt-4 mb-4">
            <strong class="alert-insert-ccp-text"></strong>
        </div>
        <div class="row">
            <div class="col-lg-8 form_insert_record_ccp">
                <div>
                    <label for="input-cart_id" class="form-label">Cart ID: </label>
                    <input type="number" min="1" class="form-control input-cart_id" />
                </div>
                <div>
                    <label for="input-user_id" class="form-label mt-2">User ID: </label>
                    <input type="number" min="1" class="form-control input-user_id" />
                </div>
                <div>
                    <label for="input-product_id" class="form-label mt-2">Product ID: </label>
                    <input type="number" min="1" class="form-control input-product_id" />
                </div>
                <div>
                    <label for="input-shop_id" class="form-label mt-2">Shop ID: </label>
                    <input type="number" class="form-control input-shop_id" />
                </div>
                <div>
                    <label for="input-product_count" class="form-label mt-2">Amount: </label>
                    <input type="number" min="1" max="10" class="form-control input-product_count" />
                </div>
                <div>
                    <label for="input-saleprice" class="form-label mt-2">Saleprice: </label>
                    <input type="number" class="form-control input-saleprice" />
                </div>

                <div class="contain-button">
                    <button class="btn btn-primary btn-insert-cpp mt-3">Insert New</button>
                </div>
            </div>
        </div>

    </form>
</div>
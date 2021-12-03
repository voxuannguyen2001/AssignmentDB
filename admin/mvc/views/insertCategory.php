<div class="table-title">Insert Category</div>

<br />

<div class="form">
    <form action="" onsubmit="return false" id="form_insert_order">

        <div class="alert alert-insert-order mt-4 mb-4">
            <strong class="alert-insert-order-text"></strong>
        </div>

        <div class="row">
            <div class="col-lg-8 form_insert_order">
                <div>
                    <label for="input-shipping_id" class="form-label">Category ID: </label>
                    <input type="number" min="190" class="form-control input-shipping_id" />
                </div>
                <div>
                    <label for="input-create_date" class="form-label mt-2">Name Category: </label>
                    <input type="text" class="form-control input-create_date" />
                </div>
                <div>
                    <label for="input-the_user_id" class="form-label mt-2">Total Product: </label>
                    <input type="number" min="1" class="form-control input-the_user_id" />
                </div>
                
                <div class="contain-button">
                    <button class="btn btn-primary btn-insert-order mt-3">Insert New</button>
                </div>
            </div>
        </div>
    </form>
</div>
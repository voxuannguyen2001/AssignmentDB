<div class="table-title">Insert Category</div>

<br />

<div class="form">
    <form action="" onsubmit="return false" id="form_insert_category">

        <div class="alert alert-insert-category mt-4 mb-4">
            <strong class="alert-insert-category-text"></strong>
        </div>

        <div class="row">
            <div class="col-lg-8 form_insert_category">
                <div>
                    <label for="input-category_id" class="form-label">Category ID: </label>
                    <input type="number" min="1" class="form-control input-category_id" />
                </div>
                <div>
                    <label for="input-name_category" class="form-label mt-2">Name Category: </label>
                    <input type="text" class="form-control input-name_category" />
                </div>
                <div>
                    <label for="input-total_product" class="form-label mt-2">Total Product: </label>
                    <input type="number" min="1" class="form-control input-total_product" />
                </div>
                
                <div class="contain-button">
                    <button class="btn btn-primary btn-insert-category mt-3">Insert New</button>
                </div>
            </div>
        </div>
    </form>
</div>
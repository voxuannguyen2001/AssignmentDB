<div class="table-title">Add feedback</div>

<br />


<div class="container">
      <form 
      id="form_insert_feedback"
      action=""
      method="post" 
      enctype="multipart/form-data" 
      onsubmit="return false">
      </div>
        <div class="alert alert-insert-feedback mt-4 mb-4">
        <strong class="alert-insert-feedback-text"></strong>
      </div>
        <!-- <div class="col-xs-6 form-group">
          <label class="form-label mt-2" for="name">Shop id:</label>
          <div class="col-xs-6">
            <input type="number" class="form-control" name="shop_id" id="name">
          </div>
        </div> -->
        <div class="col-md-8 form_insert_feedback">
        <div class="col-xs-6 form-group">
          <label class="form-label mt-2" for="email">Product id:</label>
          <div class="col-xs-6">
            <input 
            type="number" 
            class="form-control" 
            name="product_id" 
            id="addfeedback-product_id"
            required/>
          </div>
        </div>
        <div class="col-xs-6 form-group">
          <label 
          class="form-label mt-2" 
          for="contact"
          >Content:</label>
          <div class="col-xs-6">
            <input 
            type="text" 
            class="form-control" 
            name="review_content" 
            id="addfeedback-review_content"
            required/>
          </div>
        </div>
        <div class="col-xs-6 form-group">
          <label class="form-label mt-2" for="contact">Rating(0-5):</label>
          <div class="col-xs-6">
            <input 
            type="number" 
            class="form-control" 
            name="rating" 
            id="addfeedback-rating"
            required/>
          </div>
        </div>

        <div class="col-xs-6 form-group">
          <label class="form-label mt-2" for="contact">By User:</label>
          <div class="col-xs-6">
            <input 
            type="number" 
            class="form-control" 
            name="user_id" 
            id="addfeedback-user_id"
            required/>
          </div>
        </div>

        <div class="col-xs-6 form-group">
          <div class="col-sm-offset-2 col-xs-6">
            <button 
            type="submit" 
            class="btn btn-primary btn-insert-feedback mt-3" 
            value="submit" 
            name="submit">Add new</button>

          </div>

    </div>
      </form>

</div>
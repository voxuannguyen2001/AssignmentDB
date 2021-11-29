<div class="table-title">Add feedback</div>

<br />


<div class="container">
  <div class="row clearfix">
    <div class="col-md-12 column">

      <form action="edit_submit" method="post" enctype="multipart/form-data" onsubmit="return confirm('Do you really want to submit the form?');">

        <div class="col-xs-6 form-group">
          <label class="form-label mt-2" for="name">Shop id:</label>
          <div class="col-xs-6">
            <input type="number" class="form-control" name="shop_id" id="name">
          </div>
        </div>
        <div class="col-xs-6 form-group">
          <label class="form-label mt-2" for="email">Product id:</label>
          <div class="col-xs-6">
            <input type="number" class="form-control" name="product_id" id="email">
          </div>
        </div>
        <div class="col-xs-6 form-group">
          <label class="form-label mt-2" for="contact">Content:</label>
          <div class="col-xs-6">
            <input type="text" class="form-control" name="review_content" id="contact">
          </div>
        </div>
        <div class="col-xs-6 form-group">
          <label class="form-label mt-2" for="contact">Rating(0-5):</label>
          <div class="col-xs-6">
            <input type="number" class="form-control input-calories" name="rating" id="contact">
          </div>
        </div>

        <div class="col-xs-6 form-group">
          <label class="form-label mt-2" for="contact">By User:</label>
          <div class="col-xs-6">
            <input type="number" class="form-control input-calories" name="user_id" id="contact">
          </div>
        </div>

        <div class="col-xs-6 form-group">
          <div class="col-sm-offset-2 col-xs-6">
            <button type="submit" class="btn btn-primary mt-3" value="submit" name="submit">Submit</button>

          </div>
        </div>
      </form>
    </div>
  </div>
</div>
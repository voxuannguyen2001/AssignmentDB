<div class="table-title">Edit Feedback</div>

<br />

<div class="form-container">
  <form 
  id="form_edit_feedback" 
  action="" 
  onsubmit="return false">
  <div class="alert alert-edit-feedback mt-4 mb-4">
      <strong class="alert-edit-feedback-text"></strong>
    </div>
    <div class="row justify-content-center">
      <div class="col-md-8 form_edit_feedback">
        <div>
          <label class="form-label mt-2">Feedback ID <span style="color: red">*</span> </label>
          <input 
          type="text" 
          class="form-control"     
          id="editfeedback-fid"       
          readonly value="<?php echo $data['feedback']['feedback_id'] ?>" />
        </div>
        <div>
          <label class="form-label mt-2">Product ID <span style="color: red">*</span> </label>
          <input 
          type="text" 
          class="form-control" 
          id="editfeedback-pid" 
          readonly value="<?php echo $data['feedback']['product_id'] ?>" />
        </div>
        <div>
          <label class="form-label mt-2">Review content </label>
          <input 
          type="text" 
          class="form-control"
           
           id="editfeedback-review_content" 
           value="<?php echo $data['feedback']['review_content'] ?>" />
        </div>
        <div>
          <label class="form-label mt-2">Rating </label>
          <input 
          type="number" 
          class="form-control" 
          id="editfeedback-rating" 
          value="<?php echo $data['feedback']['rating'] ?>" />
        </div>
        <div>
          <label class="form-label mt-2">By User </label>
          <input 
          type="number" 
          class="form-control" 
          value="<?php echo $data['feedback']['user_id'] ?>" />
        </div>

        </div>

        <div class="contain-button">
          <button class="btn btn-primary btn-edit-feedback mt-3" type="submit">Save Feedback</button>
        </div>
      </div>
    </div>


  </form>

</div>
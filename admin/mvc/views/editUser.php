<div class="table-title">Edit user</div>

<br />

<div class="form-container">
    <form id="form_edit_user" action="" onsubmit="return false">
        <div class="row justify-content-center">
            <div class="col-md-8 form_edit_user">
                <div>
                    <label class="form-label mt-2">Username <span style="color: red">*</span> </label>
                    <input type="text" class="form-control" id="edituser-username" readonly  value="<?php echo $data['user']['username'] ?>"/>
                </div>
                <div>
                    <label class="form-label mt-2">Fullname <span style="color: red">*</span> </label>
                    <input type="text" class="form-control" id="edituser-fullname" 
                    value="<?php echo $data['user']['fullname'] ?>"/>
                </div>
                <div>
                    <label class="form-label mt-2">Mobile </label>
                    <input type="text" class="form-control" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(.*)\./g, '$1');" id="edituser-mobile" 
                        value="<?php echo $data['user']['mobile'] ?>"/>
                </div>
                <div>
                    <label class="form-label mt-2">Email </label>
                    <input type="text" class="form-control" id="edituser-email"
                        value="<?php echo $data['user']['email']?>"/>
                </div>

                <div>
                    <label class="form-label mt-2" for="birthday">Date of birth</label>
                    <input class="form-control" type="date" id="edituser-dob" name="birthday"
                        value="<?php echo $data['user']['dob'] ?>">
                </div>

                <div>
                    <label class="form-label mt-2" for="user-avatar">Select Avatar:</label>
                    <input class="form-control" type="file" id="edituser-avatar" name="user-avatar" accept="image/*">
                </div>

                <div>
                    <label class="form-label mt-2">Sex</label>
                    <div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input edituser-sex" type="radio" name="Sex" id="edituser-sex-male" value="M"
                                <?php echo ($data['user']['sex'] == 'M') ? "checked" : "" ; ?>>
                            <label class="form-check-label" for="edituser-sex-male">
                                Male
                            </label>
                        </div>

                        <div class="form-check form-check-inline">
                            <input class="form-check-input edituser-sex" type="radio" name="Sex" id="edituser-sex-female" value="F"
                                <?php echo ($data['user']['sex'] == 'F') ? "checked" : "" ; ?>>
                            <label class="form-check-label" for="edituser-sex-female">
                                Female
                            </label>
                        </div>
                    </div>
                </div>

                <div>
                    <label class="form-label mt-2">User type</label>
                    <div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input edituser-usertype" type="checkbox" value="" id="edituser-usertype-buyer" 
                            <?php echo ($data['user']['buyer_flag'] == true) ? "checked" : "" ; ?> >
                            <label class="form-check-label" for="edituser-usertype-buyer">
                                Buyer
                            </label>
                        </div>

                        <div class="form-check form-check-inline">
                            <input class="form-check-input edituser-usertype" type="checkbox" value="" id="edituser-usertype-seller"
                            <?php echo ($data['user']['seller_flag'] == true) ? "checked" : "" ; ?>>
                            <label class="form-check-label" for="edituser-usertype-seller">
                                Seller
                            </label>
                        </div>
                    </div>
                </div>

                <div class="contain-button">
                    <button class="btn btn-primary btn-edit-user mt-3" type="submit">Edit User</button>
                </div>
            </div>
        </div>

        <div class="alert alert-edit-user mt-4 mb-4">
            <strong class="alert-edit-user-text"></strong>
        </div>
    </form>

</div>
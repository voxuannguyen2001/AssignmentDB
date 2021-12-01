<div class="table-title">Add a new user</div>

<br />

<div class="form-container">
    <form id="form_insert_user" action="" onsubmit="return false">
        <div class="row justify-content-center">
            <div class="col-md-8 form_insert_user">
                <div>
                    <label class="form-label mt-2">Username <span style="color: red">*</span> </label>
                    <input type="text" class="form-control" id="adduser-username" required/>
                </div>
                <div>
                    <label class="form-label mt-2">Password <span style="color: red">*</span></label>
                    <input type="password" class="form-control" id="adduser-password" required/>
                </div>
                <div>
                    <label class="form-label mt-2">Fullname <span style="color: red">*</span> </label>
                    <input type="text" class="form-control" id="adduser-fullname" required/>
                </div>
                <div>
                    <label class="form-label mt-2">Mobile </label>
                    <input type="text" class="form-control" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(.*)\./g, '$1');" id="adduser-mobile"/>
                </div>
                <div>
                    <label class="form-label mt-2">Email </label>
                    <input type="text" class="form-control" id="adduser-email"/>
                </div>

                <div>
                    <label class="form-label mt-2" for="birthday">Date of birth</label>
                    <input class="form-control" type="date" id="adduser-dob" name="birthday">
                </div>
                
                <div>
                    <label class="form-label mt-2">Sex: </label>
                    <div class="form-check">
                    <input class="form-check-input adduser-sex" type="radio" name="Sex" id="Male" value="M">
                    <label class="form-check-label" for="Male">
                        Male
                    </label>
                    </div>
                    <div class="form-check">
                    <input class="form-check-input adduser-sex" type="radio" name="Sex" id="Female" value="F">
                    <label class="form-check-label" for="Female">
                        Female
                    </label>
                    </div>
                </div>

                <div>
                    <label class="form-label mt-2" for="user-avatar">Select Avatar:</label>
                    <input class="form-control" type="file" id="adduser-avatar" name="user-avatar" accept="image/*">
                </div>
                <div class="contain-button">
                    <button class="btn btn-primary btn-insert-user mt-3" type="submit">Add New User</button>
                </div>
            </div>
        </div>

        <div class="alert alert-insert-user mt-4 mb-4">
            <strong class="alert-insert-user-text"></strong>
        </div>
    </form>

</div>
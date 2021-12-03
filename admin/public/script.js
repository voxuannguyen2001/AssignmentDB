$(document).ready(function () {
  var DOMAIN = "http://localhost/AssignmentDB/admin";

  //ajax insert new order
  $(".alert-insert-order").fadeOut();
  $(".btn-insert-order").click(function () {
    $.ajax({
      url: DOMAIN + "/Order/doInsertOrder",
      method: "post",
      data: {
        shipping_id: parseInt($(".input-shipping_id").val()),
        create_date: $(".input-create_date").val(),
        the_user_id: parseInt($(".input-the_user_id").val()),
        sname: $(".input-sname").val(),
        sphone_number: $(".input-sphone_number").val(),
        saddress: $(".input-saddress").val(),
        status: $(".input-status").val(),
      },
      success: function (result) {
        if (result == "failed") {
          $(".alert-insert-order").addClass("alert-danger");
          $(".alert-insert-order-text").text("Failed!! You should fill all inputs");
          $(".alert-insert-order").fadeIn();
          setTimeout(function () {
            $(".alert-insert-order").fadeOut();
            $(".alert-insert-order-text").text("");
            $(".alert-insert-order").removeClass("alert-danger");
          }, 1500);

        } else if (result == "1") {
          $(".alert-insert-order").fadeIn();
          $(".alert-insert-order").addClass("alert-success");
          $(".alert-insert-order-text").text("Success!!");
          setTimeout(function () {
            $(".alert-insert-order").fadeOut();
            $(".alert-insert-order").removeClass("alert-success");
            $(".alert-insert-order-text").text("");
          }, 1500);
        } else {
          $(".alert-insert-order").addClass("alert-danger");
          $(".alert-insert-order-text").text("Error! Can't add into database");
          $(".alert-insert-order").fadeIn();
          setTimeout(function () {
            $(".alert-insert-order").fadeOut();
            $(".alert-insert-order-text").text("");
            $(".alert-insert-order").removeClass("alert-danger");
          }, 1500);
        }
        $("#form_insert_order")[0].reset();
      },
      error: function () { },
    });
  });
  //end ajax insert order

  //ajax insert new record into cart_contain_product
  $(".alert-insert-ccp").fadeOut();
  $(".btn-insert-ccp").click(function () {
    $.ajax({
      url: DOMAIN + "/cart_contain_product/doInsert_ccp",
      method: "post",
      data: {
        cart_id: $(".input-cart_id").val(),
        the_user_id: $(".input-user_id").val(),
        product_id: $(".input-product_id").val(),
        shop_id: $(".input-shop_id").val(),
        product_count: $(".input-product_count").val(),
        saleprice: $(".input-saleprice").val(),
      },
      success: function (result) {
        if (result == "failed") {
          $(".alert-insert-ccp").addClass("alert-danger");
          $(".alert-insert-ccp-text").text("Failed!! You should fill all input");
          $(".alert-insert-ccp").fadeIn();
          setTimeout(function () {
            $(".alert-insert-ccp").fadeOut();
            $(".alert-insert-ccp-text").text("");
            $(".alert-insert-ccp").removeClass("alert-danger");
          }, 1500);

        } else if (result == "1") {
          $(".alert-insert-ccp").fadeIn();
          $(".alert-insert-ccp").addClass("alert-success");
          $(".alert-insert-ccp-text").text("Success!!");
          setTimeout(function () {
            $(".alert-insert-ccp").fadeOut();
            $(".alert-insert-ccp").removeClass("alert-success");
            $(".alert-insert-ccp-text").text("");
          }, 1500);
        } else {
          $(".alert-insert-ccp").addClass("alert-danger");
          $(".alert-insert-ccp-text").text("Error! Can't add into database");
          $(".alert-insert-ccp").fadeIn();
          setTimeout(function () {
            $(".alert-insert-ccp").fadeOut();
            $(".alert-insert-ccp-text").text("");
            $(".alert-insert-ccp").removeClass("alert-danger");
          }, 1500);
        }
        $("#form_insert_ccp")[0].reset();
      },
      error: function () { },
    });
  });
  //end ajax insert new record into cart_contain_product

  //ajax edit order_contains_product
  $(".alert-edit-ocp").fadeOut();
  $(".btn-edit-ocp").click(function () {
    var link = $(this).attr("id");
    link = link.substr(12, 999);
    $.ajax({
      url: DOMAIN + "/OrderContainsProduct/doEdit/" + link,
      method: "post",
      data: {
        amount: $(".input-amount").val(),
        price: $(".input-price").val(),
      },
      success: function (result) {
        if (result == "failed") {
          $(".alert-edit-ocp").addClass("alert-danger");
          $(".alert-edit-ocp-text").text("Failed!! You should fill all input");
          $(".alert-edit-ocp").fadeIn();
          setTimeout(function () {
            $(".alert-edit-ocp").fadeOut();
            $(".alert-edit-ocp-text").text("");
            $(".alert-edit-ocp").removeClass("alert-danger");
          }, 1500);

        } else if (result == "1") {
          $(".alert-edit-ocp").fadeIn();
          $(".alert-edit-ocp").addClass("alert-success");
          $(".alert-edit-ocp-text").text("Success!!");
          setTimeout(function () {
            $(".alert-edit-ocp").fadeOut();
            $(".alert-edit-ocp").removeClass("alert-success");
            $(".alert-edit-ocp-text").text("");
          }, 1500);
        } else {
          $(".alert-edit-ocp").addClass("alert-danger");
          $(".alert-edit-ocp-text").text("Error! The values invalid");
          $(".alert-edit-ocp").fadeIn();
          setTimeout(function () {
            $(".alert-edit-ocp").fadeOut();
            $(".alert-edit-ocp-text").text("");
            $(".alert-edit-ocp").removeClass("alert-danger");
          }, 1500);
        }
        $("#form_edit-ocp")[0].reset();
      },
      error: function () { },
    });
  });
  //end edit order_contains_product

  //Thang_procedure1
  $(".btn-Thang_procedure1").click(function () {
    let userID = $("#input-user_id_for_procedure").val();
    window.location = ("http://localhost/AssignmentDB/admin/Product/ProductByUser/" + userID);
  })
  //Thang_procedure1

  //Thang_procedure2
  $(".btn-Thang_procedure2").click(function () {
    let shopID = $("#input-shop_id_for_procedure").val();
    window.location = ("http://localhost/AssignmentDB/admin/User/UserByShop/" + shopID);
  })
  //Thang_procedure2

  // add user
  $(".alert-insert-user").fadeOut();
  $(".btn-insert-user").click(function () {
    const username = $("#adduser-username").val();
    const password = $("#adduser-password").val();
    const mobile = $("#adduser-mobile").val();
    const email = $("#adduser-email").val();
    const fullname = $("#adduser-fullname").val();
    const dob = $("#adduser-dob").val();
    const sex = $(".adduser-sex:checked").val();
    const avatar = $("#adduser-avatar").val();
    const is_buyer = ($("#adduser-usertype-buyer").is(':checked') ? 1 : 0);
    const is_seller = ($("#adduser-usertype-seller").is(':checked') ? 1 : 0);

    let body = {
      username,
      password,
      mobile,
      email,
      fullname,
      dob,
      sex,
      avatar,
      is_buyer,
      is_seller
    }

    console.log(body);

    if (!(body.username && body.password && body.fullname)) {
      $(".alert-insert-user").addClass("alert-danger");
      $(".alert-insert-user-text").text("Failed!! You should fill all required input");
      $(".alert-insert-user").fadeIn();
      setTimeout(function () {
        $(".alert-insert-user").fadeOut();
        $(".alert-insert-user-text").text("");
        $(".alert-insert-user").removeClass("alert-danger");
      }, 1500);
      return;
    }
    Object.keys(body).forEach(key => {
      if (!body[key])
        body[key] = null;
    })

    $.ajax({
      url: DOMAIN + "/User/doInsertUser",
      method: "post",
      data: body,
      success: function (result) {
        if (result == "1") {
          $(".alert-insert-user").fadeIn();
          $(".alert-insert-user").addClass("alert-success");
          $(".alert-insert-user-text").text("Success!!");
          setTimeout(function () {
            $(".alert-insert-user").fadeOut();
            $(".alert-insert-user").removeClass("alert-success");
            $(".alert-insert-user-text").text("");
          }, 1500);
          $("#form_insert_user")[0].reset();
        } else {
          $(".alert-insert-user").addClass("alert-danger");
          $(".alert-insert-user-text").text(result);
          $(".alert-insert-user").fadeIn();
          setTimeout(function () {
            $(".alert-insert-user").fadeOut();
            $(".alert-insert-user-text").text("");
            $(".alert-insert-user").removeClass("alert-danger");
          }, 1500);
        }
      },
      error: function () { },
    });
  });

  // edit user
  $(".alert-edit-user").fadeOut();
  $(".btn-edit-user").click(function () {
    let mobile = $("#edituser-mobile").val();
    let email = $("#edituser-email").val();
    let fullname = $("#edituser-fullname").val();
    let dob = $("#edituser-dob").val();
    let sex = $(".edituser-sex:checked").val();
    let avatar = $("#edituser-avatar").val();
    const is_buyer = ($("#edituser-usertype-buyer").is(':checked') ? 1 : 0);
    const is_seller = ($("#edituser-usertype-seller").is(':checked') ? 1 : 0);

    let url_string = window.location.href;
    let user_id = url_string.slice(url_string.lastIndexOf('/') + 1);

    let body = {
      user_id,
      mobile,
      email,
      fullname,
      dob,
      sex,
      avatar,
      is_buyer,
      is_seller
    }

    Object.keys(body).forEach(key => {
      if (!body[key])
        body[key] = null;
    })

    console.log(body);


    if (!body.fullname) {
      $(".alert-edit-user").addClass("alert-danger");
      $(".alert-edit-user-text").text("Failed!! You should fill all required input");
      $(".alert-edit-user").fadeIn();
      setTimeout(function () {
        $(".alert-edit-user").fadeOut();
        $(".alert-edit-user-text").text("");
        $(".alert-edit-user").removeClass("alert-danger");
      }, 1500);
      return;
    }

    $.ajax({
      url: DOMAIN + "/User/doEditUserInfo",
      method: "post",
      data: body,
      success: function (result) {
        if (result == "1") {
          $(".alert-edit-user").fadeIn();
          $(".alert-edit-user").addClass("alert-success");
          $(".alert-edit-user-text").text("Success!!");
          setTimeout(function () {
            $(".alert-edit-user").fadeOut();
            $(".alert-edit-user").removeClass("alert-success");
            $(".alert-edit-user-text").text("");
          }, 1500);
          $("#form_edit_user")[0].reset();
        } else {
          $(".alert-edit-user").addClass("alert-danger");
          $(".alert-edit-user-text").text(result);
          $(".alert-edit-user").fadeIn();
          setTimeout(function () {
            $(".alert-edit-user").fadeOut();
            $(".alert-edit-user-text").text("");
            $(".alert-edit-user").removeClass("alert-danger");
          }, 1500);
        }
      },
      error: function () { },
    });
  });

  $(".alert-insert-feedback").fadeOut();
  $(".btn-insert-feedback").click(function () {
    const product_id = $("#addfeedback-product_id").val();
    const review_content = $("#addfeedback-review_content").val();
    const rating = $("#addfeedback-rating").val();
    const user_id = $("#addfeedback-user_id").val();

    let body = {
      product_id,
      review_content,
      rating,
      user_id
    }

    console.log(body);

    if (!(body.product_id && body.review_content && body.rating && body.user_id)) {
      $(".alert-insert-feedback").addClass("alert-danger");
      $(".alert-insert-feedback-text").text("Failed!! You should fill all required input");
      $(".alert-insert-feedback").fadeIn();
      setTimeout(function () {
        $(".alert-insert-feedback").fadeOut();
        $(".alert-insert-feedback-text").text("");
        $(".alert-insert-feedback").removeClass("alert-danger");
      }, 1500);
      return;
    }
    Object.keys(body).forEach(key => {
      if (!body[key])
        body[key] = null;
    })
    $.ajax({
      url: DOMAIN + "/Feedback/doInsertFeedback",
      method: "post",
      data: body,
      success: function (result) {
        if (result == "1") {
          $(".alert-insert-feedback").fadeIn();
          $(".alert-insert-feedback").addClass("alert-success");
          $(".alert-insert-feedback-text").text("Success!!");
          setTimeout(function () {
            $(".alert-insert-feedback").fadeOut();
            $(".alert-insert-feedback").removeClass("alert-success");
            $(".alert-insert-feedback-text").text("");
          }, 1500);
          $("#form_insert_feedback")[0].reset();
        } else {
          $(".alert-insert-feedback").addClass("alert-danger");
          $(".alert-insert-feedback-text").text(result);
          $(".alert-insert-feedback").fadeIn();
          setTimeout(function () {
            $(".alert-insert-feedback").fadeOut();
            $(".alert-insert-feedback-text").text("");
            $(".alert-insert-feedback").removeClass("alert-danger");
          }, 1500);
        }
      },
      error: function () { },
    });
  });
  $(".alert-edit-feedback").fadeOut();
  $(".btn-edit-feedback").click(function () {
    let review_content = $("#editfeedback-review_content").val();
    let rating = $("#editfeedback-rating").val();

    let url_string = window.location.href;
    let feedback_id = url_string.slice(url_string.lastIndexOf('/') + 1);

    let body = {
      feedback_id,
      review_content,
      rating
    }

    Object.keys(body).forEach(key => {
      if (!body[key])
        body[key] = null;
    })

    console.log(body);
    $.ajax({
      url: DOMAIN + "/feedback/doEditFeedback",
      method: "post",
      data: body,
      success: function (result) {
        if (result == "1") {
          $(".alert-edit-feedback").fadeIn();
          $(".alert-edit-feedback").addClass("alert-success");
          $(".alert-edit-feedback-text").text("Success!!");
          setTimeout(function () {
            $(".alert-edit-feedback").fadeOut();
            $(".alert-edit-feedback").removeClass("alert-success");
            $(".alert-edit-feedback-text").text("");
          }, 1500);
          $("#form_edit_feedback")[0].reset();
        } else {
          $(".alert-edit-feedback").addClass("alert-danger");
          $(".alert-edit-feedback-text").text(result);
          $(".alert-edit-feedback").fadeIn();
          setTimeout(function () {
            $(".alert-edit-feedback").fadeOut();
            $(".alert-edit-feedback-text").text("");
            $(".alert-edit-feedback").removeClass("alert-danger");
          }, 1500);
        }
      },
      error: function () { },
    });
  });
  $(".btn-Trang_procedure1").click(function () {
    let pID = $("#input-product_id_for_procedure").val();
    console.log(pID);
    window.location = ("http://localhost/AssignmentDB/admin/Feedback/FeedbackByProduct/" + pID);
  })
  // search user

  $("#searchuser-btn").click(async () => {
    let url = DOMAIN + '/User/searchUser/' + $("#searchuser-input").val();
    window.location = url;
  })
});

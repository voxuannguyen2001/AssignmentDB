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
                saddress: $(".input-saddress").val(),
                status: $(".input-status").val(),
            },
            success: function (result) {
                if (result == "failed") {
                    $(".alert-insert-order").addClass("alert-danger");
                    $(".alert-insert-order-text").text("Failed!! You should fill all input");
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
                    //reset form and image
                    $("#form_insert_order")[0].reset();
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
            },
            error: function () { },
        });
    });
    //end ajax insert order
});


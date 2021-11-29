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
});


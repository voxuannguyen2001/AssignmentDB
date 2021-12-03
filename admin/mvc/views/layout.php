<?php
$DOMAIN = 'http://localhost/AssignmentDB/admin';
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="<?php echo $DOMAIN ?>/public/bootstrap5/bootstrap.min.css" />
    <link rel="stylesheet" href="<?php echo $DOMAIN ?>/public/font-awesome/css/font-awesome.min.css" />
    <script src="<?php echo $DOMAIN ?>/public/bootstrap5/jquery.min.js"></script>
    <script src="<?php echo $DOMAIN ?>/public/bootstrap5/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href=" <?php echo $DOMAIN ?>/public/style.css" />
    <script src="<?php echo $DOMAIN ?>/public/script.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    <title>Admin</title>
</head>

<body>
    <div class="header">
        <h1> <?php if ($data['render'] == 'order' || $data['render'] == 'insertOrder' || $data['render'] == 'orderContainsProduct') echo "Manage Orders"; 
                    else if ($data['render'] == 'feedback') echo "Feedback";
                    else if ($data['render'] == 'product') echo "Manage Products";
                    else if ($data['render'] == 'ccp') echo "Manage Product in User's cart";
                    else if ($data['render'] == 'user' || $data['render'] == 'shopsManagedByUser' 
                    || $data['render'] == 'insertUser' || $data['render'] == 'userStats') echo 'Manage Users';
                    else if ($data['render'] == 'category' || $data['render'] == 'insertCategory') echo "Category";
                    
                ?>
        </h1>
    </div>
    <div class="container">
        <div class="row mt-3">
            <div class="col-lg-3 col-md-4 task">
                <div class="title">TASK</div>
                <form action="<?php echo $DOMAIN ?>/Order/OrderPage">
                    <button class="order add-item bg-secondary mt-2 text-light">Manage Orders</button>
                </form>
                <form action="<?php echo $DOMAIN ?>/Feedback/FeedbackPage">
                    <button class="order add-item bg-secondary mt-2 text-light">Manage Feedback</button>
                </form>
                <form action="<?php echo $DOMAIN ?>/Product/ProductPage">
                    <button class="order add-item bg-secondary mt-2 text-light">Manage Products</button>
                </form>
                <form action="<?php echo $DOMAIN ?>/cart_contain_product/cart_contain_product_page">
                    <button class="order add-item bg-secondary mt-2 text-light">Manage Product in cart</button>
                </form>
                <form action="<?php echo $DOMAIN ?>/User/UserPage">
                    <button class="order add-item bg-secondary mt-2 text-light">Manage User</button>
                </form>
                <form action="<?php echo $DOMAIN ?>/Category/CategoryPage">
                    <button class="order add-item bg-secondary mt-2 text-light">Category</button>
                </form>
                <!-- Add new form here -->
            </div>

            <div class="col-lg-9 col-md-8 action">
                <?php require_once $data['render'] . '.php' ?>
            </div>
        </div>
    </div>
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
</body>

</html>

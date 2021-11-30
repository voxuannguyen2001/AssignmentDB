<div class="table-title mb-4">Manage Product in User's cart</div>

<a class="text-primary" href="<?php echo $DOMAIN ?>/cart_contain_product/cart_contain_product_page">
              <button type="button" class="btn btn-primary">REFRESH</button>
</a>

<table class="table table-striped mt-4">
  <thead>
    <tr>
      <th scope="col">Cart ID</th>
      <th scope="col">User ID</th>
      <th scope="col">Product ID</th>
      <th scope="col">Shop ID</th>
      <th scope="col">Amount</th>
      <th scope="col">Saleprice</th>
    </tr>
  </thead>
  <tbody>

    <?php if ($data['ccpList']) {
      foreach ($data['ccpList'] as $key => $value) { ?>
        <tr>
          <td><?php echo $value['cart_id'] ?> </td>
          <td><?php echo $value['the_user_id'] ?></td>
          <td><?php echo $value['product_id'] ?></td>
          <td><?php echo $value['shop_id'] ?></td>
          <td><?php echo $value['product_count'] ?></td>
          <td><?php echo $value['saleprice'] ?></td>
          <td style="display:flex">
            <a class="text-danger" href="<?php echo $DOMAIN ?>/cart_contain_product/delete_ccp/<?php echo $value['cart_id']?>/<?php echo $value['the_user_id']?>/<?php echo $value['product_id']?>/<?php echo $value['shop_id']?>">
              <button type="button" class="btn btn-danger">Delete</button>
            </a>
          </td>
        </tr>
    <?php  }
    } ?>
  </tbody>
</table>

<div class="manage-ccp">
  <div class="function-text">
    <a class="text-danger" href="<?php echo $DOMAIN ?>/cart_contain_product/removeAll">
      Delete All
    </a>
  </div>
  <div class="function-text">
    <a class="text-primary" href="<?php echo $DOMAIN ?>/cart_contain_product/insert_ccp">
      Insert a record 
    </a>
  </div>
</div>

<div class="mt-4 mb-2"><strong>$$ Input User_id to retrieve products in his/her cart: </strong> <br></div>

<form action="" method="post" class="mb-3">
    USER ID: <input type="number" name="user_id" value="">
    <button type="submit">Send</button>
</form>


<?php 
    if (empty($_POST["user_id"])) {
      echo "Please fill in all box!";
    }
    
    else if(isset($_POST["user_id"])) { 
    $the_user_id = $_POST["user_id"];
    $sql = " SELECT * FROM cart_contain_product WHERE the_user_id = $the_user_id ";
    
    $hostname = "localhost";
    $username = "root";
    $password = "10042002";
    $dbname = 'E_commerce';

    $conn = mysqli_connect($hostname, $username, $password, $dbname);
    mysqli_set_charset($conn, 'utf8');
    $res = mysqli_query($conn,$sql);

    $data = [];
    
    $count = 0;

    while($row = mysqli_fetch_assoc($res)) {
        /*echo "PRODUCT ID :{$row['product_id']}  <br> ".
         "SHOP ID : {$row['shop_id']} <br> ".
         "AMOUNT : {$row['product_count']} <br> ".
         "SALEPRICE : {$row['product_count']} <br> ".
         "--------------------------------<br>";*/
         $data[] = $row;
         $count = $count + 1; 
    }
  
  mysqli_close($conn);

  if ($count == 0) {
    echo "ID doesn’t exist in table!";
  }

  else {
    require_once('select_result.php');
  }
}
?>

<p>--------------------------------------------------</p>
<div class="mt-2 mb-2"><strong>$$ Input record needed to update with attribute column: </strong> <br></div>

<form action="" method="post">
    CART ID: <input type="number" name="cart_id" value="" class="mb-2"> <br>
    USER ID: <input type="number" name="p_user_id" value="" class="mb-2"> <br>
    PRODUCT ID: <input type="number" name="product_id" value="" class="mb-2"> <br>
    SHOP ID: <input type="number" name="shop_id" value="" class="mb-2"> <br>
    Column needed to UPDATE: 
    <input type="text" name="column" list="col_name" class="mb-2"> <br>
    <datalist id="col_name">
      <option value="Amount">
      <option value="Saleprice">
    </datalist>
    UPDATE Value: <input type="number" name="uvalue" value="" class="mb-2"> <br>
    <button type="submit" class="mb-3">UPDATE</button>
</form>

<?php 

  if (empty($_POST["cart_id"]) or empty($_POST["p_user_id"]) or empty($_POST["product_id"]) 
  and empty($_POST["shop_id"]) or empty($_POST["column"]) or empty($_POST["uvalue"])) {
  echo "Please fill in all box!";
}

  else if(isset($_POST["cart_id"]) and isset($_POST["p_user_id"]) and isset($_POST["product_id"]) 
          and isset($_POST["shop_id"]) and isset($_POST["column"]) and isset($_POST["uvalue"])) 
{ 
  $cartID = $_POST["cart_id"];
  $userID = $_POST["p_user_id"];
  $productID = $_POST["product_id"];
  $shopID = $_POST["shop_id"];
  $col_name = $_POST["column"];
  $val = $_POST["uvalue"];

  if ($col_name == "Amount" and ($val < 1 or $val >10)) {
    echo "Update amount out of range!";
  }

  else if ($col_name == "Saleprice" and ($val < 1000)) {
    echo "Update saleprice out of range!";
  }

  else {

  $hostname = "localhost";
  $username = "root";
  $password = "10042002";
  $dbname = 'E_commerce';

    $conn = mysqli_connect($hostname, $username, $password, $dbname);
    mysqli_set_charset($conn, 'utf8');

    if ($col_name == "Amount") {
      $sql = "UPDATE cart_contain_product SET product_count = $val
      WHERE cart_id = $cartID and the_user_id = $userID and product_id = $productID and shop_id = $shopID ";
      if ($conn->query($sql) === TRUE) {
        echo "Record updated successfully";
      } else {
        echo "Error updating record: " . $conn->error;
      }
    }

    else if ($col_name == "Saleprice") {
      $sql = "UPDATE cart_contain_product SET saleprice = $val
      WHERE cart_id = $cartID and the_user_id = $userID and product_id = $productID and shop_id = $shopID ";
      if ($conn->query($sql) === TRUE) {
        echo "Record updated successfully";
      } else {
        echo "Error updating record: " . $conn->error;
      }
    }

    else {
      echo "Invalid Input in Column needed to UPDATE!";
    }
    mysqli_close($conn);
  }
} 
?>

<style> 
div.footer {
    position:static;
    font-size: 20px;
    line-height: 45px;
    font-weight: 700;
    background-color: #E0BBE4;
    padding-left: 270px;
    margin-top: 30px;
}
</style>

<body>
<div class="footer">
ECOMMERCE - Database Learners
</div>
</body>

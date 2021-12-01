<?php
class Product extends Controller
{
    public $data = array();
    protected $productModel;
    protected $shopModel;
    function __construct()
    {
        $this->productModel = $this->model('ProductModel');
        $this->shopModel = $this->model('ShopModel');
    }
    function ProductPage()
    {
        $shops = $this->shopModel->get_all_shop();
        $this->data['render'] = 'product';
        $this->data['shopList'] = $shops;
        $this->view('layout', $this->data);
    }
    function ProductTable($shopID)
    {
        $products = $this->productModel->get_product_by_shop($shopID);
        $shops = $this->shopModel->get_all_shop();
        $shop = $this->shopModel->get_shop_by($shopID);
        $this->data['render'] = 'productTable';
        $this->data['shopList'] = $shops;
        $this->data['shop'] = $shop;
        $this->data['productList'] = $products;
        $this->view('layout', $this->data);
    }function deleteProduct($shopID, $productID)
    {
        $this->productModel->remove_product($shopID, $productID);
        header("Location: http://localhost/AssignmentDB/admin/Product/ProductTable/" . $shopID);
    }
}

package com.project.QuanLyMyCay.service;

import com.project.QuanLyMyCay.dtos.ProductDTO;
import com.project.QuanLyMyCay.entity.Product;

import java.util.List;

public interface ProductService {
    List<Product> getAllProduct();
    Product addProduct(ProductDTO productDTO);
    Product updateProduct(long id, ProductDTO productDTO);
    boolean deleteProduct(long id);
    Product getProductById(long id);
    List<Product> getProductByCategoryId(long categoryId);
}

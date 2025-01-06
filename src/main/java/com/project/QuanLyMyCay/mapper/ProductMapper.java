package com.project.QuanLyMyCay.mapper;

import com.project.QuanLyMyCay.dtos.ProductDTO;
import com.project.QuanLyMyCay.entity.Category;
import com.project.QuanLyMyCay.entity.Product;
import org.springframework.stereotype.Component;

@Component
public class ProductMapper {

    public ProductDTO toDTO(Product product) {
        return ProductDTO.builder()
                .name(product.getName())
                .price(product.getPrice())
                .description(product.getDescription())
                .thumbnail(product.getThumbnail())
                .categoryId(product.getCategory().getId())
                .status(product.isStatus())
                .build();
    }

    public Product toEntity(ProductDTO productDTO, Category category) {
        return Product.builder()
                .name(productDTO.getName())
                .price(productDTO.getPrice())
                .description(productDTO.getDescription())
                .thumbnail(productDTO.getThumbnail())
                .category(category)
                .status(productDTO.isStatus())
                .build();
    }
}

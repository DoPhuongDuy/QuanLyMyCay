package com.project.QuanLyMyCay.entity.Response;

import com.project.QuanLyMyCay.entity.Product;
import jakarta.persistence.MappedSuperclass;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@Setter
@Getter
@NoArgsConstructor
@MappedSuperclass
public class OrderDetailResponse {
    private String note;
    private int numberOfProducts;
    private double totalMoney;
    private Product product;
    private long spiceLevel;
}


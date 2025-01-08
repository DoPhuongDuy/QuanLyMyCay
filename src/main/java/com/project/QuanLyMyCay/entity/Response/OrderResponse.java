package com.project.QuanLyMyCay.entity.Response;

import jakarta.persistence.MappedSuperclass;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Data
@Setter
@Getter
@NoArgsConstructor
@MappedSuperclass
public class OrderResponse {
    private long id;
    private String invoice;
    private double totalMoney;
    private String note;
    private List<OrderDetailResponse> orderDetails;
}

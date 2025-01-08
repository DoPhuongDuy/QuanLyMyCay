package com.project.QuanLyMyCay.dtos;

import jakarta.validation.constraints.*;
import lombok.*;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderDTO {
    private long id;

    @NotEmpty(message = "Invoice cannot be empty")
    @Size(max = 50, message = "Invoice must not exceed 50 characters") // Tương ứng với VARCHAR(50)
    private String invoice;

    @PositiveOrZero(message = "Total money must be zero or positive") // CHECK (totalMoney >= 0)
    private double totalMoney;

    private String note;

    private long userId;

    @NotNull(message = "orderDetailDTOS cannot be null")
    private List<OrderDetailDTO> orderDetails;

    private boolean isActive;

    private boolean isDone;
}

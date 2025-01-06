package com.project.QuanLyMyCay.dtos;

import jakarta.validation.constraints.*;
import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
@Getter
@Setter
public class OrderDetailDTO {

    private long orderId;

    private long productId;

    private long spiceLevelId;

    private String note;

    @NotNull(message = "Number of products cannot be null")
    @PositiveOrZero(message = "Number of products must be zero or positive") // CHECK (numberOfProducts >= 0)
    private int numberOfProducts;

    @PositiveOrZero(message = "Total money must be zero or positive") // CHECK (totalMoney >= 0)
    private double totalMoney;

}

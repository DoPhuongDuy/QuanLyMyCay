package com.project.QuanLyMyCay.entity.EmbeddedIds;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Embeddable
@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDetailKey implements Serializable {

    @Column(name = "order_id")
    private long orderId;

    @Column(name = "product_id")
    private long productId;

    @Column(name = "spice_level_id")
    private long spiceLevelId; // Thêm spice_level_id vào khóa chính

}

package com.project.QuanLyMyCay.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.project.QuanLyMyCay.entity.EmbeddedIds.OrderDetailKey;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "order_details")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderDetail {

    @EmbeddedId
    private OrderDetailKey id;

    @Column(name = "note", length = 65535) // LONGTEXT
    private String note;

    @Column(name = "number_of_products", nullable = false) // NOT NULL
    private int numberOfProducts;

    @Column(name = "total_money", nullable = false) // NOT NULL
    private double totalMoney;

    @ManyToOne
    @MapsId("spiceLevelId")
    @JoinColumn(name = "spice_level_id", nullable = false)
    @JsonIgnore
    private SpiceLevel spiceLevel;

    @ManyToOne
    @MapsId("orderId")
    @JoinColumn(name = "order_id", nullable = false) // NOT NULL foreign key
    @JsonIgnore
    private Order order;

    @ManyToOne
    @MapsId("productId")
    @JoinColumn(name = "product_id", nullable = false) // NOT NULL foreign key
    @JsonIgnore
    private Product product;
}
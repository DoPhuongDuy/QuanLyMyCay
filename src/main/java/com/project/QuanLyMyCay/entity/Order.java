package com.project.QuanLyMyCay.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "orders")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "invoice", nullable = false, length = 50, unique = true) // VARCHAR(50), NOT NULL, UNIQUE
    private String invoice;

    @Column(name = "total_money", nullable = false) // NOT NULL
    private double totalMoney;

    @Column(name = "note", length = 65535) // LONGTEXT
    private String note;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false) // NOT NULL foreign key
    private User user;

    @Column(name = "is_active", nullable = false, columnDefinition = "TINYINT DEFAULT 1") // Default = 1
    private boolean isActive;

    @Column(name = "is_done", nullable = false, columnDefinition = "TINYINT DEFAULT 1") // Default = 1
    private boolean isDone;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderDetail> orderDetails = new ArrayList<>();
}

package com.project.QuanLyMyCay.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "products")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "name", nullable = false, length = 255) // VARCHAR(255), NOT NULL
    private String name;

    @Column(name = "price", nullable = false) // NOT NULL
    private double price;

    @Column(name = "description", length = 65535) // LONGTEXT
    private String description;

    @Column(name = "thumbnail", length = 255) // VARCHAR(255)
    private String thumbnail;

    @ManyToOne
    @JoinColumn(name = "category_id", nullable = false) // NOT NULL foreign key
    private Category category;

    @Column(name = "status", nullable = false, columnDefinition = "TINYINT DEFAULT 1") // Default = 1
    private boolean status;
}

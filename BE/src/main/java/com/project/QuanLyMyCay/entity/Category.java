package com.project.QuanLyMyCay.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name ="categories")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "name", nullable = false, length = 100, unique = true) // VARCHAR(100), NOT NULL, UNIQUE
    private String name;
}

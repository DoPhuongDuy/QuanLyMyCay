package com.project.QuanLyMyCay.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name ="categories")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // ID tự động sinh
    private long id; // Tương ứng với `serial`

    @Column(name = "name", nullable = false, length = 50, unique = true)
    private String name; // Tương ứng với varchar(64)
}

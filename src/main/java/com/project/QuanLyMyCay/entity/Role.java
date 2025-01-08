package com.project.QuanLyMyCay.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name ="roles")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Role {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "name", nullable = false, length = 64, unique = true) // VARCHAR(64), NOT NULL, UNIQUE
    private String name;

    public static String ADMIN = "ADMIN";
    public static String USER = "USER";
    public static String KITCHEN = "KITCHEN";
}

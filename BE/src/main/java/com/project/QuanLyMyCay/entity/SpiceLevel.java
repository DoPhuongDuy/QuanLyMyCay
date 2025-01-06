package com.project.QuanLyMyCay.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "spice_levels")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SpiceLevel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private long id;

    @Column(name = "level_name", nullable = false, length = 100)
    private String levelName;
}

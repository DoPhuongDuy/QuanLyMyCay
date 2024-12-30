package com.project.QuanLyMyCay.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name ="roles")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Role {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // ID tự động sinh
    private long id; // Tương ứng với `serial`

    @Column(name = "name", nullable = false, length = 50, unique = true)
    private String name; // Tương ứng với varchar(64)

}

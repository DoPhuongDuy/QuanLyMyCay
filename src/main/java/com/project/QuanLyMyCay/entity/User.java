package com.project.QuanLyMyCay.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name ="users")
@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // ID tự động sinh
    private long id; // Tương ứng với `serial`

    @Column(name = "name", nullable = false, length = 64, unique = true)
    private String name; // Tương ứng với varchar(64)

    @Column(name = "password", nullable = false, length = 64)
    private String password; // Tương ứng với varchar(64)

    @ManyToOne
    @JoinColumn(name = "roleId")
    private Role roleId; // Tương ứng với varchar(64)

    @Column(name = "isActive", nullable = false)
    private boolean isActive; // Tương ứng với varchar(64)

}
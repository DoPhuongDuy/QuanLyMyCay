package com.project.QuanLyMyCay.mapper;

import com.project.QuanLyMyCay.dtos.UserDTO;
import com.project.QuanLyMyCay.entity.Role;
import com.project.QuanLyMyCay.entity.User;
import org.springframework.stereotype.Component;

@Component
public class UserMapper {

    public UserDTO toDTO(User user) {
        return UserDTO.builder()
                .name(user.getName())
                .password(user.getPassword())
                .roleId(user.getRole().getId())  // Lấy ID của Role từ User
                .isActive(user.isActive())
                .build();
    }

    public User toEntity(UserDTO userDTO, Role role) {
        return User.builder()
                .name(userDTO.getName())
                .password(userDTO.getPassword())
                .role(role)
                .isActive(userDTO.isActive())
                .build();
    }
}

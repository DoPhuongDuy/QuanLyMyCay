package com.project.QuanLyMyCay.mapper;

import com.project.QuanLyMyCay.dtos.UserDTO;
import com.project.QuanLyMyCay.entity.Role;
import com.project.QuanLyMyCay.entity.User;
import org.springframework.stereotype.Component;

@Component
public class UserMapper {

    // Chuyển từ UserDTO sang User
    public User toEntity(UserDTO userDTO, Role role) {
        return User.builder()
                .name(userDTO.getName())
                .password(userDTO.getPassword())
                .roleId(role)
                .isActive(userDTO.isActive())
                .build();
    }

    // Chuyển từ User sang UserDTO
    public UserDTO toDTO(User user) {
        return UserDTO.builder()
                .name(user.getName())
                .password(user.getPassword())
                .roleId(user.getRoleId().getId())
                .isActive(user.isActive())
                .build();
    }
}

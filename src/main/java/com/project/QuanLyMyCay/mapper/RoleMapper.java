package com.project.QuanLyMyCay.mapper;

import com.project.QuanLyMyCay.dtos.RoleDTO;
import com.project.QuanLyMyCay.entity.Role;
import org.springframework.stereotype.Component;

@Component
public class RoleMapper {

    public RoleDTO toDto(Role role) {
        return RoleDTO.builder()
                .name(role.getName())
                .build();
    }

    public Role toEntity(RoleDTO roleDTO) {
        Role role = new Role();
        role.setName(roleDTO.getName());
        return role;
    }
}
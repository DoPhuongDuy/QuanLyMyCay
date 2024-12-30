package com.project.QuanLyMyCay.service;


import com.project.QuanLyMyCay.dtos.RoleDTO;
import com.project.QuanLyMyCay.entity.Role;
import com.project.QuanLyMyCay.exception.DataNotFoundException;

import java.util.List;

public interface RoleService {
    // Retrieve all roles
    List<Role> getAllRoles();

    // Retrieve a role by its ID
    Role getRoleById(long id);

    // create a role
    Role createRole(RoleDTO roleDTO);

    Role updateRoleById(long id, RoleDTO roleDTO);

    void deleteRoleById(long id);
}

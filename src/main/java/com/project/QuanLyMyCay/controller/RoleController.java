package com.project.QuanLyMyCay.controller;


import com.project.QuanLyMyCay.dtos.RoleDTO;
import com.project.QuanLyMyCay.entity.Role;
import com.project.QuanLyMyCay.service.RoleService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("${api.prefix}/roles")
@RequiredArgsConstructor
public class RoleController {

    private final RoleService roleService;

    @PostMapping()
    public ResponseEntity<String> createRole(@Valid @RequestBody RoleDTO roleDTO){
        Role newRole =  roleService.createRole(roleDTO);
        return ResponseEntity.ok("createRole");
    }

    @GetMapping()
    public ResponseEntity<List<Role>> getAllRoles(){

        List<Role> roles =  roleService.getAllRoles();
        return ResponseEntity.ok(roles);
    }
    @GetMapping("/{id}")
    public ResponseEntity<Role> getRoleById(@PathVariable("id") long id){
        Role role =  roleService.getRoleById(id);
        return ResponseEntity.ok(role);
    }
    @PutMapping("/{id}")
    public ResponseEntity<String> updateRoleById(
            @PathVariable("id") long id,
            @Valid @RequestBody RoleDTO roleDTO
    ){
        roleService.updateRoleById(id,roleDTO);
        return ResponseEntity.ok("updateByRoleById "+id);
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteByRoleById(@PathVariable("id") long id){
        roleService.deleteRoleById(id);
        return ResponseEntity.ok("deleteByRoleById "+id);
    }
}

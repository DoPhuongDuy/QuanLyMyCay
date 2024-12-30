package com.project.QuanLyMyCay.service.implementation;

import com.project.QuanLyMyCay.dtos.RoleDTO;
import com.project.QuanLyMyCay.entity.Role;
import com.project.QuanLyMyCay.exception.DataNotFoundException;
import com.project.QuanLyMyCay.mapper.RoleMapper;
import com.project.QuanLyMyCay.repository.RoleRepository;
import com.project.QuanLyMyCay.service.RoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class RoleServiceImpl implements RoleService {

    private final RoleRepository roleRepository;
    private final RoleMapper roleMapper;

    @Override
    public List<Role> getAllRoles() {
        // Trả về trực tiếp danh sách các đối tượng Role từ roleRepository
        return roleRepository.findAll();
    }

    @Override
    public Role getRoleById(long id) {
        return roleRepository.findById(id).orElseThrow(()-> new DataNotFoundException("Cannot find role"));
    }

    @Override
    public Role createRole(RoleDTO roleDTO) {
        if (roleRepository.existsByName(roleDTO.getName())) {
            throw new DataIntegrityViolationException("Role already exists");
        }
        Role newRole = roleMapper.toEntity(roleDTO);
        return roleRepository.save(newRole);
    }

    @Override
    public Role updateRoleById(long id, RoleDTO roleDTO) {
        Role existingRole = getRoleById(id);
        if (roleRepository.existsByName(roleDTO.getName())) {
            throw new DataIntegrityViolationException("Role already exists");
        }
        existingRole.setName(roleDTO.getName());
        return roleRepository.save(existingRole);
    }

    @Override
    public void deleteRoleById(long id) {
        Optional<Role> optionalRole = roleRepository.findById(id);
        optionalRole.ifPresent(roleRepository::delete);
    }
}

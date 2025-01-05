package com.project.QuanLyMyCay.service.implementation;

import com.project.QuanLyMyCay.dtos.RoleDTO;
import com.project.QuanLyMyCay.entity.Role;
import com.project.QuanLyMyCay.entity.User;
import com.project.QuanLyMyCay.exception.AlreadyExistsException;
import com.project.QuanLyMyCay.exception.DataNotFoundException;
import com.project.QuanLyMyCay.exception.DataSaveException;
import com.project.QuanLyMyCay.mapper.RoleMapper;
import com.project.QuanLyMyCay.repository.RoleRepository;
import com.project.QuanLyMyCay.repository.UserRepository;
import com.project.QuanLyMyCay.service.RoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class RoleServiceImpl implements RoleService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final RoleMapper roleMapper;

    @Override
    public List<Role> getAllRoles() {
        return roleRepository.findAll();
    }

    @Override
    public Role getRoleById(long id) {
        return roleRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException("Cannot find role with ID: " + id));
    }

    @Override
    public Role createRole(RoleDTO roleDTO) {
        if (roleRepository.existsByName(roleDTO.getName())) {
            throw new AlreadyExistsException("Role with name '" + roleDTO.getName() + "' already exists");
        }
        Role newRole = roleMapper.toEntity(roleDTO);
        return roleRepository.save(newRole);
    }

    @Override
    public Role updateRoleById(long id, RoleDTO roleDTO) {
        Role existingRole = getRoleById(id);

        // Kiểm tra xem tên mới có trùng với tên khác không
        if (!existingRole.getName().equals(roleDTO.getName())) {
            if (roleRepository.existsByName(roleDTO.getName())) {
                throw new AlreadyExistsException("Role with name '" + roleDTO.getName() + "' already exists");
            }
            existingRole.setName(roleDTO.getName());
            return roleRepository.save(existingRole);
        }
        return existingRole;  // Nếu không có thay đổi, trả về chính Role cũ
    }

    @Override
    public void deleteRoleById(long id) {
        List<User> users = userRepository.findByRoleId(id);
        if (!users.isEmpty()) {
            throw new DataSaveException("Cannot delete role, users are referencing it.");
        }

        Optional<Role> optionalRole = roleRepository.findById(id);
        optionalRole.ifPresent(roleRepository::delete);
    }
}

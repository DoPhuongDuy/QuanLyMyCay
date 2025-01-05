package com.project.QuanLyMyCay.repository;

import com.project.QuanLyMyCay.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    boolean existsByName(String name);
    Optional<User> findByName(String name);
    List<User> findByRoleId(long roleId);
}

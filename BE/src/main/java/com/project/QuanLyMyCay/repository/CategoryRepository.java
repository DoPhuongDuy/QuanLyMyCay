package com.project.QuanLyMyCay.repository;

import com.project.QuanLyMyCay.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, Long> {
    boolean existsByName (String name);
}

package com.project.QuanLyMyCay.repository;

import com.project.QuanLyMyCay.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ProductRepository extends JpaRepository<Product, Long> {
    boolean existsByName(String name);
    Optional<Product> findByName(String name);
    List<Product> findByCategoryId(long categoryId);
}

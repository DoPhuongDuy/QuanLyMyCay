package com.project.QuanLyMyCay.repository;

import com.project.QuanLyMyCay.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long> {
    boolean existsByInvoice(String invoice);
    Optional<Order> findByInvoice(String invoice);
}

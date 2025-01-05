package com.project.QuanLyMyCay.repository;

import com.project.QuanLyMyCay.entity.OrderDetail;
import com.project.QuanLyMyCay.entity.EmbeddedIds.OrderDetailKey;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, OrderDetailKey> {
    // Sử dụng OrderDetailKey làm khóa chính
    List<OrderDetail> findByOrderId(long orderId);
    List<OrderDetail> findByProductId(long productId);
    List<OrderDetail> findBySpiceLevelId(long spiceLevelId);
}

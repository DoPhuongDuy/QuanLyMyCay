package com.project.QuanLyMyCay.mapper;

import com.project.QuanLyMyCay.dtos.OrderDetailDTO;
import com.project.QuanLyMyCay.entity.EmbeddedIds.OrderDetailKey;
import com.project.QuanLyMyCay.entity.Order;
import com.project.QuanLyMyCay.entity.OrderDetail;
import com.project.QuanLyMyCay.entity.Product;
import com.project.QuanLyMyCay.entity.SpiceLevel;
import org.springframework.stereotype.Component;

@Component
public class OrderDetailMapper {

    public OrderDetailDTO toDTO(OrderDetail orderDetail) {
        return OrderDetailDTO.builder()
                .orderId(orderDetail.getOrder().getId())
                .productId(orderDetail.getProduct().getId())
                .note(orderDetail.getNote())
                .numberOfProducts(orderDetail.getNumberOfProducts())
                .totalMoney(orderDetail.getTotalMoney())
                .spiceLevelId(orderDetail.getSpiceLevel().getId())
                .build();
    }

    public OrderDetail toEntity(OrderDetailDTO orderDetailDTO, Order order, Product product, SpiceLevel spiceLevel) {
        return OrderDetail.builder()
                .id(new OrderDetailKey(orderDetailDTO.getOrderId(), orderDetailDTO.getProductId(), orderDetailDTO.getSpiceLevelId()))
                .note(orderDetailDTO.getNote())
                .numberOfProducts(orderDetailDTO.getNumberOfProducts())
                .totalMoney(orderDetailDTO.getTotalMoney())
                .spiceLevel(spiceLevel)
                .order(order)
                .product(product)
                .build();
    }
}

package com.project.QuanLyMyCay.mapper;

import com.project.QuanLyMyCay.dtos.OrderDTO;
import com.project.QuanLyMyCay.entity.Order;
import com.project.QuanLyMyCay.entity.User;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class OrderMapper {

    public OrderDTO toDTO(Order order) {
        return OrderDTO.builder()
                .invoice(order.getInvoice())
                .totalMoney(order.getTotalMoney())
                .note(order.getNote())
                .userId(order.getUser().getId())  // Lấy ID của User từ Order
                .build();
    }

    public Order toEntity(OrderDTO orderDTO, User user) {
        return Order.builder()
                .invoice(orderDTO.getInvoice())
                .totalMoney(orderDTO.getTotalMoney())
                .note(orderDTO.getNote())
                .isActive(orderDTO.isActive())
                .isDone(orderDTO.isDone())
                .user(user)  // Gán User cho Order
                .build();
    }
}

package com.project.QuanLyMyCay.service;

import com.project.QuanLyMyCay.dtos.OrderDTO;
import com.project.QuanLyMyCay.entity.Order;
import com.project.QuanLyMyCay.entity.Response.OrderResponse;

import java.util.List;

public interface OrderService {

    List<OrderResponse> getAllOrders();

    List<Order> getAllOrdersActive(long id);

    Order getOrderById(long id);

    Order createOrder(OrderDTO orderDTO);

    Order updateOrder(long id, OrderDTO orderDTO);

    void deleteOrder(long id);
}

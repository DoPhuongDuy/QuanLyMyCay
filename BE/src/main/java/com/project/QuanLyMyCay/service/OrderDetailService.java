package com.project.QuanLyMyCay.service;

import com.project.QuanLyMyCay.dtos.OrderDetailDTO;
import com.project.QuanLyMyCay.entity.OrderDetail;

import java.util.List;

public interface OrderDetailService {
    List<OrderDetail> getAllOrderDetails();
    List<OrderDetail> getOrderDetailByIdOrder(long id);
    OrderDetail addOrderDetail(OrderDetailDTO orderDetailDTO);
    OrderDetail updateOrderDetail(OrderDetailDTO orderDetailDTO);
    boolean deleteOrderDetail(OrderDetailDTO orderDetailDTO);
}

package com.project.QuanLyMyCay.controller;

import com.project.QuanLyMyCay.dtos.OrderDTO;
import com.project.QuanLyMyCay.dtos.OrderDetailDTO;
import com.project.QuanLyMyCay.entity.Order;
import com.project.QuanLyMyCay.entity.OrderDetail;
import com.project.QuanLyMyCay.exception.DataValidationException;
import com.project.QuanLyMyCay.service.OrderDetailService;
import com.project.QuanLyMyCay.service.OrderService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("${api.prefix}/orders")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;
    private final OrderDetailService orderDetailService;

    // Lấy tất cả đơn hàng
    @GetMapping()
    public ResponseEntity<List<Order>> getAllOrders() {
        List<Order> orders = orderService.getAllOrders();
        return ResponseEntity.ok(orders);
    }

    // Lấy đơn hàng theo ID
    @GetMapping("/{id}")
    public ResponseEntity<Order> getOrderById(@PathVariable long id) {
        Order order = orderService.getOrderById(id);
        return ResponseEntity.ok(order);
    }

    // Tạo đơn hàng mới
    @PostMapping()
    public ResponseEntity<String> createOrder(
            @Valid @RequestBody OrderDTO orderDTO,
            BindingResult result
    ) {
        if (result.hasErrors()) {
            String errorMessages = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .collect(Collectors.joining(", "));
            throw new DataValidationException(errorMessages);
        }

        Order createdOrder = orderService.createOrder(orderDTO);

        double sum = 0;


        for (OrderDetailDTO orderDetailDTO : orderDTO.getOrderDetailDTOS()) {
            orderDetailDTO.setOrderId(createdOrder.getId());
            OrderDetail orderDetail = orderDetailService.addOrderDetail(orderDetailDTO);
            sum += orderDetail.getTotalMoney();
        }
        orderDTO.setTotalMoney(sum);

        orderService.updateOrder(createdOrder.getId(), orderDTO);

        return ResponseEntity.status(HttpStatus.CREATED).body("Order has been created successfully.");
    }

    // Cập nhật thông tin đơn hàng
    @PutMapping("/{id}")
    public ResponseEntity<Order> updateOrder(
            @PathVariable long id,
            @Valid @RequestBody OrderDTO orderDTO,
            BindingResult result
    ) {
        if (result.hasErrors()) {
            String errorMessages = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .collect(Collectors.joining(", "));
            throw new DataValidationException(errorMessages);
        }

        double sum = 0;

        for (OrderDetailDTO orderDetailDTO : orderDTO.getOrderDetailDTOS()) {
            OrderDetail orderDetail = orderDetailService.updateOrderDetail(orderDetailDTO);
            sum += orderDetail.getTotalMoney();
        }
        orderDTO.setTotalMoney(sum);

        Order updatedOrder = orderService.updateOrder(id, orderDTO);

        return ResponseEntity.ok(updatedOrder);
    }

    // Xóa đơn hàng theo ID
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteOrder(@PathVariable long id) {
        try {
            orderService.deleteOrder(id);
            return ResponseEntity.ok("Order has been deleted successfully.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }
}

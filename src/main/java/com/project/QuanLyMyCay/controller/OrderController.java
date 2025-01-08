package com.project.QuanLyMyCay.controller;

import com.project.QuanLyMyCay.dtos.OrderDTO;
import com.project.QuanLyMyCay.dtos.OrderDetailDTO;
import com.project.QuanLyMyCay.entity.Order;
import com.project.QuanLyMyCay.entity.OrderDetail;
import com.project.QuanLyMyCay.entity.Response.OrderResponse;
import com.project.QuanLyMyCay.exception.DataValidationException;
import com.project.QuanLyMyCay.service.OrderDetailService;
import com.project.QuanLyMyCay.service.OrderService;
import jakarta.servlet.http.HttpServletRequest;
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
@CrossOrigin
@RequestMapping("${api.prefix}/orders")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;
    private final OrderDetailService orderDetailService;

    // Lấy tất cả đơn hàng
    @GetMapping(value = "/get-all-active", produces = "application/json;charset=UTF-8")
    public ResponseEntity<List<OrderResponse>> getAllOrdersActive() {
        List<OrderResponse> orders = orderService.getAllOrders();
        return ResponseEntity.ok(orders);
    }

    // Lấy đơn hàng theo ID
    @GetMapping("/get/{id}")
    public ResponseEntity<Order> getOrderById(@PathVariable long id) {
        Order order = orderService.getOrderById(id);
        return ResponseEntity.ok(order);
    }

    // Tạo đơn hàng mới
    @PostMapping("/create")
    public ResponseEntity<String> createOrder(
            @Valid @RequestBody OrderDTO orderDTO,
            BindingResult result,
            HttpServletRequest request
    ) {
        Long userId = (Long) request.getAttribute("userId");
        if (userId != null) {
            orderDTO.setUserId(userId); // Gán userId vào orderDTO
        } else {
            throw new DataValidationException("User ID is missing or invalid");
        }

        orderDTO.setActive(true);
        orderDTO.setDone(false);

        if (result.hasErrors()) {
            String errorMessages = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .collect(Collectors.joining(", "));
            throw new DataValidationException(errorMessages);
        }
        double sum = 0;
        for (OrderDetailDTO orderDetailDTO : orderDTO.getOrderDetails()) {
            if(orderDetailDTO.getSpiceLevelId() == 0){
                orderDetailDTO.setSpiceLevelId(1);
            }
            sum += orderDetailDTO.getTotalMoney();
        }
        orderDTO.setTotalMoney(sum);

        Order createdOrder = orderService.createOrder(orderDTO);


        for (OrderDetailDTO orderDetailDTO : orderDTO.getOrderDetails()) {
            orderDetailDTO.setOrderId(createdOrder.getId());
            OrderDetail orderDetail = orderDetailService.addOrderDetail(orderDetailDTO);
        }

        return ResponseEntity.ok("Order has been created successfully.");
    }

    // Cập nhật thông tin đơn hàng
    @PutMapping("/update/{id}")
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

        for (OrderDetailDTO orderDetailDTO : orderDTO.getOrderDetails()) {
            OrderDetail orderDetail = orderDetailService.updateOrderDetail(orderDetailDTO);
            sum += orderDetail.getTotalMoney();
        }
        orderDTO.setTotalMoney(sum);

        Order updatedOrder = orderService.updateOrder(id, orderDTO);

        return ResponseEntity.ok(updatedOrder);
    }

    // Xóa đơn hàng theo ID
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteOrder(@PathVariable long id) {
        try {
            orderService.deleteOrder(id);
            return ResponseEntity.ok("Order has been deleted successfully.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }
}

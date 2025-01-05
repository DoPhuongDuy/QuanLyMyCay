package com.project.QuanLyMyCay.controller;

import com.project.QuanLyMyCay.dtos.OrderDetailDTO;
import com.project.QuanLyMyCay.entity.OrderDetail;
import com.project.QuanLyMyCay.exception.DataValidationException;
import com.project.QuanLyMyCay.service.OrderDetailService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@CrossOrigin
@RequestMapping("${api.prefix}/order-details")
@RequiredArgsConstructor
public class OrderDetailController {

    private final OrderDetailService orderDetailService;

    @GetMapping()
    public ResponseEntity<List<OrderDetail>> getAllOrderDetails() {
        List<OrderDetail> orderDetails = orderDetailService.getAllOrderDetails();
        return ResponseEntity.ok(orderDetails);
    }

    @PostMapping()
    public ResponseEntity<OrderDetail> addOrderDetail(
            @Valid @RequestBody OrderDetailDTO orderDetailDTO,
            BindingResult result) {
        // Kiểm tra nếu có lỗi trong dữ liệu đầu vào
        if (result.hasErrors()) {
            String errorMessages = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .collect(Collectors.joining(", "));
            throw new DataValidationException(errorMessages);
        }

        OrderDetail newOrderDetail = orderDetailService.addOrderDetail(orderDetailDTO);
        return ResponseEntity.ok(newOrderDetail);
    }

    @PutMapping("")
    public ResponseEntity<OrderDetail> updateOrderDetail(
            @Valid @RequestBody OrderDetailDTO orderDetailDTO) {
        OrderDetail updatedOrderDetail = orderDetailService.updateOrderDetail(orderDetailDTO);
        return ResponseEntity.ok(updatedOrderDetail);
    }

    @DeleteMapping()
    public ResponseEntity<String> deleteOrderDetailbyOrderId(@Valid @RequestBody OrderDetailDTO orderDetailDTO) {
        boolean isDeleted = orderDetailService.deleteOrderDetail(orderDetailDTO);
        if (isDeleted) {
            return ResponseEntity.ok("Deleted OrderDetail");
        } else {
            return ResponseEntity.status(404).body("OrderDetail not found");
        }
    }
}

package com.project.QuanLyMyCay.service.implementation;

import com.project.QuanLyMyCay.dtos.OrderDetailDTO;
import com.project.QuanLyMyCay.entity.EmbeddedIds.OrderDetailKey;
import com.project.QuanLyMyCay.entity.Order;
import com.project.QuanLyMyCay.entity.OrderDetail;
import com.project.QuanLyMyCay.entity.Product;
import com.project.QuanLyMyCay.entity.SpiceLevel;
import com.project.QuanLyMyCay.exception.DataNotFoundException;
import com.project.QuanLyMyCay.mapper.OrderDetailMapper;
import com.project.QuanLyMyCay.repository.OrderDetailRepository;
import com.project.QuanLyMyCay.repository.OrderRepository;
import com.project.QuanLyMyCay.repository.ProductRepository;
import com.project.QuanLyMyCay.repository.SpiceLevelRepository;
import com.project.QuanLyMyCay.service.OrderDetailService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderDetailServiceImpl implements OrderDetailService {

    private final SpiceLevelRepository spiceLevelRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    private final OrderDetailMapper orderDetailMapper;

    @Override
    public List<OrderDetail> getAllOrderDetails() {
        return orderDetailRepository.findAll();
    }

    @Override
    public List<OrderDetail> getOrderDetailByIdOrder(long id) {
        return orderDetailRepository.findByOrderId(id);
    }

    @Override
    public OrderDetail addOrderDetail(OrderDetailDTO orderDetailDTO) {
        Order existingOrder = orderRepository.findById(orderDetailDTO.getOrderId())
                .orElseThrow(() -> new DataNotFoundException("Không thể tìm thấy Order"));

        Product existingProduct = productRepository.findById(orderDetailDTO.getProductId())
                .orElseThrow(() -> new DataNotFoundException("Không thể tìm thấy Product"));

        SpiceLevel existingSpiceLevel = spiceLevelRepository.findById(orderDetailDTO.getSpiceLevelId())
                .orElseThrow(() -> new DataNotFoundException("Không thể tìm thấy SpiceLevel"));

        orderDetailDTO.setTotalMoney(orderDetailDTO.getNumberOfProducts() * existingProduct.getPrice());

        OrderDetail newOrderDetail = orderDetailMapper.toEntity(orderDetailDTO, existingOrder, existingProduct, existingSpiceLevel);
        return orderDetailRepository.save(newOrderDetail);
    }

    @Override
    public OrderDetail updateOrderDetail(OrderDetailDTO orderDetailDTO) {
        // Tạo key cho OrderDetail
        OrderDetailKey key = new OrderDetailKey(
                orderDetailDTO.getOrderId(),
                orderDetailDTO.getProductId(),
                orderDetailDTO.getSpiceLevelId()
        );

        // Lấy OrderDetail hiện tại từ key
        OrderDetail existingOrderDetail = orderDetailRepository.findById(key)
                .orElseThrow(() -> new DataNotFoundException("Không thể tìm thấy OrderDetail"));

        // Cập nhật Order nếu Order ID thay đổi trong DTO
        if (existingOrderDetail.getOrder().getId() != orderDetailDTO.getOrderId()) {
            Order existingOrder = orderRepository.findById(orderDetailDTO.getOrderId())
                    .orElseThrow(() -> new DataNotFoundException("Không thể tìm thấy Order"));
            existingOrderDetail.setOrder(existingOrder);
        }

        // Cập nhật Product nếu Product ID thay đổi trong DTO
        if (existingOrderDetail.getProduct().getId() != orderDetailDTO.getProductId()) {
            Product existingProduct = productRepository.findById(orderDetailDTO.getProductId())
                    .orElseThrow(() -> new DataNotFoundException("Không thể tìm thấy Product"));
            existingOrderDetail.setProduct(existingProduct);
        }

        // Cập nhật SpiceLevel nếu SpiceLevel ID thay đổi trong DTO
        if (existingOrderDetail.getSpiceLevel().getId() != orderDetailDTO.getSpiceLevelId()) {
            SpiceLevel existingSpiceLevel = spiceLevelRepository.findById(orderDetailDTO.getSpiceLevelId())
                    .orElseThrow(() -> new DataNotFoundException("Không thể tìm thấy SpiceLevel"));
            existingOrderDetail.setSpiceLevel(existingSpiceLevel);
        }

        // Cập nhật số lượng sản phẩm, ghi chú và tính lại tổng tiền
        existingOrderDetail.setNumberOfProducts(orderDetailDTO.getNumberOfProducts());
        existingOrderDetail.setNote(orderDetailDTO.getNote());
        existingOrderDetail.setTotalMoney(orderDetailDTO.getNumberOfProducts() * existingOrderDetail.getProduct().getPrice());

        // Lưu lại OrderDetail đã cập nhật
        return orderDetailRepository.save(existingOrderDetail);
    }


    @Override
    public boolean deleteOrderDetail(OrderDetailDTO orderDetailDTO) {
        OrderDetailKey key = new OrderDetailKey(
                orderDetailDTO.getOrderId(),
                orderDetailDTO.getProductId(),
                orderDetailDTO.getSpiceLevelId()
        );

        OrderDetail existingOrderDetail = orderDetailRepository.findById(key)
                .orElseThrow(() -> new DataNotFoundException("Không thể tìm thấy OrderDetail"));

        orderDetailRepository.delete(existingOrderDetail);
        return true;
    }

}

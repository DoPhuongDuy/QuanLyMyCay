package com.project.QuanLyMyCay.service.implementation;

import com.project.QuanLyMyCay.dtos.OrderDTO;
import com.project.QuanLyMyCay.entity.Order;
import com.project.QuanLyMyCay.entity.OrderDetail;
import com.project.QuanLyMyCay.entity.User;
import com.project.QuanLyMyCay.exception.DataNotFoundException;
import com.project.QuanLyMyCay.exception.DataSaveException;
import com.project.QuanLyMyCay.mapper.OrderMapper;
import com.project.QuanLyMyCay.repository.OrderDetailRepository;
import com.project.QuanLyMyCay.repository.OrderRepository;
import com.project.QuanLyMyCay.repository.UserRepository;
import com.project.QuanLyMyCay.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

    private final OrderMapper orderMapper;
    private final OrderRepository orderRepository;
    private final UserRepository userRepository;
    private final OrderDetailRepository orderDetailRepository; // Thêm repository để tìm kiếm orderDetails

    @Override
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    @Override
    public Order getOrderById(long id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException("Không thể tìm thấy Order"));
    }

    @Override
    public Order createOrder(OrderDTO orderDTO) {
        User existingUser = userRepository.findById(orderDTO.getUserId())
                .orElseThrow(() -> new DataNotFoundException("Không thể tìm thấy User"));
        Order newOrder = orderMapper.toEntity(orderDTO, existingUser);
        return orderRepository.save(newOrder);
    }

    @Override
    public Order updateOrder(long id, OrderDTO orderDTO) {
        Order existingOrder = orderRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException("Không thể tìm thấy Order"));

        existingOrder.setInvoice(orderDTO.getInvoice());
        existingOrder.setNote(orderDTO.getNote());
        existingOrder.setTotalMoney(orderDTO.getTotalMoney());

        if (existingOrder.getUser().getId() != orderDTO.getUserId()) {
            User existingUser = userRepository.findById(orderDTO.getUserId())
                    .orElseThrow(() -> new DataNotFoundException("Không thể tìm thấy User"));
            existingOrder.setUser(existingUser);
        }

        return orderRepository.save(existingOrder);
    }

    @Override
    public void deleteOrder(long id) {
        // Kiểm tra xem có chi tiết đơn hàng nào tham chiếu đến order này không
        List<OrderDetail> orderDetails = orderDetailRepository.findByOrderId(id);
        if (!orderDetails.isEmpty()) {
            throw new DataSaveException("Không thể xóa order, có order details tham chiếu đến.");
        }

        // Nếu không có chi tiết đơn hàng tham chiếu, xóa order
        Optional<Order> optionalOrder = orderRepository.findById(id);
        optionalOrder.ifPresent(orderRepository::delete);
    }
}

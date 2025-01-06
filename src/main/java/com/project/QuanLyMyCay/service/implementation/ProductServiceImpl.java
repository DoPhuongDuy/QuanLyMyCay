package com.project.QuanLyMyCay.service.implementation;

import com.project.QuanLyMyCay.dtos.ProductDTO;
import com.project.QuanLyMyCay.entity.Category;
import com.project.QuanLyMyCay.entity.OrderDetail;
import com.project.QuanLyMyCay.entity.Product;
import com.project.QuanLyMyCay.exception.AlreadyExistsException;
import com.project.QuanLyMyCay.exception.DataNotFoundException;
import com.project.QuanLyMyCay.exception.DataSaveException;
import com.project.QuanLyMyCay.mapper.ProductMapper;
import com.project.QuanLyMyCay.repository.CategoryRepository;
import com.project.QuanLyMyCay.repository.OrderDetailRepository;
import com.project.QuanLyMyCay.repository.ProductRepository;
import com.project.QuanLyMyCay.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

    private final CategoryRepository categoryRepository;
    private final ProductRepository productRepository;
    private final ProductMapper productMapper;
    private final OrderDetailRepository orderDetailRepository;  // Thêm vào để tìm kiếm orderDetails

    @Override
    public List<Product> getAllProduct() {
        return productRepository.findAll();
    }

    @Override
    public Product addProduct(ProductDTO productDTO) {
        if (productRepository.existsByName(productDTO.getName())) {
            throw new AlreadyExistsException("Sản phẩm đã tồn tại");
        }
        Category existingCategory = categoryRepository.findById(productDTO.getCategoryId())
                .orElseThrow(() -> new DataNotFoundException("Không thể tìm thấy category"));
        Product newProduct = productMapper.toEntity(productDTO, existingCategory);
        return productRepository.save(newProduct);
    }

    @Override
    public Product updateProduct(long id, ProductDTO productDTO) {
        Product existingProduct = getProductById(id);
        if (productRepository.existsByName(productDTO.getName()) && !existingProduct.getName().equals(productDTO.getName())) {
            throw new AlreadyExistsException("Sản phẩm đã tồn tại");
        }
        existingProduct.setName(productDTO.getName());
        existingProduct.setDescription(productDTO.getDescription());
        existingProduct.setPrice(productDTO.getPrice());
        existingProduct.setStatus(productDTO.isStatus());
        if (existingProduct.getCategory().getId() != productDTO.getCategoryId()) {
            Category existingCategory = categoryRepository.findById(productDTO.getCategoryId())
                    .orElseThrow(() -> new DataNotFoundException("Loại Không Tồn tại"));
            existingProduct.setCategory(existingCategory);
        }
        return productRepository.save(existingProduct);
    }

    @Override
    public boolean deleteProduct(long id) {
        // Kiểm tra xem có order details nào tham chiếu đến sản phẩm này không
        List<OrderDetail> orderDetails = orderDetailRepository.findByProductId(id);
        if (!orderDetails.isEmpty()) {
            throw new DataSaveException("Không thể xóa sản phẩm, có order details tham chiếu đến.");
        }

        // Nếu không có order details tham chiếu, xóa sản phẩm
        Product existingProduct = getProductById(id);
        productRepository.delete(existingProduct);
        return true;
    }

    @Override
    public Product getProductById(long id) {
        return productRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException("Sản phẩm không tồn tại"));
    }

    @Override
    public List<Product> getProductByCategoryId(long categoryId) {
        if(!categoryRepository.existsById(categoryId)){
            throw new DataNotFoundException("Loại không tồn tại");
        }
        return productRepository.findByCategoryId(categoryId);
    }
}

package com.project.QuanLyMyCay.controller;

import com.project.QuanLyMyCay.dtos.ProductDTO;
import com.project.QuanLyMyCay.entity.Product;
import com.project.QuanLyMyCay.exception.DataValidationException;
import com.project.QuanLyMyCay.service.ProductService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@RestController
@CrossOrigin
@RequestMapping("${api.prefix}/products")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;

    @PostMapping("/create")
    public ResponseEntity<String> addProduct(
            @Valid @ModelAttribute ProductDTO productDTO,
            BindingResult result) {
        try {
            // Kiểm tra lỗi dữ liệu đầu vào
            if (result.hasErrors()) {
                String errorMessages = result.getFieldErrors()
                        .stream()
                        .map(FieldError::getDefaultMessage)
                        .collect(Collectors.joining(", "));
                throw new DataValidationException(errorMessages);
            }

            MultipartFile file = productDTO.getFile();
            if (file != null) {
                // Kiểm tra kích thước file
                if (file.getSize() > 10 * 1024 * 1024) { // Kích thước > 10MB
                    throw new ResponseStatusException(
                            HttpStatus.PAYLOAD_TOO_LARGE, "File is too large! Maximum file size is 10MB.");
                }

                // Kiểm tra định dạng file
                String contentType = file.getContentType();
                if (contentType == null || !contentType.startsWith("image/")) {
                    return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
                            .body("File must be an image.");
                }

                // Lưu file và cập nhật ảnh thumbnail
                productDTO.setThumbnail(storeFile(file));
            }

            // Tạo sản phẩm mới
            Product saveProduct = productService.addProduct(productDTO);
            return ResponseEntity.ok("Product has been created successfully.");
        } catch (Exception e) {
            // Xử lý lỗi chung
            return ResponseEntity.badRequest().body("Error: " + e.getMessage());
        }
    }

    @GetMapping(value = "/get-all", produces = "application/json;charset=UTF-8")
    public ResponseEntity<List<Product>> getAllProducts() {
        List<Product> products = productService.getAllProduct();
        return ResponseEntity.ok(products);
    }

    @GetMapping("/category/{id}")
    public ResponseEntity<List<Product>> getProductByCategoryId(@PathVariable long id) {
        List<Product> products = productService.getProductByCategoryId(id);
        return ResponseEntity.ok(products);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<Product> updateProduct(
            @PathVariable long id,
            @Valid @RequestBody ProductDTO productDTO,
            BindingResult result) {
        try {
            if (result.hasErrors()) {
                String errorMessages = result.getFieldErrors()
                        .stream()
                        .map(FieldError::getDefaultMessage)
                        .collect(Collectors.joining(", "));
                throw new DataValidationException(errorMessages);
            }

            MultipartFile file = productDTO.getFile();
            if (file != null) {
                // Kiểm tra kích thước file
                if (file.getSize() > 10 * 1024 * 1024) { // Kích thước > 10MB
                    throw new ResponseStatusException(
                            HttpStatus.PAYLOAD_TOO_LARGE, "File is too large! Maximum file size is 10MB.");
                }

                // Kiểm tra định dạng file
                String contentType = file.getContentType();
                if (contentType == null || !contentType.startsWith("image/")) {
                    throw new ResponseStatusException(HttpStatus.UNSUPPORTED_MEDIA_TYPE, "File must be an image.");
                }

                // Lưu file và cập nhật ảnh thumbnail
                productDTO.setThumbnail(storeFile(file));
            }

            Product updatedProduct = productService.updateProduct(id, productDTO);
            return ResponseEntity.ok(updatedProduct);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(null);
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteProduct(@PathVariable long id) {
        productService.deleteProduct(id);
        return ResponseEntity.ok("Product with ID " + id + " has been deleted successfully.");
    }

    private String storeFile(MultipartFile file) throws IOException {
        // Lấy tên file và tạo tên duy nhất
        String filename = StringUtils.cleanPath(file.getOriginalFilename());
        String uniqueFilename = UUID.randomUUID().toString() + "_" + filename;

        // Đường dẫn lưu trữ file
        Path uploadDir = Paths.get("uploads");
        if (!Files.exists(uploadDir)) {
            Files.createDirectories(uploadDir);
        }

        // Đường dẫn đích
        Path destination = Paths.get(uploadDir.toString(), uniqueFilename);
        Files.copy(file.getInputStream(), destination, StandardCopyOption.REPLACE_EXISTING);

        // Trả về tên file đã được lưu
        return uniqueFilename;
    }
}

package com.project.QuanLyMyCay.service.implementation;

import com.project.QuanLyMyCay.dtos.CategoryDTO;
import com.project.QuanLyMyCay.entity.Category;
import com.project.QuanLyMyCay.entity.Product;
import com.project.QuanLyMyCay.exception.DataNotFoundException;
import com.project.QuanLyMyCay.mapper.CategoryMapper;
import com.project.QuanLyMyCay.repository.CategoryRepository;
import com.project.QuanLyMyCay.repository.ProductRepository;
import com.project.QuanLyMyCay.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final CategoryMapper categoryMapper;

    @Override
    public List<Category> getAllCategory() {
        return categoryRepository.findAll();
    }

    @Override
    public Category getCategoryById(long id) {
        return categoryRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException("Cannot find category with ID: " + id));
    }

    @Override
    public Category createCategory(CategoryDTO categoryDTO) {
        // Kiểm tra xem Category có trùng tên không trước khi tạo mới
        if (categoryRepository.existsByName(categoryDTO.getName())) {
            throw new IllegalArgumentException("Category with name '" + categoryDTO.getName() + "' already exists");
        }

        Category newCategory = categoryMapper.toEntity(categoryDTO);
        return categoryRepository.save(newCategory);
    }

    @Override
    public Category updateCategoryById(long id, CategoryDTO categoryDTO) {
        Category existingCategory = getCategoryById(id);
        // Kiểm tra tên Category mới có khác tên cũ không
        if (!existingCategory.getName().equals(categoryDTO.getName())) {
            if (categoryRepository.existsByName(categoryDTO.getName())) {
                throw new IllegalArgumentException("Category with name '" + categoryDTO.getName() + "' already exists");
            }
            existingCategory.setName(categoryDTO.getName());
            return categoryRepository.save(existingCategory);
        }
        return existingCategory;  // Trả về Category không thay đổi
    }

    @Override
    public void deleteCategoryById(long id) {
        // Kiểm tra xem có sản phẩm nào tham chiếu đến loại này không
        List<Product> products = productRepository.findByCategoryId(id);
        if (!products.isEmpty()) {
            throw new DataIntegrityViolationException("Cannot delete category, products are referencing it.");
        }
        // Nếu không có sản phẩm nào, xóa loại
        Category category = getCategoryById(id);
        categoryRepository.delete(category);
    }
}

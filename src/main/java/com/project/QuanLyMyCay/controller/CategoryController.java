package com.project.QuanLyMyCay.controller;

import com.project.QuanLyMyCay.dtos.CategoryDTO;
import com.project.QuanLyMyCay.entity.Category;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import com.project.QuanLyMyCay.service.CategoryService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("${api.prefix}/categories")
@RequiredArgsConstructor
public class CategoryController {

    private final CategoryService categoryService;

    @PostMapping()
    public ResponseEntity<Category> createCategory(
            @Valid @RequestBody CategoryDTO categoryDTO,
            BindingResult result){
        // Kiểm tra nếu có lỗi trong dữ liệu đầu vào
        if (result.hasErrors()) {
            String errorMessages = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .collect(Collectors.joining(", "));
            throw new IllegalArgumentException(errorMessages);
        }

        Category newCategory =  categoryService.createCategory(categoryDTO);
        return ResponseEntity.ok(newCategory);
    }

    @GetMapping()
    public ResponseEntity<List<Category>> getAllCategories(){

        List<Category> categories =  categoryService.getAllCategory();
        return ResponseEntity.ok(categories);
    }
    @GetMapping("/{id}")
    public ResponseEntity<Category> getCategoryById(@PathVariable Long id){
        Category category =  categoryService.getCategoryById(id);
        return ResponseEntity.ok(category);
    }
    @PutMapping("/{id}")
    public ResponseEntity<Category> updateCategoryById(
            @PathVariable Long id,
            @Valid @RequestBody CategoryDTO categoryDTO
    ){
        Category updateCategory = categoryService.updateCategoryById(id,categoryDTO);
        return ResponseEntity.ok(updateCategory);
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteCategoryById(@PathVariable Long id){
        categoryService.deleteCategoryById(id);
        return ResponseEntity.ok("deleteByRoleById "+id);
    }

}

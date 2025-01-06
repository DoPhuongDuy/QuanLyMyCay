package com.project.QuanLyMyCay.mapper;

import com.project.QuanLyMyCay.dtos.CategoryDTO;
import com.project.QuanLyMyCay.dtos.RoleDTO;
import com.project.QuanLyMyCay.entity.Category;
import org.springframework.stereotype.Component;

@Component
public class CategoryMapper {
    public CategoryDTO toDTO(Category category) {
        return CategoryDTO.builder()
                .id(category.getId())
                .name(category.getName())
                .build();
    }

    public Category toEntity(CategoryDTO categoryDTO) {
        return Category.builder()
                .name(categoryDTO.getName())
                .build();
    }
}

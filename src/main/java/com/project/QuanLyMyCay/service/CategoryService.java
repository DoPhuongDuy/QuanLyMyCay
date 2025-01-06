package com.project.QuanLyMyCay.service;

import com.project.QuanLyMyCay.dtos.CategoryDTO;
import com.project.QuanLyMyCay.entity.Category;

import java.util.List;

public interface CategoryService {
    // Retrieve all roles
    List<Category> getAllCategory();

    // Retrieve a role by its ID
    Category getCategoryById(long id);

    // create a role
    Category createCategory(CategoryDTO categoryDTO);

    Category updateCategoryById(long id, CategoryDTO categoryDTO);

    void deleteCategoryById(long id);
}

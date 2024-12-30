package com.project.QuanLyMyCay.service.implementation;

import com.project.QuanLyMyCay.dtos.CategoryDTO;
import com.project.QuanLyMyCay.entity.Category;
import com.project.QuanLyMyCay.exception.DataNotFoundException;
import com.project.QuanLyMyCay.mapper.CategoryMapper;
import com.project.QuanLyMyCay.repository.CategoryRepository;
import com.project.QuanLyMyCay.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService {

    private final CategoryRepository categoryRepository;
    private final CategoryMapper categoryMapper;


    @Override
    public List<Category> getAllCategory() {
        return categoryRepository.findAll();
    }

    @Override
    public Category getCategoryById(long id) {
        return categoryRepository.findById(id).orElseThrow(()-> new DataNotFoundException("Cannot find category"));
    }

    @Override
    public Category createCategory(CategoryDTO categoryDTO) {
        categoryRepository.existsByName(categoryDTO.getName());
        Category newCategory =  categoryMapper.toEntity(categoryDTO);
        return categoryRepository.save(newCategory);
    }

    @Override
    public Category updateCategoryById(long id, CategoryDTO categoryDTO) {
        Category existingCategory = getCategoryById(id);
        if(!existingCategory.getName().equals(categoryDTO.getName())){
            if(categoryRepository.existsByName(categoryDTO.getName())){
                throw new IllegalArgumentException("Category already exists");
            }
            existingCategory.setName(categoryDTO.getName());
            return categoryRepository.save(existingCategory);
        }
        return null;
    }

    @Override
    public void deleteCategoryById(long id) {
        Optional<Category> optionalCategory = categoryRepository.findById(id);
        optionalCategory.ifPresent(categoryRepository::delete);
    }
}

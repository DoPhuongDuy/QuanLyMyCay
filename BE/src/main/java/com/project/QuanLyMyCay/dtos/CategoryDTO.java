package com.project.QuanLyMyCay.dtos;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
@Getter
@Setter
public class CategoryDTO {

    private long id;

    @NotEmpty(message = "Category name cannot be empty")
    @Size(max = 100, message = "Category name must not exceed 100 characters")
    private String name;
}

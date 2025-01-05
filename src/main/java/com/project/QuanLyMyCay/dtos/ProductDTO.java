package com.project.QuanLyMyCay.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.*;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
@Getter
@Setter
public class ProductDTO {

    private long id;

    @NotEmpty(message = "Product name cannot be empty")
    @Size(max = 255, message = "Product name must not exceed 255 characters") // Tương ứng với VARCHAR(255)
    private String name;

    @NotNull(message = "Price cannot be null")
    @PositiveOrZero(message = "Price must be zero or positive") // CHECK (price >= 0)
    private Double price;

    @Size(max = 255, message = "Thumbnail URL must not exceed 255 characters") // Tương ứng với VARCHAR(255)
    private String thumbnail;

    private String description;

    @NotNull(message = "Category ID cannot be null")
    private long categoryId;

    private boolean status;

    MultipartFile file;
}
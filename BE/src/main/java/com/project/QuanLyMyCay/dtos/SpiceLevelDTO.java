package com.project.QuanLyMyCay.dtos;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
@Getter
@Setter
public class SpiceLevelDTO {

    private long id;  // ID của mức độ gia vị

    @NotNull(message = "Level name cannot be null")
    @Size(max = 100, message = "Level name must not exceed 100 characters")
    private String levelName; // Tên mức độ gia vị
}

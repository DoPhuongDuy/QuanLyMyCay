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
public class RoleDTO {

    @NotEmpty(message = "Role name cannot be empty")
    @Size(max = 64, message = "Role name must not exceed 64 characters")
    private String name; // Tương ứng với varchar(64)

}

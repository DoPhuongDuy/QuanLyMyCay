package com.project.QuanLyMyCay.dtos;


import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserDTO {

    private long id;

    @NotEmpty(message = "User name cannot be empty")
    @Size(max = 100, message = "User name must not exceed 100 characters")
    private String name;

    @NotEmpty(message = "Password cannot be empty")
    @Size(max = 100, message = "Password must not exceed 100 characters")
    private String password;

    @NotEmpty(message = "Password cannot be empty")
    @Size(max = 100, message = "Password must not exceed 100 characters")
    private String retype_password; // Mật khẩu nhập lại

    private long roleId;

    private boolean isActive;
}

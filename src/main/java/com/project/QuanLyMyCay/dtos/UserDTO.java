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

    @NotEmpty(message = "Name cannot be empty")
    @Size(max = 100, message = "Name cannot exceed 100 characters")
    private String name; // Tên người dùng

    @NotEmpty(message = "Password cannot be empty")
    @Size(min = 6, max = 100, message = "Password must be between 6 and 100 characters")
    private String password; // Mật khẩu

    @NotEmpty(message = "Password cannot be empty")
    @Size(min = 6, max = 100, message = "Password must be between 6 and 100 characters")
    private String getRetype_password; // Mật khẩu nhập lại

    @NotNull(message = "Role ID cannot be null")
    private Long roleId; // ID của vai trò (khóa ngoại)

    private boolean isActive; // Trạng thái hoạt động (mặc định là true)
}

package com.project.QuanLyMyCay.controller;

import com.project.QuanLyMyCay.dtos.UserDTO;
import com.project.QuanLyMyCay.dtos.UserLoginDTO;
import com.project.QuanLyMyCay.entity.User;
import com.project.QuanLyMyCay.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.stream.Collectors;

@RestController
@RequestMapping("${api.prefix}/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @PostMapping("/register")
    public ResponseEntity<String> createUser(
            @Valid @RequestBody UserDTO userDTO,
            BindingResult result)
    {
        // Kiểm tra nếu có lỗi trong dữ liệu đầu vào
        if (result.hasErrors()) {
            String errorMessages = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .collect(Collectors.joining(", "));
            throw new IllegalArgumentException(errorMessages);
        }

        // Kiểm tra mật khẩu và nhập lại mật khẩu
        if(!userDTO.getPassword().equals(userDTO.getGetRetype_password())){
            return ResponseEntity.badRequest().body("Password doesn't match");
        }

        userService.createUser(userDTO);
        return ResponseEntity.ok("Register successfully"+userDTO);
    }

    @GetMapping("/{id}")
    public ResponseEntity<User> getUserById(
            @PathVariable("id") long id
    ){
        User existingUser = userService.getUserById(id);
        return ResponseEntity.ok(existingUser);
    }

    @PostMapping("/login")
    public ResponseEntity<String> login(
            @Valid @RequestBody UserLoginDTO userLoginDTO
    ){
        String token;
        try{
            token = userService.login(userLoginDTO.getName(), userLoginDTO.getPassword());
            return ResponseEntity.ok(token);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}

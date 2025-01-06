package com.project.QuanLyMyCay.service;


import com.project.QuanLyMyCay.dtos.UserDTO;
import com.project.QuanLyMyCay.entity.User;

public interface UserService {
    User createUser(UserDTO userDTO);

    public User getUserById(long id);

    String login(String account, String pwd);
}
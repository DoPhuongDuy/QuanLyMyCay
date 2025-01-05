package com.project.QuanLyMyCay.service.implementation;

import com.project.QuanLyMyCay.components.JwtTokenUtil;
import com.project.QuanLyMyCay.dtos.UserDTO;
import com.project.QuanLyMyCay.entity.Role;
import com.project.QuanLyMyCay.entity.User;
import com.project.QuanLyMyCay.exception.AlreadyExistsException;
import com.project.QuanLyMyCay.exception.DataValidationException;
import com.project.QuanLyMyCay.mapper.UserMapper;
import com.project.QuanLyMyCay.repository.UserRepository;
import com.project.QuanLyMyCay.service.RoleService;
import com.project.QuanLyMyCay.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.DateTimeException;
import java.util.Optional;


@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final AuthenticationManager authenticationManager;
    private final PasswordEncoder passwordEncoder;
    private final RoleService roleService;
    private final UserRepository userRepository;
    private final UserMapper userMapper;
    private final JwtTokenUtil jwtTokenUtil;
    @Override
    public User createUser(UserDTO userDTO) {
        //trung Email, phone
        if (userRepository.existsByName(userDTO.getName())) {
            throw new AlreadyExistsException("Account already exists");
        }
        Role setRole = roleService.getRoleById(userDTO.getRoleId());
        User newUser = userMapper.toEntity(userDTO, setRole);

        String pwd = userDTO.getPassword();
        String encodedPassword = passwordEncoder.encode(pwd);
        newUser.setPassword(encodedPassword);

        return userRepository.save(newUser);
    }

    @Override
    public User getUserById(long id){
        try{
            return  userRepository.findById(id)
                    .orElseThrow(()->new DateTimeException("User Not Found with id "+id));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public String login(String name, String password) {
        Optional<User> optionalUser = userRepository.findByName(name);
        if(optionalUser.isEmpty()){
            throw new DataValidationException("Invalid name / password");
        }
        //trả về token
        User existingUser = optionalUser.get();
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                name,password,existingUser.getAuthorities()
        );
        //xác thực người dùng với sping secuiry
        authenticationManager.authenticate(authenticationToken);

        return jwtTokenUtil.generateToken(optionalUser.get());
    }
}

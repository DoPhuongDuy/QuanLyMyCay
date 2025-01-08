package com.project.QuanLyMyCay.configuration;

import com.project.QuanLyMyCay.components.JwtTokenFilter;
import com.project.QuanLyMyCay.entity.Role;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.web.configurers.CorsConfigurer;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;
import java.util.List;

import static org.springframework.http.HttpMethod.*;
import static org.springframework.http.HttpMethod.DELETE;


@Configuration
@EnableMethodSecurity
@RequiredArgsConstructor
public class WebSecurityConfig {

    @Value("${api.prefix}")
    private String apiPrefix;

    private final JwtTokenFilter jwtTokenFilter;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception{
         http
                 .addFilterBefore(jwtTokenFilter, UsernamePasswordAuthenticationFilter.class)
                 .authorizeHttpRequests(request -> {
                     request.requestMatchers(
                                     String.format("%s/users/register",apiPrefix),
                                     String.format("%s/users/login",apiPrefix),
                                     String.format("%s/categories/get-all",apiPrefix),
                                     String.format("%s/products/get-all",apiPrefix),
                                     String.format("%s/spice-levels/get-all",apiPrefix)
                             )
                             .permitAll()
                             //ADMIN
                             .requestMatchers(POST,
                                     String.format("%s/categories/create",apiPrefix),
                                     String.format("%s/products/create",apiPrefix)
                             ).hasRole(Role.ADMIN)
//                             .requestMatchers(GET,
//                                     String.format("%s/products/category/{id}", apiPrefix)
//                             ).hasRole(Role.ADMIN)
                             .requestMatchers(PUT,
                                     String.format("%s/categories/update/{id}",apiPrefix),
                                     String.format("%s/products/update/{id}",apiPrefix)
                             ).hasRole(Role.ADMIN)
                             .requestMatchers(DELETE,
                                     String.format("%s/categories/delete/{id}",apiPrefix),
                                     String.format("%s/products/delete/{id}",apiPrefix)
                             ).hasRole(Role.ADMIN)

                             //User
                             .requestMatchers(GET,
                                     String.format("%s/orders/get-all-active",apiPrefix)).hasRole(Role.KITCHEN)
                             //
                             .requestMatchers(GET,
                                     String.format("%s/products/images/*", apiPrefix),
                                     String.format("%s/roles/token",apiPrefix),
                                     String.format("%s/products/category/{id}", apiPrefix)
                             ).permitAll()
                             // cho 3 thang
                             .requestMatchers(POST,
                                     String.format("%s/orders/create", apiPrefix)
                             ).hasAnyRole(Role.ADMIN, Role.USER, Role.KITCHEN)
                             .anyRequest().authenticated();
                 })
                 .csrf(AbstractHttpConfigurer::disable);
         http.cors(new Customizer<CorsConfigurer<HttpSecurity>>() {
             @Override
             public void customize(CorsConfigurer<HttpSecurity> httpSecurityCorsConfigurer) {
                 //Đồng ý tất ai cũng cho phép
                 CorsConfiguration configuration = new CorsConfiguration();
                 configuration.setAllowedOrigins(List.of("*"));
                 configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"));
                 configuration.setAllowedHeaders(Arrays.asList("authorization", "content-type", "x-auth-token"));
                 configuration.setExposedHeaders(List.of("x-auth-token"));
                 UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
                 source.registerCorsConfiguration("/**", configuration);
                 httpSecurityCorsConfigurer.configurationSource(source);
             }
         });
         return http.build();
    }
}

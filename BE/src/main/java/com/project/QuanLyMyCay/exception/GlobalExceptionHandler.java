package com.project.QuanLyMyCay.exception;

import com.project.QuanLyMyCay.dtos.ResponseDTO.ErrorResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.server.ResponseStatusException;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(DataNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleDataNotFoundException(DataNotFoundException ex) {
        ErrorResponse errorResponse = new ErrorResponse(
                ex.getMessage(),
                HttpStatus.NOT_FOUND.value(),
                HttpStatus.NOT_FOUND.getReasonPhrase()
        );
        return ResponseEntity
                .status(HttpStatus.NOT_FOUND)
                .body(errorResponse);
    }
    @ExceptionHandler(AlreadyExistsException.class)
    public ResponseEntity<ErrorResponse> handleNameAlreadyExistsException(AlreadyExistsException ex) {
        ErrorResponse errorResponse = new ErrorResponse(
                ex.getMessage(),
                HttpStatus.CONFLICT.value(),
                "NAME_ALREADY_EXISTS"
        );
        return ResponseEntity.status(HttpStatus.CONFLICT).body(errorResponse);
    }
    @ExceptionHandler(DataValidationException.class)
    public ResponseEntity<ErrorResponse> handleDataValidationException(DataValidationException ex) {
        ErrorResponse errorResponse = new ErrorResponse(
                ex.getMessage(),
                HttpStatus.BAD_REQUEST.value(),
                "DATA_VALIDATION_ERROR"
        );
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
    }
    @ExceptionHandler(DataSaveException.class)
    public ResponseEntity<ErrorResponse> handleDataSaveException(DataSaveException ex) {
        ErrorResponse errorResponse = new ErrorResponse(
                ex.getMessage(),  // Sử dụng message từ exception
                HttpStatus.INTERNAL_SERVER_ERROR.value(), // HTTP 500 Internal Server Error
                "DATA_SAVE_ERROR" // Mã lỗi tùy chỉnh
        );
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
    }

//    @ExceptionHandler(Exception.class)
//    public ResponseEntity<ErrorResponse> handleGenericException(Exception ex) {
//        // Trả về DTO ErrorResponse với thông báo lỗi chung
//        ErrorResponse errorResponse = new ErrorResponse(
//                "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.",
//                HttpStatus.INTERNAL_SERVER_ERROR.value(),
//                HttpStatus.INTERNAL_SERVER_ERROR.getReasonPhrase()
//        );
//        return ResponseEntity
//                .status(HttpStatus.INTERNAL_SERVER_ERROR)
//                .body(errorResponse);
//    }
}
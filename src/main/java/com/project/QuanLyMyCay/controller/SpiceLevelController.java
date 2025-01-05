package com.project.QuanLyMyCay.controller;

import com.project.QuanLyMyCay.dtos.SpiceLevelDTO;
import com.project.QuanLyMyCay.entity.SpiceLevel;
import com.project.QuanLyMyCay.exception.DataValidationException;
import com.project.QuanLyMyCay.service.SpiceLevelService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("${api.prefix}/spice-levels")
@RequiredArgsConstructor
public class SpiceLevelController {

    private final SpiceLevelService spiceLevelService;

    @PostMapping()
    public ResponseEntity<SpiceLevel> createSpiceLevel(
            @Valid @RequestBody SpiceLevelDTO spiceLevelDTO,
            BindingResult result) {
        // Kiểm tra nếu có lỗi trong dữ liệu đầu vào
        if (result.hasErrors()) {
            String errorMessages = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .collect(Collectors.joining(", "));
            throw new DataValidationException(errorMessages);
        }

        SpiceLevel newSpiceLevel = spiceLevelService.createSpiceLevel(spiceLevelDTO);
        return ResponseEntity.ok(newSpiceLevel);
    }

    @GetMapping()
    public ResponseEntity<List<SpiceLevel>> getAllSpiceLevels() {
        List<SpiceLevel> spiceLevels = spiceLevelService.getAllSpiceLevels();
        return ResponseEntity.ok(spiceLevels);
    }

    @GetMapping("/{id}")
    public ResponseEntity<SpiceLevel> getSpiceLevelById(@PathVariable long id) {
        SpiceLevel spiceLevel = spiceLevelService.getSpiceLevelById(id);
        return ResponseEntity.ok(spiceLevel);
    }

    @PutMapping("/{id}")
    public ResponseEntity<SpiceLevel> updateSpiceLevelById(
            @PathVariable long id,
            @Valid @RequestBody SpiceLevelDTO spiceLevelDTO) {
        SpiceLevel updatedSpiceLevel = spiceLevelService.updateSpiceLevelById(id, spiceLevelDTO);
        return ResponseEntity.ok(updatedSpiceLevel);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteSpiceLevelById(@PathVariable long id) {
        spiceLevelService.deleteSpiceLevelById(id);
        return ResponseEntity.ok("deleteBySpiceLevelId " + id);
    }
}

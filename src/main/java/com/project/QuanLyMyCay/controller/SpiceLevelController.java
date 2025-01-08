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
@CrossOrigin
@RequestMapping("${api.prefix}/spice-levels")
@RequiredArgsConstructor
public class SpiceLevelController {

    private final SpiceLevelService spiceLevelService;

    @PostMapping("/create")
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

    @GetMapping("/get-all")
    public ResponseEntity<List<SpiceLevel>> getAllSpiceLevels() {
        List<SpiceLevel> spiceLevels = spiceLevelService.getAllSpiceLevels();
        return ResponseEntity.ok(spiceLevels);
    }

    @GetMapping("/get/{id}")
    public ResponseEntity<SpiceLevel> getSpiceLevelById(@PathVariable long id) {
        SpiceLevel spiceLevel = spiceLevelService.getSpiceLevelById(id);
        return ResponseEntity.ok(spiceLevel);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<SpiceLevel> updateSpiceLevelById(
            @PathVariable long id,
            @Valid @RequestBody SpiceLevelDTO spiceLevelDTO) {
        SpiceLevel updatedSpiceLevel = spiceLevelService.updateSpiceLevelById(id, spiceLevelDTO);
        return ResponseEntity.ok(updatedSpiceLevel);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteSpiceLevelById(@PathVariable long id) {
        spiceLevelService.deleteSpiceLevelById(id);
        return ResponseEntity.ok("deleteBySpiceLevelId " + id);
    }
}

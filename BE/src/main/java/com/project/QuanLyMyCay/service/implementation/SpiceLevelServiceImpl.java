package com.project.QuanLyMyCay.service.implementation;

import com.project.QuanLyMyCay.dtos.SpiceLevelDTO;
import com.project.QuanLyMyCay.entity.SpiceLevel;
import com.project.QuanLyMyCay.exception.AlreadyExistsException;
import com.project.QuanLyMyCay.exception.DataNotFoundException;
import com.project.QuanLyMyCay.mapper.SpiceLevelMapper;
import com.project.QuanLyMyCay.repository.SpiceLevelRepository;
import com.project.QuanLyMyCay.service.SpiceLevelService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SpiceLevelServiceImpl implements SpiceLevelService {

    private final SpiceLevelRepository spiceLevelRepository;
    private final SpiceLevelMapper spiceLevelMapper;

    @Override
    public List<SpiceLevel> getAllSpiceLevels() {
        return spiceLevelRepository.findAll();
    }

    @Override
    public SpiceLevel getSpiceLevelById(long id) {
        return spiceLevelRepository.findById(id)
                .orElseThrow(() -> new DataNotFoundException("Cannot find spice level with ID: " + id));
    }

    @Override
    public SpiceLevel createSpiceLevel(SpiceLevelDTO spiceLevelDTO) {
        // Kiểm tra tên spice level có trùng hay không
        if (spiceLevelRepository.existsByLevelName(spiceLevelDTO.getLevelName())) {
            throw new AlreadyExistsException("Spice level with name '" + spiceLevelDTO.getLevelName() + "' already exists");
        }

        SpiceLevel newSpiceLevel = spiceLevelMapper.toEntity(spiceLevelDTO);
        return spiceLevelRepository.save(newSpiceLevel);
    }

    @Override
    public SpiceLevel updateSpiceLevelById(long id, SpiceLevelDTO spiceLevelDTO) {
        SpiceLevel existingSpiceLevel = getSpiceLevelById(id);
        // Kiểm tra nếu tên mới khác tên cũ
        if (!existingSpiceLevel.getLevelName().equals(spiceLevelDTO.getLevelName())) {
            if (spiceLevelRepository.existsByLevelName(spiceLevelDTO.getLevelName())) {
                throw new AlreadyExistsException("Spice level with name '" + spiceLevelDTO.getLevelName() + "' already exists");
            }
            existingSpiceLevel.setLevelName(spiceLevelDTO.getLevelName());
            return spiceLevelRepository.save(existingSpiceLevel);
        }
        return existingSpiceLevel; // Trả về SpiceLevel không thay đổi
    }

    @Override
    public void deleteSpiceLevelById(long id) {
        SpiceLevel spiceLevel = getSpiceLevelById(id);
        // Kiểm tra xem có tham chiếu nào khác không (nếu cần)
        // Ví dụ: Nếu có bảng liên kết khác sử dụng SpiceLevel
        spiceLevelRepository.delete(spiceLevel);
    }
}

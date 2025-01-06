package com.project.QuanLyMyCay.mapper;

import com.project.QuanLyMyCay.dtos.SpiceLevelDTO;
import com.project.QuanLyMyCay.entity.SpiceLevel;
import org.springframework.stereotype.Component;

@Component
public class SpiceLevelMapper {

    public SpiceLevelDTO toDTO(SpiceLevel spiceLevel) {
        return SpiceLevelDTO.builder()
                .id(spiceLevel.getId())
                .levelName(spiceLevel.getLevelName())
                .build();
    }

    public SpiceLevel toEntity(SpiceLevelDTO spiceLevelDTO) {
        return SpiceLevel.builder()
                .id(spiceLevelDTO.getId())
                .levelName(spiceLevelDTO.getLevelName())
                .build();
    }
}

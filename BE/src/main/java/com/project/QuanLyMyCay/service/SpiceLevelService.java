package com.project.QuanLyMyCay.service;

import com.project.QuanLyMyCay.dtos.SpiceLevelDTO;
import com.project.QuanLyMyCay.entity.SpiceLevel;

import java.util.List;

public interface SpiceLevelService {
    List<SpiceLevel> getAllSpiceLevels();

    SpiceLevel getSpiceLevelById(long id);

    SpiceLevel createSpiceLevel(SpiceLevelDTO spiceLevelDTO);

    SpiceLevel updateSpiceLevelById(long id, SpiceLevelDTO spiceLevelDTO);

    void deleteSpiceLevelById(long id);
}

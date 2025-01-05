package com.project.QuanLyMyCay.repository;

import com.project.QuanLyMyCay.entity.SpiceLevel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SpiceLevelRepository extends JpaRepository<SpiceLevel, Long> {
    boolean existsByLevelName(String levelName);
}

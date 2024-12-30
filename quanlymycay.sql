-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2024 at 12:34 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quanlymycay`
--

-- --------------------------------------------------------

--
-- Table structure for table `ban`
--

CREATE TABLE `ban` (
  `BanID` int(11) NOT NULL,
  `TenBan` varchar(255) DEFAULT NULL,
  `TrangThai` tinyint(1) DEFAULT 1,
  `GhiChu` text DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `ModifiedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chitiethoadon`
--

CREATE TABLE `chitiethoadon` (
  `HoaDonID` int(11) NOT NULL,
  `MonAnID` int(11) NOT NULL,
  `GhiChu` text DEFAULT NULL,
  `SoLuong` int(11) NOT NULL,
  `DonGia` decimal(10,2) NOT NULL,
  `ThanhTien` decimal(10,2) GENERATED ALWAYS AS (`SoLuong` * `DonGia`) STORED,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `ModifiedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hoadon`
--

CREATE TABLE `hoadon` (
  `HoaDonID` int(11) NOT NULL,
  `MaHoaDon` varchar(50) NOT NULL,
  `NgayLap` datetime DEFAULT current_timestamp(),
  `TongTien` decimal(10,2) DEFAULT 0.00,
  `GhiChu` text DEFAULT NULL,
  `BanID` int(11) DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `ModifiedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loaimon`
--

CREATE TABLE `loaimon` (
  `LoaiMonID` int(11) NOT NULL,
  `TenLoai` varchar(255) NOT NULL,
  `MoTa` text DEFAULT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `ModifiedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mapping_loai`
--

CREATE TABLE `mapping_loai` (
  `MonAnID` int(11) NOT NULL,
  `LoaiMonID` int(11) NOT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `ModifiedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mapping_role`
--

CREATE TABLE `mapping_role` (
  `UserID` int(11) NOT NULL,
  `RoleID` int(11) NOT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `ModifiedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menumonan`
--

CREATE TABLE `menumonan` (
  `MonAnID` int(11) NOT NULL,
  `TenMon` varchar(255) NOT NULL,
  `MoTa` text DEFAULT NULL,
  `Gia` decimal(10,2) NOT NULL,
  `TinhTrang` tinyint(1) DEFAULT 1,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `ModifiedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `RoleID` int(11) NOT NULL,
  `FullName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `CreatedAt` datetime DEFAULT current_timestamp(),
  `ModifiedAt` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ban`
--
ALTER TABLE `ban`
  ADD PRIMARY KEY (`BanID`);

--
-- Indexes for table `chitiethoadon`
--
ALTER TABLE `chitiethoadon`
  ADD PRIMARY KEY (`HoaDonID`,`MonAnID`),
  ADD KEY `MonAnID` (`MonAnID`);

--
-- Indexes for table `hoadon`
--
ALTER TABLE `hoadon`
  ADD PRIMARY KEY (`HoaDonID`),
  ADD KEY `BanID` (`BanID`);

--
-- Indexes for table `loaimon`
--
ALTER TABLE `loaimon`
  ADD PRIMARY KEY (`LoaiMonID`);

--
-- Indexes for table `mapping_loai`
--
ALTER TABLE `mapping_loai`
  ADD PRIMARY KEY (`MonAnID`,`LoaiMonID`),
  ADD KEY `LoaiMonID` (`LoaiMonID`);

--
-- Indexes for table `mapping_role`
--
ALTER TABLE `mapping_role`
  ADD PRIMARY KEY (`UserID`,`RoleID`),
  ADD KEY `RoleID` (`RoleID`);

--
-- Indexes for table `menumonan`
--
ALTER TABLE `menumonan`
  ADD PRIMARY KEY (`MonAnID`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`RoleID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ban`
--
ALTER TABLE `ban`
  MODIFY `BanID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hoadon`
--
ALTER TABLE `hoadon`
  MODIFY `HoaDonID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loaimon`
--
ALTER TABLE `loaimon`
  MODIFY `LoaiMonID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menumonan`
--
ALTER TABLE `menumonan`
  MODIFY `MonAnID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `RoleID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chitiethoadon`
--
ALTER TABLE `chitiethoadon`
  ADD CONSTRAINT `chitiethoadon_ibfk_1` FOREIGN KEY (`HoaDonID`) REFERENCES `hoadon` (`HoaDonID`),
  ADD CONSTRAINT `chitiethoadon_ibfk_2` FOREIGN KEY (`MonAnID`) REFERENCES `menumonan` (`MonAnID`);

--
-- Constraints for table `hoadon`
--
ALTER TABLE `hoadon`
  ADD CONSTRAINT `hoadon_ibfk_1` FOREIGN KEY (`BanID`) REFERENCES `ban` (`BanID`);

--
-- Constraints for table `mapping_loai`
--
ALTER TABLE `mapping_loai`
  ADD CONSTRAINT `mapping_loai_ibfk_1` FOREIGN KEY (`MonAnID`) REFERENCES `menumonan` (`MonAnID`),
  ADD CONSTRAINT `mapping_loai_ibfk_2` FOREIGN KEY (`LoaiMonID`) REFERENCES `loaimon` (`LoaiMonID`);

--
-- Constraints for table `mapping_role`
--
ALTER TABLE `mapping_role`
  ADD CONSTRAINT `mapping_role_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`),
  ADD CONSTRAINT `mapping_role_ibfk_2` FOREIGN KEY (`RoleID`) REFERENCES `role` (`RoleID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

USE QuanLiChuyenBay;
GO

SET DATEFORMAT ymd;
GO

-- 1. CHÈN SÂN BAY (SANBAY)

INSERT INTO dbo.SANBAY (MaSB, TenSB, ThanhPho, QuocGia) VALUES
('HAN', N'Sân bay Quốc tế Nội Bài', N'Hà Nội', N'Việt Nam'),
('SGN', N'Sân bay Quốc tế Tân Sơn Nhất', N'Hồ Chí Minh', N'Việt Nam'),
('DAD', N'Sân bay Quốc tế Đà Nẵng', N'Đà Nẵng', N'Việt Nam'),
('CXR', N'Sân bay Quốc tế Cam Ranh', N'Nha Trang', N'Việt Nam'),
('PQC', N'Sân bay Quốc tế Phú Quốc', N'Phú Quốc', N'Việt Nam');
GO

-- 2. CHÈN HÃNG HÀNG KHÔNG (HANGHANGKHONG)
INSERT INTO dbo.HANGHANGKHONG (MaHHK, TenHHK, QuocGia) VALUES
('HVN', N'Vietnam Airlines', N'Việt Nam'),
('VJC', N'Vietjet Air', N'Việt Nam'),
('BAV', N'Bamboo Airways', N'Việt Nam'),
('VTA', N'Vietravel Airlines', N'Việt Nam');
GO


-- 3. CHÈN LOẠI MÁY BAY (LOAIMAYBAY)
INSERT INTO dbo.LOAIMAYBAY (MaLoai, TenLoaiMB, SucChua) VALUES
('A321', N'Airbus A321neo', 220),
('A350', N'Airbus A350-900', 305),
('B787', N'Boeing 787-9 Dreamliner', 300),
('ATR7', N'ATR 72-600', 78);
GO


-- 4. CHÈN MÁY BAY (MAYBAY)

INSERT INTO dbo.MAYBAY (SoHieu, MaLoai, MaHHK, TrangThai) VALUES
('VN-A611', 'A321', 'HVN', N'Hoat dong'),
('VN-A868', 'B787', 'HVN', N'Hoat dong'),
('VJ-A321', 'A321', 'VJC', N'Hoat dong'),
('BB-A350', 'A350', 'BAV', N'Hoat dong'),
('VT-ATR7', 'ATR7', 'VTA', N'Bao tri');
GO

-- 5. CHÈN CHUYẾN BAY TỪ - ĐẾN (CHUYENBAY)
INSERT INTO dbo.CHUYENBAY (MaCB, MaSB_Di, MaSB_Den) VALUES
('CB-HANSGN', 'HAN', 'SGN'),
('CB-SGNHAN', 'SGN', 'HAN'),
('HAN-DAD01', 'HAN', 'DAD'),
('DAD-SGN01', 'DAD', 'SGN'),
('SGN-PQC01', 'SGN', 'PQC');
GO


-- 6. CHÈN LỊCH BAY

INSERT INTO dbo.LICHBAY (MaLich, MaCB, SoHieuMB, ThoiGianDi, ThoiGianDen, TrangThai) VALUES
('LB2401', 'CB-HANSGN', 'VN-A611', '2024-01-15 08:00:00', '2024-01-15 10:15:00', N'Dung gio'),
('LB2402', 'CB-SGNHAN', 'VJ-A321', '2024-02-18 14:00:00', '2024-02-18 16:15:00', N'Dung gio'),
('LB2403', 'HAN-DAD01', 'VN-A868', '2024-03-12 09:00:00', '2024-03-12 10:20:00', N'Tre'),
('LB2404', 'DAD-SGN01', 'BB-A350', '2024-04-20 16:00:00', '2024-04-20 17:30:00', N'Dung gio'),
('LB2405', 'SGN-PQC01', 'VN-A611', '2024-05-05 07:00:00', '2024-05-05 08:00:00', N'Dung gio'),
('LB2406', 'CB-HANSGN', 'VJ-A321', '2024-06-22 11:00:00', '2024-06-22 13:15:00', N'Dung gio'),
('LB2407', 'CB-SGNHAN', 'VN-A868', '2024-07-19 20:00:00', '2024-07-19 22:15:00', N'Dung gio'),
('LB2408', 'HAN-DAD01', 'BB-A350', '2024-08-11 05:30:00', '2024-08-11 06:50:00', N'Dung gio'),
('LB2409', 'DAD-SGN01', 'VN-A611', '2024-09-09 13:00:00', '2024-09-09 14:30:00', N'Dung gio'),
('LB2410', 'SGN-PQC01', 'VJ-A321', '2024-10-14 18:00:00', '2024-10-14 19:00:00', N'Dung gio');


INSERT INTO dbo.LICHBAY (MaLich, MaCB, SoHieuMB, ThoiGianDi, ThoiGianDen, TrangThai) VALUES
('LB2501', 'CB-HANSGN', 'VN-A611', '2025-01-15 08:00:00', '2025-01-15 10:15:00', N'Dung gio'),
('LB2502', 'CB-SGNHAN', 'VJ-A321', '2025-02-18 14:00:00', '2025-02-18 16:15:00', N'Dung gio'),
('LB2503', 'HAN-DAD01', 'VN-A868', '2025-03-12 09:00:00', '2025-03-12 10:20:00', N'Dung gio'),
('LB2504', 'DAD-SGN01', 'BB-A350', '2025-04-20 16:00:00', '2025-04-20 17:30:00', N'Tre'),
('LB2505', 'SGN-PQC01', 'VN-A611', '2025-05-05 07:00:00', '2025-05-05 08:00:00', N'Dung gio'),
('LB2506', 'CB-HANSGN', 'VJ-A321', '2025-06-22 11:00:00', '2025-06-22 13:15:00', N'Dung gio'),
('LB2507', 'CB-SGNHAN', 'VN-A868', '2025-07-19 20:00:00', '2025-07-19 22:15:00', N'Dung gio'),
('LB2508', 'HAN-DAD01', 'BB-A350', '2025-08-11 05:30:00', '2025-08-11 06:50:00', N'Dung gio'),
('LB2509', 'DAD-SGN01', 'VN-A611', '2025-09-09 13:00:00', '2025-09-09 14:30:00', N'Dung gio'),
('LB2510', 'SGN-PQC01', 'VJ-A321', '2025-10-14 18:00:00', '2025-10-14 19:00:00', N'Dung gio');


INSERT INTO dbo.LICHBAY (MaLich, MaCB, SoHieuMB, ThoiGianDi, ThoiGianDen, TrangThai) VALUES
('LB2601', 'CB-HANSGN', 'VN-A611', '2026-01-15 08:00:00', '2026-01-15 10:15:00', N'Dung gio'),
('LB2602', 'CB-SGNHAN', 'VJ-A321', '2026-02-18 14:00:00', '2026-02-18 16:15:00', N'Dung gio'),
('LB2603', 'HAN-DAD01', 'VN-A868', '2026-03-12 09:00:00', '2026-03-12 10:20:00', N'Dung gio'),
('LB2604', 'DAD-SGN01', 'BB-A350', '2026-04-20 16:00:00', '2026-04-20 17:30:00', N'Dung gio'),
('LB2605', 'SGN-PQC01', 'VN-A611', '2026-05-05 07:00:00', '2026-05-05 08:00:00', N'Tre'),
('LB2606', 'CB-HANSGN', 'VJ-A321', '2026-06-22 11:00:00', '2026-06-22 13:15:00', N'Dung gio'),
('LB2607', 'CB-SGNHAN', 'VN-A868', '2026-07-19 20:00:00', '2026-07-19 22:15:00', N'Dung gio'),
('LB2608', 'HAN-DAD01', 'BB-A350', '2026-08-11 05:30:00', '2026-08-11 06:50:00', N'Dung gio'),
('LB2609', 'DAD-SGN01', 'VN-A611', '2026-09-09 13:00:00', '2026-09-09 14:30:00', N'Dung gio'),
('LB2610', 'SGN-PQC01', 'VJ-A321', '2026-10-14 18:00:00', '2026-10-14 19:00:00', N'Dung gio');
GO

-- 7. CHÈN BẢNG GIÁ VÉ (BANGGIAVE)
INSERT INTO dbo.BANGGIAVE (MaGia, MaLich, HangGhe, Gia, ThoiDiemBatDau, ThoiDiemKetThuc) VALUES
('G2401', 'LB2401', N'Pho thong', 1200000.00, '2023-11-01', '2024-01-14'),
('G2402', 'LB2402', N'Pho thong', 1300000.00, '2023-11-01', '2024-02-17'),
('G2403', 'LB2403', N'Pho thong', 1100000.00, '2023-11-01', '2024-03-11'),
('G2404', 'LB2404', N'Pho thong', 1400000.00, '2023-11-01', '2024-04-19'),
('G2405', 'LB2405', N'Pho thong', 1000000.00, '2023-11-01', '2024-05-04'),
('G2406', 'LB2406', N'Pho thong', 1500000.00, '2023-11-01', '2024-06-21'),
('G2407', 'LB2407', N'Thuong gia', 2500000.00, '2023-11-01', '2024-07-18'),
('G2408', 'LB2408', N'Pho thong', 1200000.00, '2023-11-01', '2024-08-10'),
('G2409', 'LB2409', N'Pho thong', 1350000.00, '2023-11-01', '2024-09-08'),
('G2410', 'LB2410', N'Pho thong', 1150000.00, '2023-11-01', '2024-10-13');


INSERT INTO dbo.BANGGIAVE (MaGia, MaLich, HangGhe, Gia, ThoiDiemBatDau, ThoiDiemKetThuc) VALUES
('G2501', 'LB2501', N'Pho thong', 1800000.00, '2024-11-01', '2025-01-14'),
('G2502', 'LB2502', N'Pho thong', 1900000.00, '2024-11-01', '2025-02-17'),
('G2503', 'LB2503', N'Pho thong', 1600000.00, '2024-11-01', '2025-03-11'),
('G2504', 'LB2504', N'Pho thong', 2100000.00, '2024-11-01', '2025-04-19'),
('G2505', 'LB2505', N'Pho thong', 1500000.00, '2024-11-01', '2025-05-04'),
('G2506', 'LB2506', N'Pho thong', 2200000.00, '2024-11-01', '2025-06-21'),
('G2507', 'LB2507', N'Thuong gia', 3500000.00, '2024-11-01', '2025-07-18'),
('G2508', 'LB2508', N'Pho thong', 1850000.00, '2024-11-01', '2025-08-10'),
('G2509', 'LB2509', N'Pho thong', 2000000.00, '2024-11-01', '2025-09-08'),
('G2510', 'LB2510', N'Pho thong', 1750000.00, '2024-11-01', '2025-10-13');


INSERT INTO dbo.BANGGIAVE (MaGia, MaLich, HangGhe, Gia, ThoiDiemBatDau, ThoiDiemKetThuc) VALUES
('G2601', 'LB2601', N'Pho thong', 2500000.00, '2025-11-01', '2026-01-14'),
('G2602', 'LB2602', N'Pho thong', 2700000.00, '2025-11-01', '2026-02-17'),
('G2603', 'LB2603', N'Pho thong', 2400000.00, '2025-11-01', '2026-03-11'),
('G2604', 'LB2604', N'Pho thong', 2900000.00, '2025-11-01', '2026-04-19'),
('G2605', 'LB2605', N'Pho thong', 2200000.00, '2025-11-01', '2026-05-04'),
('G2606', 'LB2606', N'Pho thong', 3100000.00, '2025-11-01', '2026-06-21'),
('G2607', 'LB2607', N'Thuong gia', 5000000.00, '2025-11-01', '2026-07-18'),
('G2608', 'LB2608', N'Pho thong', 2600000.00, '2025-11-01', '2026-08-10'),
('G2609', 'LB2609', N'Pho thong', 2800000.00, '2025-11-01', '2026-09-08'),
('G2610', 'LB2610', N'Pho thong', 2550000.00, '2025-11-01', '2026-10-13');
GO

-- 8. CHÈN HÀNH KHÁCH (HANHKHACH)

INSERT INTO dbo.HANHKHACH (MaHK, HoTen, CCCD, SDT, Email, NgaySinh, GioiTinh, QuocTich, SoHoChieu) VALUES
('HK0001', N'Nguyễn Văn Ánh', '031095001234', '0901234567', 'anh.nv@gmail.com', '1995-04-12', N'Nam', N'Việt Nam', NULL),
('HK0002', N'Trần Thị Bình', '001098005678', '0912345678', 'binh.tt@yahoo.com', '1998-08-23', N'Nu', N'Việt Nam', NULL),
('HK0003', N'Lê Hoàng Cường', '079090009999', '0983456789', 'cuong.lh@hotmail.com', '1990-11-30', N'Nam', N'Việt Nam', 'B1234567'),
('HK0004', N'Michael Smith', '000000000001', '010999888', 'msmith@gmail.com', '1985-05-05', N'Khac', N'Mỹ', 'G9876543'),
('HK0005', N'Phạm Minh Đức', '038099004321', '0977654321', 'duc.pm@gmail.com', '1999-01-01', N'Nam', N'Việt Nam', NULL),
('HK0006', N'Hoàng Thị Yến', '024094001122', '0934567890', 'yen.ht@gmail.com', '1994-02-15', N'Nu', N'Việt Nam', NULL),
('HK0007', N'Vũ Hải Đăng', '035092003344', '0945678901', 'dang.vh@gmail.com', '1992-07-20', N'Nam', N'Việt Nam', NULL),
('HK0008', N'Đỗ Kim Chi', '040097005566', '0956789012', 'chi.dk@gmail.com', '1997-10-05', N'Nu', N'Việt Nam', NULL),
('HK0009', N'Bùi Tiến Dũng', '045088007788', '0967890123', 'dung.bt@gmail.com', '1988-12-12', N'Nam', N'Việt Nam', NULL),
('HK0010', N'Ngô Phương Thảo', '052096009900', '0978901234', 'thao.np@gmail.com', '1996-05-18', N'Nu', N'Việt Nam', NULL),
('HK0011', N'John David', '000000000002', '020888777', 'johnd@yahoo.com', '1980-09-09', N'Nam', N'Anh', 'C7776665'),
('HK0012', N'Phan Thanh Tùng', '060091002233', '0989012345', 'tung.pt@gmail.com', '1991-03-25', N'Nam', N'Việt Nam', NULL),
('HK0013', N'Lý Mỹ Linh', '066099004455', '0990123456', 'linh.lm@gmail.com', '1999-11-11', N'Nu', N'Việt Nam', NULL),
('HK0014', N'Đặng Đình Toàn', '072085006677', '0902134567', 'toan.dd@gmail.com', '1985-06-30', N'Nam', N'Việt Nam', NULL),
('HK0015', N'Mai Tuyết Nhung', '075093008899', '0913245678', 'nhung.mt@gmail.com', '1993-08-14', N'Nu', N'Việt Nam', NULL),
('HK0016', N'Trịnh Xuân Trường', '079087001111', '0924356789', 'truong.tx@gmail.com', '1987-01-28', N'Nam', N'Việt Nam', NULL),
('HK0017', N'Võ Thị Hà', '082096002222', '0935467890', 'ha.vt@gmail.com', '1996-04-03', N'Nu', N'Việt Nam', NULL),
('HK0018', N'David Kim', '000000000003', '030777666', 'dkim@naver.com', '1992-12-25', N'Nam', N'Hàn Quốc', 'M5554443'),
('HK0019', N'Lâm Minh Chánh', '084080003333', '0946578901', 'chanh.lm@gmail.com', '1980-10-10', N'Nam', N'Việt Nam', NULL),
('HK0020', N'Dương Thúy Vi', '086098004444', '0957689012', 'vi.dt@gmail.com', '1998-03-21', N'Nu', N'Việt Nam', NULL),
('HK0021', N'Nguyễn Hoàng Long', '089094005555', '0968790123', 'long.nh@gmail.com', '1994-09-05', N'Nam', N'Việt Nam', NULL),
('HK0022', N'Trần Thu Trang', '091097006666', '0979801234', 'trang.tt@gmail.com', '1997-07-17', N'Nu', N'Việt Nam', NULL),
('HK0023', N'Sato Tanaka', '000000000004', '040666555', 'tanaka@gmail.com', '1989-08-08', N'Nam', N'Nhật Bản', 'E1112223'),
('HK0024', N'Phùng Ngọc Anh', '093095007777', '0980912345', 'anh.pn@gmail.com', '1995-11-02', N'Nu', N'Việt Nam', NULL),
('HK0025', N'Đoàn Văn Hậu', '095099008888', '0912934567', 'hau.dv@gmail.com', '1999-04-19', N'Nam', N'Việt Nam', NULL);
GO


-- 9. CHÈN VÉ MÁY BAY (VE)

INSERT INTO dbo.VE (MaVe, MaHK, SoGhe, MaGia, TrangThai, ThoiGianDat, ThoiGianTT) VALUES
('V24011', 'HK0001', 10, 'G2401', N'Da thanh toan', '2024-01-02', '2024-01-02'),
('V24012', 'HK0002', 11, 'G2401', N'Da thanh toan', '2024-01-03', '2024-01-03'),
('V24021', 'HK0003', 14, 'G2402', N'Da thanh toan', '2024-02-01', '2024-02-01'),
('V24022', 'HK0004', 15, 'G2402', N'Da thanh toan', '2024-02-05', '2024-02-05'),
('V24031', 'HK0005', 20, 'G2403', N'Da thanh toan', '2024-03-01', '2024-03-01'),
('V24032', 'HK0006', 21, 'G2403', N'Da thanh toan', '2024-03-02', '2024-03-02'),
('V24041', 'HK0007', 5,  'G2404', N'Da thanh toan', '2024-04-10', '2024-04-10'),
('V24051', 'HK0008', 8,  'G2405', N'Da thanh toan', '2024-05-01', '2024-05-01'),
('V24061', 'HK0009', 32, 'G2406', N'Da thanh toan', '2024-06-15', '2024-06-15'),
('V24071', 'HK0010', 1,  'G2407', N'Da thanh toan', '2024-07-10', '2024-07-10'),
('V24072', 'HK0011', 2,  'G2407', N'Da thanh toan', '2024-07-11', '2024-07-11'),
('V24081', 'HK0012', 18, 'G2408', N'Da thanh toan', '2024-08-01', '2024-08-01'),
('V24091', 'HK0013', 22, 'G2409', N'Da thanh toan', '2024-09-02', '2024-09-02'),
('V24101', 'HK0014', 40, 'G2410', N'Da thanh toan', '2024-10-05', '2024-10-05');


INSERT INTO dbo.VE (MaVe, MaHK, SoGhe, MaGia, TrangThai, ThoiGianDat, ThoiGianTT) VALUES
('V25011', 'HK0015', 12, 'G2501', N'Da thanh toan', '2025-01-01', '2025-01-01'),
('V25012', 'HK0016', 14, 'G2501', N'Da thanh toan', '2025-01-02', '2025-01-02'),
('V25013', 'HK0017', 15, 'G2501', N'Da thanh toan', '2025-01-02', '2025-01-02'),
('V25021', 'HK0018', 18, 'G2502', N'Da thanh toan', '2025-02-02', '2025-02-02'),
('V25022', 'HK0019', 19, 'G2502', N'Da thanh toan', '2025-02-03', '2025-02-03'),
('V25031', 'HK0020', 25, 'G2503', N'Da thanh toan', '2025-03-05', '2025-03-05'),
('V25032', 'HK0021', 26, 'G2503', N'Da thanh toan', '2025-03-06', '2025-03-06'),
('V25041', 'HK0022', 7,  'G2504', N'Da thanh toan', '2025-04-12', '2025-04-12'),
('V25042', 'HK0023', 8,  'G2504', N'Da thanh toan', '2025-04-13', '2025-04-13'),
('V25051', 'HK0024', 9,  'G2505', N'Da thanh toan', '2025-05-01', '2025-05-01'),
('V25061', 'HK0025', 45, 'G2506', N'Da thanh toan', '2025-06-10', '2025-06-10'),
('V25062', 'HK0001', 46, 'G2506', N'Da thanh toan', '2025-06-11', '2025-06-11'),
('V25071', 'HK0002', 3,  'G2507', N'Da thanh toan', '2025-07-05', '2025-07-05'),
('V25072', 'HK0003', 4,  'G2507', N'Da thanh toan', '2025-07-06', '2025-07-06'),
('V25081', 'HK0004', 21, 'G2508', N'Da thanh toan', '2025-08-02', '2025-08-02'),
('V25091', 'HK0005', 30, 'G2509', N'Da thanh toan', '2025-09-01', '2025-09-01'),
('V25101', 'HK0006', 50, 'G2510', N'Da thanh toan', '2025-10-02', '2025-10-02');


INSERT INTO dbo.VE (MaVe, MaHK, SoGhe, MaGia, TrangThai, ThoiGianDat, ThoiGianTT) VALUES
('V26011', 'HK0007', 40, 'G2601', N'Da thanh toan', '2026-01-02', '2026-01-02'),
('V26012', 'HK0008', 41, 'G2601', N'Da thanh toan', '2026-01-03', '2026-01-03'),
('V26013', 'HK0009', 42, 'G2601', N'Da thanh toan', '2026-01-04', '2026-01-04'),
('V26021', 'HK0010', 50, 'G2602', N'Da thanh toan', '2026-02-05', '2026-02-05'),
('V26022', 'HK0011', 51, 'G2602', N'Da thanh toan', '2026-02-06', '2026-02-06'),
('V26023', 'HK0012', 52, 'G2602', N'Da thanh toan', '2026-02-07', '2026-02-07'),
('V26031', 'HK0013', 60, 'G2603', N'Da thanh toan', '2026-03-01', '2026-03-01'),
('V26032', 'HK0014', 61, 'G2603', N'Da thanh toan', '2026-03-02', '2026-03-02'),
('V26041', 'HK0015', 12, 'G2604', N'Da thanh toan', '2026-04-10', '2026-04-10'),
('V26042', 'HK0016', 14, 'G2604', N'Da thanh toan', '2026-04-11', '2026-04-11'),
('V26051', 'HK0017', 19, 'G2605', N'Da thanh toan', '2026-05-01', '2026-05-01'),
('V26052', 'HK0018', 20, 'G2605', N'Da thanh toan', '2026-05-02', '2026-05-02'),
('V26061', 'HK0019', 70, 'G2606', N'Da thanh toan', '2026-06-12', '2026-06-12'),
('V26062', 'HK0020', 71, 'G2606', N'Da thanh toan', '2026-06-13', '2026-06-13'),
('V26071', 'HK0021', 5,  'G2607', N'Da thanh toan', '2026-07-01', '2026-07-01'),
('V26072', 'HK0022', 6,  'G2607', N'Da thanh toan', '2026-07-02', '2026-07-02'),
('V26073', 'HK0023', 7,  'G2607', N'Da thanh toan', '2026-07-03', '2026-07-03'),
('V26081', 'HK0024', 35, 'G2608', N'Da thanh toan', '2026-08-05', '2026-08-05'),
('V26082', 'HK0025', 36, 'G2608', N'Da thanh toan', '2026-08-06', '2026-08-06'),
('V26091', 'HK0001', 44, 'G2609', N'Da thanh toan', '2026-09-01', '2026-09-01'),
('V26092', 'HK0002', 45, 'G2609', N'Da thanh toan', '2026-09-02', '2026-09-02'),
('V26101', 'HK0003', 80, 'G2610', N'Da thanh toan', '2026-10-05', '2026-10-05'),
('V26102', 'HK0004', 81, 'G2610', N'Da thanh toan', '2026-10-06', '2026-10-06');
GO


-- 10. CHÈN HÀNH LÝ (HANHLY)

INSERT INTO dbo.HANHLY (MaHanhLy, MaVe, TrongLuong, LoaiHanhLy) VALUES
('HL0001', 'V24011', 7.00, N'Xach tay'),
('HL0002', 'V24011', 20.00, N'Ky gui'),
('HL0003', 'V25011', 30.50, N'Ky gui'),
('HL0004', 'V26011', 15.00, N'Ky gui');
GO


-- 11. CHÈN NHÂN VIÊN (NHANVIEN)

INSERT INTO dbo.NHANVIEN (MaNV, TenNV, ChucVu, BoPhan, CCCD, SDT_NV, Email_NV, NgaySinh, GioiTinh) VALUES
('NV0001', N'Phạm Thành Long', N'Phi cong', N'Đội bay Boeing 787', '001080001111', '0909111222', 'long.pt@airline.com', '1980-03-15', N'Nam'),
('NV0002', N'Nguyễn Minh Quân', N'Phi cong', N'Đội bay Airbus A321', '001085002222', '0909333444', 'quan.nm@airline.com', '1985-07-20', N'Nam'),
('NV0003', N'Trần Hoàng Bách', N'Phi cong', N'Đội bay Airbus A350', '001090003333', '0909555666', 'bach.th@airline.com', '1988-11-05', N'Nam'),
('NV0004', N'Vũ Lê Hoàng', N'Phi cong', N'Đội bay Boeing 787', '001092004444', '0909777888', 'hoang.vl@airline.com', '1992-02-14', N'Nam'),
('NV0005', N'Lê Tuấn Anh', N'Phi cong', N'Đội bay Airbus A321', '001093005555', '0909999000', 'anh.lt@airline.com', '1993-09-25', N'Nam'),
('NV0006', N'Đặng Thị Mai', N'Tiep vien', N'Đoàn tiếp viên 1', '002090003333', '0912111222', 'mai.dt@airline.com', '1992-05-12', N'Nu'),
('NV0007', N'Lê Thu Thảo', N'Tiep vien', N'Đoàn tiếp viên 2', '003095004444', '0912333444', 'thao.lt@airline.com', '1995-10-25', N'Nu'),
('NV0008', N'Nguyễn Hoàng Yến', N'Tiep vien', N'Đoàn tiếp viên 1', '003096005555', '0912555666', 'yen.nh@airline.com', '1996-08-18', N'Nu'),
('NV0009', N'Phạm Thu Hà', N'Tiep vien', N'Đoàn tiếp viên 2', '003097006666', '0912777888', 'ha.pt@airline.com', '1997-12-01', N'Nu'),
('NV0010', N'Trần Phương Linh', N'Tiep vien', N'Đoàn tiếp viên 1', '003098007777', '0912999000', 'linh.tp@airline.com', '1998-04-30', N'Nu'),
('NV0011', N'Đỗ Kiều Anh', N'Tiep vien', N'Đoàn tiếp viên 2', '003099008888', '0913111222', 'anh.dk@airline.com', '1999-07-15', N'Nu'),
('NV0012', N'Bùi Công Vinh', N'Tiep vien', N'Đoàn tiếp viên 1', '002094009999', '0913333444', 'vinh.bc@airline.com', '1994-03-20', N'Nam'),
('NV0013', N'Trần Văn Hùng', N'Dieu hanh', N'Phòng điều độ bay', '004075005555', '0938111222', 'hung.tv@airline.com', '1978-12-01', N'Nam'),
('NV0014', N'Hoàng Lệ Quyên', N'Dieu hanh', N'Phòng thủ tục kiểm soát', '004082006666', '0938333444', 'quyen.hl@airline.com', '1982-06-14', N'Nu'),
('NV0015', N'Nguyễn Toàn Thắng', N'Dieu hanh', N'Phòng điều độ bay', '004087007777', '0938555666', 'thang.nt@airline.com', '1987-10-10', N'Nam');
GO


-- 12. CHÈN BẢNG PHÂN CÔNG (BANGPHANCONG)
INSERT INTO dbo.BANGPHANCONG (MaLich, MaNV, VaiTro) VALUES
('LB2401', 'NV0001', N'Phi cong chinh'),
('LB2401', 'NV0002', N'Phi cong phu'),
('LB2401', 'NV0006', N'Tiep vien truong'),
('LB2401', 'NV0007', N'Tiep vien'),
('LB2402', 'NV0002', N'Phi cong chinh'),
('LB2402', 'NV0005', N'Phi cong phu'),
('LB2402', 'NV0008', N'Tiep vien truong'),
('LB2402', 'NV0009', N'Tiep vien'),
('LB2403', 'NV0004', N'Phi cong chinh'),
('LB2403', 'NV0001', N'Phi cong phu'),
('LB2403', 'NV0006', N'Tiep vien truong'),
('LB2403', 'NV0010', N'Tiep vien'),
('LB2404', 'NV0003', N'Phi cong chinh'),
('LB2404', 'NV0004', N'Phi cong phu'),
('LB2404', 'NV0007', N'Tiep vien truong'),
('LB2404', 'NV0011', N'Tiep vien'),
('LB2405', 'NV0005', N'Phi cong chinh'),
('LB2405', 'NV0002', N'Phi cong phu'),
('LB2405', 'NV0008', N'Tiep vien truong'),
('LB2405', 'NV0012', N'Tiep vien');

INSERT INTO dbo.BANGPHANCONG (MaLich, MaNV, VaiTro) VALUES
('LB2501', 'NV0001', N'Phi cong chinh'),
('LB2501', 'NV0005', N'Phi cong phu'),
('LB2501', 'NV0006', N'Tiep vien truong'),
('LB2501', 'NV0011', N'Tiep vien'),
('LB2502', 'NV0002', N'Phi cong chinh'),
('LB2502', 'NV0001', N'Phi cong phu'),
('LB2502', 'NV0007', N'Tiep vien truong'),
('LB2502', 'NV0010', N'Tiep vien'),
('LB2503', 'NV0004', N'Phi cong chinh'),
('LB2503', 'NV0003', N'Phi cong phu'),
('LB2503', 'NV0008', N'Tiep vien truong'),
('LB2503', 'NV0009', N'Tiep vien'),
('LB2504', 'NV0003', N'Phi cong chinh'),
('LB2504', 'NV0002', N'Phi cong phu'),
('LB2504', 'NV0006', N'Tiep vien truong'),
('LB2504', 'NV0012', N'Tiep vien'),
('LB2505', 'NV0005', N'Phi cong chinh'),
('LB2505', 'NV0004', N'Phi cong phu'),
('LB2505', 'NV0007', N'Tiep vien truong'),
('LB2505', 'NV0008', N'Tiep vien');


INSERT INTO dbo.BANGPHANCONG (MaLich, MaNV, VaiTro) VALUES
('LB2601', 'NV0001', N'Phi cong chinh'),
('LB2601', 'NV0004', N'Phi cong phu'),
('LB2601', 'NV0006', N'Tiep vien truong'),
('LB2601', 'NV0009', N'Tiep vien'),
('LB2602', 'NV0002', N'Phi cong chinh'),
('LB2602', 'NV0005', N'Phi cong phu'),
('LB2602', 'NV0007', N'Tiep vien truong'),
('LB2602', 'NV0012', N'Tiep vien'),
('LB2603', 'NV0004', N'Phi cong chinh'),
('LB2603', 'NV0001', N'Phi cong phu'),
('LB2603', 'NV0008', N'Tiep vien truong'),
('LB2603', 'NV0011', N'Tiep vien'),
('LB2604', 'NV0003', N'Phi cong chinh'),
('LB2604', 'NV0005', N'Phi cong phu'),
('LB2604', 'NV0006', N'Tiep vien truong'),
('LB2604', 'NV0010', N'Tiep vien'),
('LB2605', 'NV0005', N'Phi cong chinh'),
('LB2605', 'NV0003', N'Phi cong phu'),
('LB2605', 'NV0007', N'Tiep vien truong'),
('LB2605', 'NV0009', N'Tiep vien');
GO

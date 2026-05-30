-- ============================================================
-- BULK INSERT - QuanLiChuyenBay
-- Chay file nay sau khi da tao schema (QuanLyChuyenBay.sql)
-- Thay the D:\Hoc_Tap\HK4\IE103_QuanLyThongTin\code\đồ án\csv_data\ bang duong dan tuyet doi chua cac file CSV
-- Vi du Windows: C:\Data\csv_data\
-- Vi du Linux:   /home/user/csv_data/
-- ============================================================

USE QuanLiChuyenBay;
GO

-- ============================================================
-- 1. SANBAY (30 rows) - khong co FK, insert truoc
-- ============================================================
BULK INSERT dbo.SANBAY
FROM 'D:\Hoc_Tap\HK4\IE103_QuanLyThongTin\code\đồ án\csv_data\SANBAY.csv'
WITH (
    FIRSTROW       = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0a',
    CODEPAGE       = '65001'
);
GO
PRINT 'SANBAY: OK - ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows';
GO

-- ============================================================
-- 2. HANGHANGKHONG (15 rows) - khong co FK
-- ============================================================
BULK INSERT dbo.HANGHANGKHONG
FROM 'D:\Hoc_Tap\HK4\IE103_QuanLyThongTin\code\đồ án\csv_data\HANGHANGKHONG.csv'
WITH (
    FIRSTROW       = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0a',
    CODEPAGE       = '65001'
);
GO
PRINT 'HANGHANGKHONG: OK - ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows';
GO

-- ============================================================
-- 3. LOAIMAYBAY (10 rows) - khong co FK
-- ============================================================
BULK INSERT dbo.LOAIMAYBAY
FROM 'D:\Hoc_Tap\HK4\IE103_QuanLyThongTin\code\đồ án\csv_data\LOAIMAYBAY.csv'
WITH (
    FIRSTROW       = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0a',
    CODEPAGE       = '65001'
);
GO
PRINT 'LOAIMAYBAY: OK - ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows';
GO

-- ============================================================
-- 4. MAYBAY (100 rows) - FK -> LOAIMAYBAY, HANGHANGKHONG
-- ============================================================
BULK INSERT dbo.MAYBAY
FROM 'D:\Hoc_Tap\HK4\IE103_QuanLyThongTin\code\đồ án\csv_data\MAYBAY.csv'
WITH (
    FIRSTROW       = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0a',
    CODEPAGE       = '65001'
);
GO
PRINT 'MAYBAY: OK - ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows';
GO

-- ============================================================
-- 5. CHUYENBAY (500 rows) - FK -> SANBAY (x2)
-- ============================================================
BULK INSERT dbo.CHUYENBAY
FROM 'D:\Hoc_Tap\HK4\IE103_QuanLyThongTin\code\đồ án\csv_data\CHUYENBAY.csv'
WITH (
    FIRSTROW       = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0d0a',
    CODEPAGE       = '65001'
);
GO
PRINT 'CHUYENBAY: OK - ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows';
GO

-- ============================================================
-- 6. NHANVIEN (2000 rows) - khong co FK
-- ============================================================
BULK INSERT dbo.NHANVIEN
FROM 'D:\Hoc_Tap\HK4\IE103_QuanLyThongTin\code\đồ án\csv_data\NHANVIEN.csv'
WITH (
    FIRSTROW       = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0a',
    CODEPAGE       = '65001'
);
GO
PRINT 'NHANVIEN: OK - ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows';
GO

-- ============================================================
-- 7. HANHKHACH (50000 rows) - khong co FK
-- SoHoChieu co the NULL => dung format file xu ly cot empty
-- ============================================================
BULK INSERT dbo.HANHKHACH
FROM 'D:\Hoc_Tap\HK4\IE103_QuanLyThongTin\code\đồ án\csv_data\HANHKHACH.csv'
WITH (
    FIRSTROW        = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR   = '0x0a',
    CODEPAGE        = '65001',
    KEEPNULLS                   -- Giu gia tri NULL khi cot trong rong
);
GO
PRINT 'HANHKHACH: OK - ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows';
GO

-- ============================================================
-- 8. LICHBAY (2000 rows) - FK -> CHUYENBAY, MAYBAY
-- ============================================================
BULK INSERT dbo.LICHBAY
FROM 'D:\Hoc_Tap\HK4\IE103_QuanLyThongTin\code\đồ án\csv_data\LICHBAY.csv'
WITH (
    FIRSTROW       = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0a',
    CODEPAGE       = '65001'
);
GO
PRINT 'LICHBAY: OK - ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows';
GO

-- ============================================================
-- 9. BANGPHANCONG (9983 rows) - FK -> LICHBAY, NHANVIEN
--    Insert truoc BANGGIAVE vi khong phu thuoc nhau
-- ============================================================
BULK INSERT dbo.BANGPHANCONG
FROM 'D:\Hoc_Tap\HK4\IE103_QuanLyThongTin\code\đồ án\csv_data\BANGPHANCONG.csv'
WITH (
    FIRSTROW       = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0a',
    CODEPAGE       = '65001'
);
GO
PRINT 'BANGPHANCONG: OK - ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows';
GO

-- ============================================================
-- 10. BANGGIAVE (6000 rows) - FK -> LICHBAY
--     Trigger TR_BANGGIAVE_CheckThoiGianSoVoiLichBay se chay o day
--     Tat ca du lieu da duoc kiem tra truoc: BatDau < KetThuc < ThoiGianDi
-- ============================================================
BULK INSERT dbo.BANGGIAVE
FROM 'D:\Hoc_Tap\HK4\IE103_QuanLyThongTin\code\đồ án\csv_data\BANGGIAVE.csv'
WITH (
    FIRSTROW       = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0a',
    CODEPAGE       = '65001'
);
GO
PRINT 'BANGGIAVE: OK - ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows';
GO

-- ============================================================
-- 11. VE (80000 rows) - FK -> HANHKHACH, BANGGIAVE
--     2 trigger se chay: TR_VE_CheckTrangThai, TR_VE_CheckSucChua
--     Du lieu da dam bao: ThoiGianTT NULL khi chua thanh toan,
--     Tong ve active <= SucChua may bay
--
--     NOTE: BULK INSERT khong kich hoat trigger theo mac dinh.
--     Phai BAN trigger truoc, insert, roi BAT lai.
--     Hoac dung FIRE_TRIGGERS de bat trigger khi bulk insert.
-- ============================================================

-- Cach 1 (khuyen dung): dung FIRE_TRIGGERS de kich hoat trigger
-- Neus muon tat trigger trong luc insert thi dung cach 2 duoi day

BULK INSERT dbo.VE
FROM 'D:\Hoc_Tap\HK4\IE103_QuanLyThongTin\code\đồ án\csv_data\VE.csv'
WITH (
    FIRSTROW        = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR   = '0x0a',
    CODEPAGE        = '65001',
    KEEPNULLS,                  -- Giu NULL cho ThoiGianTT
    FIRE_TRIGGERS               -- Bat trigger khi bulk insert
);
GO
PRINT 'VE: OK - ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows';
GO

/*
-- Cach 2: Tat trigger, insert, bat lai (dung khi can toc do nhanh hon)
DISABLE TRIGGER dbo.TR_VE_CheckTrangThai  ON dbo.VE;
DISABLE TRIGGER dbo.TR_VE_CheckSucChua    ON dbo.VE;

BULK INSERT dbo.VE
FROM 'D:\Hoc_Tap\HK4\IE103_QuanLyThongTin\code\đồ án\csv_data\VE.csv'
WITH (
    FIRSTROW        = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR   = '0x0a',
    CODEPAGE        = '65001',
    KEEPNULLS
);

ENABLE TRIGGER dbo.TR_VE_CheckTrangThai  ON dbo.VE;
ENABLE TRIGGER dbo.TR_VE_CheckSucChua    ON dbo.VE;
*/

-- ============================================================
-- 12. HANHLY (4782 rows) - FK -> VE
-- ============================================================
BULK INSERT dbo.HANHLY
FROM 'D:\Hoc_Tap\HK4\IE103_QuanLyThongTin\code\đồ án\csv_data\HANHLY.csv'
WITH (
    FIRSTROW       = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR  = '0x0a',
    CODEPAGE       = '65001'
);
GO
PRINT 'HANHLY: OK - ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows';
GO

-- ============================================================
-- KIEM TRA NHANH SAU KHI INSERT
-- ============================================================
SELECT 'SANBAY'       AS Bang, COUNT(*) AS SoDong FROM dbo.SANBAY        UNION ALL
SELECT 'HANGHANGKHONG',         COUNT(*)           FROM dbo.HANGHANGKHONG UNION ALL
SELECT 'LOAIMAYBAY',            COUNT(*)           FROM dbo.LOAIMAYBAY    UNION ALL
SELECT 'MAYBAY',                COUNT(*)           FROM dbo.MAYBAY        UNION ALL
SELECT 'CHUYENBAY',             COUNT(*)           FROM dbo.CHUYENBAY     UNION ALL
SELECT 'LICHBAY',               COUNT(*)           FROM dbo.LICHBAY       UNION ALL
SELECT 'BANGGIAVE',             COUNT(*)           FROM dbo.BANGGIAVE     UNION ALL
SELECT 'HANHKHACH',             COUNT(*)           FROM dbo.HANHKHACH     UNION ALL
SELECT 'VE',                    COUNT(*)           FROM dbo.VE            UNION ALL
SELECT 'HANHLY',                COUNT(*)           FROM dbo.HANHLY        UNION ALL
SELECT 'NHANVIEN',              COUNT(*)           FROM dbo.NHANVIEN      UNION ALL
SELECT 'BANGPHANCONG',          COUNT(*)           FROM dbo.BANGPHANCONG;
GO
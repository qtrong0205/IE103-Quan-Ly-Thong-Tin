
-------------------- STORED PROCEDURE:
---- 1 Thêm chuyến bay
CREATE OR ALTER PROCEDURE dbo.sp_ThemChuyenBay
(
    @MaCB CHAR(10),
    @MaSB_Di CHAR(5),
    @MaSB_Den CHAR(5)
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra mã chuyến bay đã tồn tại
    IF EXISTS
    (
        SELECT 1
        FROM dbo.CHUYENBAY
        WHERE MaCB = @MaCB
    )
    BEGIN
        THROW 51000, N'Ma chuyen bay da ton tai.', 1;
    END;

    -- Kiểm tra sân bay đi tồn tại
    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.SANBAY
        WHERE MaSB = @MaSB_Di
    )
    BEGIN
        THROW 51001, N'San bay di khong ton tai.', 1;
    END;

    -- Kiểm tra sân bay đến tồn tại
    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.SANBAY
        WHERE MaSB = @MaSB_Den
    )
    BEGIN
        THROW 51002, N'San bay den khong ton tai.', 1;
    END;

    -- Kiểm tra sân bay đi và đến khác nhau
    IF @MaSB_Di = @MaSB_Den
    BEGIN
        THROW 51003, N'San bay di va san bay den phai khac nhau.', 1;
    END;

    -- Thêm chuyến bay
    INSERT INTO dbo.CHUYENBAY
    (
        MaCB,
        MaSB_Di,
        MaSB_Den
    )
    VALUES
    (
        @MaCB,
        @MaSB_Di,
        @MaSB_Den
    );

    PRINT N'Them chuyen bay thanh cong.';
END
GO




---- 2 Tạo lịch bay
CREATE OR ALTER PROCEDURE dbo.sp_TaoLichBay
(
    @MaLich CHAR(10),
    @MaCB CHAR(10),
    @SoHieuMB CHAR(10),
    @ThoiGianDi DATETIME,
    @ThoiGianDen DATETIME,
    @TrangThai NVARCHAR(20)
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra mã lịch bay đã tồn tại
    IF EXISTS
    (
        SELECT 1
        FROM dbo.LICHBAY
        WHERE MaLich = @MaLich
    )
    BEGIN
        THROW 52000, N'Ma lich bay da ton tai.', 1;
    END;

    -- Kiểm tra chuyến bay tồn tại
    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.CHUYENBAY
        WHERE MaCB = @MaCB
    )
    BEGIN
        THROW 52001, N'Ma chuyen bay khong ton tai.', 1;
    END;

    -- Kiểm tra máy bay tồn tại
    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.MAYBAY
        WHERE SoHieu = @SoHieuMB
    )
    BEGIN
        THROW 52002, N'May bay khong ton tai.', 1;
    END;

    -- Kiểm tra trạng thái máy bay
    IF EXISTS
    (
        SELECT 1
        FROM dbo.MAYBAY
        WHERE SoHieu = @SoHieuMB
          AND TrangThai <> N'Hoat dong'
    )
    BEGIN
        THROW 52003, N'May bay khong san sang hoat dong.', 1;
    END;

    -- Kiểm tra thời gian hợp lệ
    IF @ThoiGianDen <= @ThoiGianDi
    BEGIN
        THROW 52004, N'Thoi gian den phai lon hon thoi gian di.', 1;
    END;

    -- Kiểm tra trùng lịch máy bay
    IF EXISTS
    (
        SELECT 1
        FROM dbo.LICHBAY
        WHERE SoHieuMB = @SoHieuMB
          AND
          (
                @ThoiGianDi < ThoiGianDen
            AND @ThoiGianDen > ThoiGianDi
          )
    )
    BEGIN
        THROW 52005, N'May bay da co lich bay trong khoang thoi gian nay.', 1;
    END;

    -- Thêm lịch bay
    INSERT INTO dbo.LICHBAY
    (
        MaLich,
        MaCB,
        SoHieuMB,
        ThoiGianDi,
        ThoiGianDen,
        TrangThai
    )
    VALUES
    (
        @MaLich,
        @MaCB,
        @SoHieuMB,
        @ThoiGianDi,
        @ThoiGianDen,
        @TrangThai
    );

    PRINT N'Tao lich bay thanh cong.';
END
GO




----  3 Đặt vé:
CREATE OR ALTER PROCEDURE dbo.sp_DatVe
(
    @MaHK CHAR(10),
    @MaGia CHAR(10),
    @SoGhe INT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MaVe CHAR(10);

    -- Kiểm tra hành khách tồn tại
    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.HANHKHACH
        WHERE MaHK = @MaHK
    )
    BEGIN
        THROW 53000, N'Hanh khach khong ton tai.', 1;
    END;

    -- Kiểm tra mã giá tồn tại
    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.BANGGIAVE
        WHERE MaGia = @MaGia
    )
    BEGIN
        THROW 53001, N'Ma gia ve khong ton tai.', 1;
    END;

    -- Kiểm tra giá vé còn hiệu lực
    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.BANGGIAVE
        WHERE MaGia = @MaGia
          AND GETDATE() BETWEEN ThoiDiemBatDau AND ThoiDiemKetThuc
    )
    BEGIN
        THROW 53002, N'Gia ve khong con hieu luc.', 1;
    END;

    -- Kiểm tra ghế đã được đặt chưa
    IF EXISTS
    (
        SELECT 1
        FROM dbo.VE
        WHERE MaGia = @MaGia
          AND SoGhe = @SoGhe
          AND TrangThai IN (N'Da dat', N'Da thanh toan')
    )
    BEGIN
        THROW 53003, N'Ghe nay da duoc dat.', 1;
    END;

    -- Sinh mã vé tự động
    DECLARE @SoThuTu INT;

    SELECT @SoThuTu = COUNT(*) + 1
    FROM dbo.VE;

    SET @MaVe =
        'VE' +
        RIGHT('000000' + CAST(@SoThuTu AS VARCHAR(6)), 6);

    -- Thêm vé
    INSERT INTO dbo.VE
    (
        MaVe,
        MaHK,
        SoGhe,
        MaGia,
        TrangThai,
        ThoiGianDat,
        ThoiGianTT
    )
    VALUES
    (
        @MaVe,
        @MaHK,
        @SoGhe,
        @MaGia,
        N'Da dat',
        GETDATE(),
        NULL
    );

    PRINT N'Dat ve thanh cong.';
    PRINT N'Ma ve: ' + @MaVe;
END
GO




---- 4 Thanh toán vé:
CREATE OR ALTER PROCEDURE dbo.sp_ThanhToanVe
(
    @MaVe CHAR(10)
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra vé tồn tại
    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.VE
        WHERE MaVe = @MaVe
    )
    BEGIN
        THROW 54000, N'Ve khong ton tai.', 1;
    END;

    -- Kiểm tra vé đã hủy chưa
    IF EXISTS
    (
        SELECT 1
        FROM dbo.VE
        WHERE MaVe = @MaVe
          AND TrangThai = N'Da huy'
    )
    BEGIN
        THROW 54001, N'Khong the thanh toan ve da huy.', 1;
    END;

    -- Kiểm tra vé đã thanh toán chưa
    IF EXISTS
    (
        SELECT 1
        FROM dbo.VE
        WHERE MaVe = @MaVe
          AND TrangThai = N'Da thanh toan'
    )
    BEGIN
        THROW 54002, N'Ve da duoc thanh toan truoc do.', 1;
    END;

    -- Thanh toán vé
    UPDATE dbo.VE
    SET
        TrangThai = N'Da thanh toan',
        ThoiGianTT = GETDATE()
    WHERE MaVe = @MaVe;

    PRINT N'Thanh toan ve thanh cong.';
END
GO





---- 5 Hủy vé:
CREATE OR ALTER PROCEDURE dbo.sp_HuyVe
(
    @MaVe CHAR(10)
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra vé tồn tại
    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.VE
        WHERE MaVe = @MaVe
    )
    BEGIN
        THROW 55000, N'Ve khong ton tai.', 1;
    END;

    -- Kiểm tra vé đã hủy chưa
    IF EXISTS
    (
        SELECT 1
        FROM dbo.VE
        WHERE MaVe = @MaVe
          AND TrangThai = N'Da huy'
    )
    BEGIN
        THROW 55001, N'Ve da duoc huy truoc do.', 1;
    END;

    -- Hủy vé
    UPDATE dbo.VE
    SET
        TrangThai = N'Da huy',
        ThoiGianTT = NULL
    WHERE MaVe = @MaVe;

    PRINT N'Huy ve thanh cong.';
END
GO





---- 6 Phân công nhân viên
CREATE OR ALTER PROCEDURE dbo.sp_PhanCongNhanVien
(
    @MaLich CHAR(10),
    @MaNV CHAR(10),
    @VaiTro NVARCHAR(20)
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ChucVu NVARCHAR(20);

    -- Kiểm tra lịch bay tồn tại
    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.LICHBAY
        WHERE MaLich = @MaLich
    )
    BEGIN
        THROW 56000, N'Lich bay khong ton tai.', 1;
    END;

    -- Kiểm tra nhân viên tồn tại
    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.NHANVIEN
        WHERE MaNV = @MaNV
    )
    BEGIN
        THROW 56001, N'Nhan vien khong ton tai.', 1;
    END;

    -- Lấy chức vụ nhân viên
    SELECT @ChucVu = ChucVu
    FROM dbo.NHANVIEN
    WHERE MaNV = @MaNV;

    -- Kiểm tra vai trò phù hợp chức vụ
    IF @VaiTro IN (N'Phi cong chinh', N'Phi cong phu')
       AND @ChucVu <> N'Phi cong'
    BEGIN
        THROW 56002, N'Chi nhan vien co chuc vu Phi cong moi duoc phan cong vai tro nay.', 1;
    END;

    IF @VaiTro IN (N'Tiep vien truong', N'Tiep vien')
       AND @ChucVu <> N'Tiep vien'
    BEGIN
        THROW 56003, N'Chi nhan vien co chuc vu Tiep vien moi duoc phan cong vai tro nay.', 1;
    END;

    -- Kiểm tra phân công trùng
    IF EXISTS
    (
        SELECT 1
        FROM dbo.BANGPHANCONG
        WHERE MaLich = @MaLich
          AND MaNV = @MaNV
    )
    BEGIN
        THROW 56004, N'Nhan vien da duoc phan cong cho lich bay nay.', 1;
    END;

    -- Thêm phân công
    INSERT INTO dbo.BANGPHANCONG
    (
        MaLich,
        MaNV,
        VaiTro
    )
    VALUES
    (
        @MaLich,
        @MaNV,
        @VaiTro
    );

    PRINT N'Phan cong nhan vien thanh cong.';
END
GO




---- 7 Thêm bảng giá:
CREATE OR ALTER PROCEDURE dbo.sp_ThemBangGia
(
    @MaGia CHAR(10),
    @MaLich CHAR(10),
    @HangGhe NVARCHAR(20),
    @Gia DECIMAL(12,2),
    @ThoiDiemBatDau DATETIME,
    @ThoiDiemKetThuc DATETIME
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ThoiGianDi DATETIME;

    -- Kiểm tra mã giá đã tồn tại
    IF EXISTS
    (
        SELECT 1
        FROM dbo.BANGGIAVE
        WHERE MaGia = @MaGia
    )
    BEGIN
        THROW 57000, N'Ma gia ve da ton tai.', 1;
    END;

    -- Kiểm tra lịch bay tồn tại
    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.LICHBAY
        WHERE MaLich = @MaLich
    )
    BEGIN
        THROW 57001, N'Lich bay khong ton tai.', 1;
    END;

    -- Kiểm tra giá hợp lệ
    IF @Gia <= 0
    BEGIN
        THROW 57002, N'Gia ve phai lon hon 0.', 1;
    END;

    -- Kiểm tra thời gian hợp lệ
    IF @ThoiDiemKetThuc <= @ThoiDiemBatDau
    BEGIN
        THROW 57003, N'Thoi diem ket thuc phai lon hon thoi diem bat dau.', 1;
    END;

    -- Lấy thời gian bay
    SELECT @ThoiGianDi = ThoiGianDi
    FROM dbo.LICHBAY
    WHERE MaLich = @MaLich;

    -- Kiểm tra thời gian giá vé trước giờ bay
    IF @ThoiDiemBatDau >= @ThoiGianDi
       OR @ThoiDiemKetThuc >= @ThoiGianDi
    BEGIN
        THROW 57004, N'Thoi gian ap dung gia ve phai truoc gio bay.', 1;
    END;

    -- Kiểm tra trùng thời gian cùng hạng ghế
    IF EXISTS
    (
        SELECT 1
        FROM dbo.BANGGIAVE
        WHERE MaLich = @MaLich
          AND HangGhe = @HangGhe
          AND
          (
                @ThoiDiemBatDau < ThoiDiemKetThuc
            AND @ThoiDiemKetThuc > ThoiDiemBatDau
          )
    )
    BEGIN
        THROW 57005, N'Trung khoang thoi gian ap dung gia ve.', 1;
    END;

    -- Thêm bảng giá
    INSERT INTO dbo.BANGGIAVE
    (
        MaGia,
        MaLich,
        HangGhe,
        Gia,
        ThoiDiemBatDau,
        ThoiDiemKetThuc
    )
    VALUES
    (
        @MaGia,
        @MaLich,
        @HangGhe,
        @Gia,
        @ThoiDiemBatDau,
        @ThoiDiemKetThuc
    );

    PRINT N'Them bang gia ve thanh cong.';
END
GO





---- 8 Cập nhật trạng thái lịch bay
CREATE OR ALTER PROCEDURE dbo.sp_CapNhatTrangThaiLichBay
(
    @MaLich CHAR(10),
    @TrangThaiMoi NVARCHAR(20)
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TrangThaiCu NVARCHAR(20);

    -- Kiểm tra lịch bay tồn tại
    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.LICHBAY
        WHERE MaLich = @MaLich
    )
    BEGIN
        THROW 58000, N'Lich bay khong ton tai.', 1;
    END;

    -- Kiểm tra trạng thái hợp lệ
    IF @TrangThaiMoi NOT IN (N'Dung gio', N'Tre', N'Huy')
    BEGIN
        THROW 58001, N'Trang thai khong hop le.', 1;
    END;

    -- Lấy trạng thái hiện tại
    SELECT @TrangThaiCu = TrangThai
    FROM dbo.LICHBAY
    WHERE MaLich = @MaLich;

    -- Không cho cập nhật nếu đã hủy
    IF @TrangThaiCu = N'Huy'
    BEGIN
        THROW 58002, N'Khong the cap nhat lich bay da huy.', 1;
    END;

    -- Cập nhật trạng thái
    UPDATE dbo.LICHBAY
    SET TrangThai = @TrangThaiMoi
    WHERE MaLich = @MaLich;

    PRINT N'Cap nhat trang thai lich bay thanh cong.';
END
GO





---- 9 Thêm hành lí:
CREATE OR ALTER PROCEDURE dbo.sp_ThemHanhLy
(
    @MaHanhLy CHAR(10),
    @MaVe CHAR(10),
    @TrongLuong DECIMAL(5,2),
    @LoaiHanhLy NVARCHAR(20)
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra mã hành lý đã tồn tại
    IF EXISTS
    (
        SELECT 1
        FROM dbo.HANHLY
        WHERE MaHanhLy = @MaHanhLy
    )
    BEGIN
        THROW 59000, N'Ma hanh ly da ton tai.', 1;
    END;

    -- Kiểm tra vé tồn tại
    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.VE
        WHERE MaVe = @MaVe
    )
    BEGIN
        THROW 59001, N'Ve khong ton tai.', 1;
    END;

    -- Kiểm tra vé đã hủy chưa
    IF EXISTS
    (
        SELECT 1
        FROM dbo.VE
        WHERE MaVe = @MaVe
          AND TrangThai = N'Da huy'
    )
    BEGIN
        THROW 59002, N'Khong the them hanh ly cho ve da huy.', 1;
    END;

    -- Kiểm tra trọng lượng hợp lệ
    IF @TrongLuong <= 0
    BEGIN
        THROW 59003, N'Trong luong hanh ly phai lon hon 0.', 1;
    END;

    -- Kiểm tra loại hành lý
    IF @LoaiHanhLy NOT IN (N'Xach tay', N'Ky gui')
    BEGIN
        THROW 59004, N'Loai hanh ly khong hop le.', 1;
    END;

    -- Thêm hành lý
    INSERT INTO dbo.HANHLY
    (
        MaHanhLy,
        MaVe,
        TrongLuong,
        LoaiHanhLy
    )
    VALUES
    (
        @MaHanhLy,
        @MaVe,
        @TrongLuong,
        @LoaiHanhLy
    );

    PRINT N'Them hanh ly thanh cong.';
END
GO

------------ REPORT
---- Report 1: Thiết kế Report trả về Tốc độ tăng trưởng doanh số hàng năm của hãng bay.
WITH DoanhThuTheoNam AS
(
    SELECT 
        YEAR(v.ThoiGianTT) AS Nam,
        SUM(bgv.Gia) AS TongDoanhThu
    FROM dbo.VE v
    INNER JOIN dbo.BANGGIAVE bgv ON v.MaGia = bgv.MaGia
    WHERE v.TrangThai = N'Da thanh toan'
      AND v.ThoiGianTT IS NOT NULL
    GROUP BY YEAR(v.ThoiGianTT)
),
DoanhThuTinhToan AS
(
    SELECT 
        Nam,
        TongDoanhThu,
        LAG(TongDoanhThu) OVER (ORDER BY Nam) AS DoanhThuNamTruoc
    FROM DoanhThuTheoNam
)
SELECT 
    Nam,
    TongDoanhThu,
    DoanhThuNamTruoc,
    (TongDoanhThu - DoanhThuNamTruoc) AS ChenhLechDoanhThu,
    CASE 
        WHEN DoanhThuNamTruoc IS NULL THEN NULL
        WHEN DoanhThuNamTruoc = 0 THEN NULL
        ELSE ROUND((TongDoanhThu - DoanhThuNamTruoc) * 100.0 / DoanhThuNamTruoc, 2)
    END AS TocDoTangTruong_PhanTram
FROM DoanhThuTinhToan
ORDER BY Nam;





----Report 2: Thiết kế Report trả về Top 10 chuyến bay có doanh số bán hàng cao nhất của hãng 
SELECT TOP 10
    cb.MaCB,
    sb_di.TenSB AS SanBayDi,
    sb_den.TenSB AS SanBayDen,
    COUNT(v.MaVe) AS TongSoVe,
    SUM(bgv.Gia) AS TongDoanhThu,
    RANK() OVER (ORDER BY SUM(bgv.Gia) DESC) AS XepHang
FROM dbo.VE v
INNER JOIN dbo.BANGGIAVE bgv ON v.MaGia = bgv.MaGia
INNER JOIN dbo.LICHBAY lb ON bgv.MaLich = lb.MaLich
INNER JOIN dbo.CHUYENBAY cb ON lb.MaCB = cb.MaCB
INNER JOIN dbo.SANBAY sb_di ON cb.MaSB_Di = sb_di.MaSB
INNER JOIN dbo.SANBAY sb_den ON cb.MaSB_Den = sb_den.MaSB
WHERE v.TrangThai = N'Da thanh toan'
GROUP BY 
    cb.MaCB,
    sb_di.TenSB,
    sb_den.TenSB
ORDER BY TongDoanhThu DESC;





---- Report 3:Thiết kế Report trả về số lượng vé được bán theo từng tháng của hãng bay.
WITH VeTheoThang AS
(
    SELECT 
        YEAR(v.ThoiGianTT) AS Nam,
        MONTH(v.ThoiGianTT) AS Thang,
        COUNT(v.MaVe) AS SoLuongVe
    FROM dbo.VE v
    WHERE v.TrangThai = N'Da thanh toan'
      AND v.ThoiGianTT IS NOT NULL
    GROUP BY YEAR(v.ThoiGianTT), MONTH(v.ThoiGianTT)
),
TinhToan AS
(
    SELECT 
        Nam,
        Thang,
        SoLuongVe,
        LAG(SoLuongVe) OVER (ORDER BY Nam, Thang) AS VeThangTruoc
    FROM VeTheoThang
)
SELECT 
    Nam,
    Thang,
    SoLuongVe,
    VeThangTruoc,
    CASE 
        WHEN VeThangTruoc IS NULL THEN NULL
        WHEN VeThangTruoc = 0 THEN NULL
        ELSE ROUND((SoLuongVe - VeThangTruoc) * 100.0 / VeThangTruoc, 2)
    END AS TocDoTangTruong_PhanTram
FROM TinhToan
ORDER BY Nam, Thang;


-- Lưu ý: Execute authentication trước authorization  

USE QuanLiChuyenBay;
GO

-- 1. Phân quyền cho role Admin

-- Admin có toàn quyền trên toàn bộ hệ thống

GRANT SELECT, INSERT, UPDATE, DELETE
ON SANBAY TO Role_Admin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON HANGHANGKHONG TO Role_Admin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON LOAIMAYBAY TO Role_Admin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON MAYBAY TO Role_Admin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON CHUYENBAY TO Role_Admin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON LICHBAY TO Role_Admin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON HANHKHACH TO Role_Admin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON BANGGIAVE TO Role_Admin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON VE TO Role_Admin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON HANHLY TO Role_Admin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON NHANVIEN TO Role_Admin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON BANGPHANCONG TO Role_Admin;
GO



-- 2. Phân quyền cho nhân viên điều hành

-- Được xem dữ liệu hệ thống

GRANT SELECT
ON SANBAY TO Role_NhanVienDieuHanh;

GRANT SELECT
ON HANGHANGKHONG TO Role_NhanVienDieuHanh;

GRANT SELECT
ON LOAIMAYBAY TO Role_NhanVienDieuHanh;

GRANT SELECT
ON NHANVIEN TO Role_NhanVienDieuHanh;

GRANT SELECT
ON HANHKHACH TO Role_NhanVienDieuHanh;

GRANT SELECT
ON VE TO Role_NhanVienDieuHanh;


-- Được cập nhật trạng thái máy bay

GRANT SELECT, UPDATE
ON MAYBAY TO Role_NhanVienDieuHanh;


-- Được quản lý chuyến bay

GRANT SELECT, INSERT, UPDATE
ON CHUYENBAY TO Role_NhanVienDieuHanh;

GRANT SELECT, INSERT, UPDATE
ON LICHBAY TO Role_NhanVienDieuHanh;

GRANT SELECT, INSERT, UPDATE
ON BANGGIAVE TO Role_NhanVienDieuHanh;


-- Được phân công nhân viên cho chuyến bay

GRANT SELECT, INSERT, UPDATE
ON BANGPHANCONG TO Role_NhanVienDieuHanh;


-- Không được phép xóa dữ liệu quan trọng

DENY DELETE
ON CHUYENBAY TO Role_NhanVienDieuHanh;

DENY DELETE
ON LICHBAY TO Role_NhanVienDieuHanh;

DENY DELETE
ON BANGGIAVE TO Role_NhanVienDieuHanh;

DENY DELETE
ON BANGPHANCONG TO Role_NhanVienDieuHanh;
GO


-- 3. Phân quyền cho nhân viên bán vé

-- Được xem thông tin chuyến bay

GRANT SELECT
ON SANBAY TO Role_NhanVienBanVe;

GRANT SELECT
ON CHUYENBAY TO Role_NhanVienBanVe;

GRANT SELECT
ON LICHBAY TO Role_NhanVienBanVe;

GRANT SELECT
ON BANGGIAVE TO Role_NhanVienBanVe;


-- Được quản lý thông tin hành khách

GRANT SELECT, INSERT, UPDATE
ON HANHKHACH TO Role_NhanVienBanVe;


-- Được quản lý vé máy bay

GRANT SELECT, INSERT, UPDATE
ON VE TO Role_NhanVienBanVe;


-- Được quản lý hành lý

GRANT SELECT, INSERT, UPDATE
ON HANHLY TO Role_NhanVienBanVe;


-- Không được xóa dữ liệu

DENY DELETE
ON HANHKHACH TO Role_NhanVienBanVe;

DENY DELETE
ON VE TO Role_NhanVienBanVe;

DENY DELETE
ON HANHLY TO Role_NhanVienBanVe;


-- Không được quản lý hệ thống vận hành

DENY INSERT, UPDATE, DELETE
ON MAYBAY TO Role_NhanVienBanVe;

DENY INSERT, UPDATE, DELETE
ON CHUYENBAY TO Role_NhanVienBanVe;

DENY INSERT, UPDATE, DELETE
ON BANGPHANCONG TO Role_NhanVienBanVe;
GO



-- 4. Phân quyền cho role khách hàng

-- Được xem thông tin công khai

GRANT SELECT
ON SANBAY TO Role_KhachHang;

GRANT SELECT
ON CHUYENBAY TO Role_KhachHang;

GRANT SELECT
ON LICHBAY TO Role_KhachHang;

GRANT SELECT
ON BANGGIAVE TO Role_KhachHang;


-- Không được truy cập trực tiếp dữ liệu nhạy cảm

DENY SELECT, INSERT, UPDATE, DELETE
ON VE TO Role_KhachHang;

DENY SELECT, INSERT, UPDATE, DELETE
ON HANHKHACH TO Role_KhachHang;

DENY SELECT, INSERT, UPDATE, DELETE
ON NHANVIEN TO Role_KhachHang;

DENY SELECT, INSERT, UPDATE, DELETE
ON BANGPHANCONG TO Role_KhachHang;
GO



-- 5. Tạo View cho khách hàng xem vé

CREATE OR ALTER VIEW dbo.V_XemVeCuaToi
AS
SELECT
    VE.MaVe,
    VE.SoGhe,
    VE.TrangThai,
    VE.ThoiGianDat,
    VE.ThoiGianTT,
    BANGGIAVE.HangGhe,
    BANGGIAVE.Gia,
    LICHBAY.MaLich,
    LICHBAY.ThoiGianDi,
    LICHBAY.ThoiGianDen
FROM VE
JOIN HANHKHACH
    ON VE.MaHK = HANHKHACH.MaHK
JOIN BANGGIAVE
    ON VE.MaGia = BANGGIAVE.MaGia
JOIN LICHBAY
    ON BANGGIAVE.MaLich = LICHBAY.MaLich
WHERE HANHKHACH.Email = USER_NAME();
GO


-- 6. Cấp quyền xem vé cho khách hàng


GRANT SELECT
ON dbo.V_XemVeCuaToi
TO Role_KhachHang;
GO


-- 7. Stored Procedure đặt vé

-- Khách hàng được phép đặt vé thông qua Procedure

CREATE OR ALTER PROCEDURE dbo.sp_DatVe
(
    @MaVe CHAR(10),
    @MaHK CHAR(10),
    @SoGhe INT,
    @MaGia CHAR(10)
)
AS
BEGIN

    SET NOCOUNT ON;

    BEGIN TRY

        INSERT INTO VE
        (
            MaVe,
            MaHK,
            SoGhe,
            MaGia,
            TrangThai,
            ThoiGianDat
        )
        VALUES
        (
            @MaVe,
            @MaHK,
            @SoGhe,
            @MaGia,
            N'Đã đặt',
            GETDATE()
        );

    END TRY

    BEGIN CATCH

        THROW;

    END CATCH

END;
GO


-- 8. Cấp quyền thực thi đặt vé

GRANT EXECUTE
ON dbo.sp_DatVe
TO Role_KhachHang;
GO



-- 9. Stored Procedure hủy vé

CREATE OR ALTER PROCEDURE dbo.sp_HuyVe
(
    @MaVe CHAR(10)
)
AS
BEGIN

    SET NOCOUNT ON;

    BEGIN TRY

        UPDATE VE
        SET TrangThai = N'Đã hủy'
        WHERE MaVe = @MaVe;

    END TRY

    BEGIN CATCH

        THROW;

    END CATCH

END;
GO



-- 10. Cấp quyền hủy vé

GRANT EXECUTE
ON dbo.sp_HuyVe
TO Role_KhachHang;
GO


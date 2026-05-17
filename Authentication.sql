USE QuanLiChuyenBay;
GO

-- Tạo Role
CREATE ROLE Role_Admin;
CREATE ROLE Role_NhanVienDieuHanh;
CREATE ROLE Role_NhanVienBanVe;
CREATE ROLE Role_KhachHang;
GO

-- Tạo Stored Procedure để làm việc tạo tài khoản tự động (sử dụng Dynamic SQL và Transaction)
CREATE OR ALTER PROCEDURE dbo.sp_BaoMat_TaoTaiKhoan
    @Username VARCHAR(50),
    @Password VARCHAR(255),
    @TargetRole VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        -- Tạo LOGIN ở mức Máy chủ (Server Level) với mật khẩu đi kèm
        DECLARE @SqlLogin NVARCHAR(MAX) = N'CREATE LOGIN ' + QUOTENAME(@Username) + N' WITH PASSWORD = ''' + REPLACE(@Password, '''', '''''') + N''';';
        EXEC sys.sp_executesql @SqlLogin;

        -- Tạo USER ở mức Cơ sở dữ liệu (Database Level) ánh xạ từ LOGIN vừa tạo
        DECLARE @SqlUser NVARCHAR(MAX) = N'CREATE USER ' + QUOTENAME(@Username) + N' FOR LOGIN ' + QUOTENAME(@Username) + N';';
        EXEC sys.sp_executesql @SqlUser;

        -- Cấp quyền CONNECT vào Database cho User mới truy cập được dữ liệu
        DECLARE @SqlConnect NVARCHAR(MAX) = N'GRANT CONNECT TO ' + QUOTENAME(@Username) + N';';
        EXEC sys.sp_executesql @SqlConnect;

        -- Gán USER vào ROLE hệ thống tương ứng
        DECLARE @SqlRole NVARCHAR(MAX) = N'ALTER ROLE ' + QUOTENAME(@TargetRole) + N' ADD MEMBER ' + QUOTENAME(@Username) + N';';
        EXEC sys.sp_executesql @SqlRole;

        COMMIT TRANSACTION;
        PRINT N'Tạo tài khoản và gán Role thành công!';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        -- Trả về lỗi chi tiết nếu trùng tên đăng nhập hoặc sai tên Role
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        THROW 50005, @ErrorMessage, 1;
    END CATCH
END;
GO

-- Các câu lệnh tạo tài khoản cho các Role:
-- 1. Tạo tài khoản cho Quản trị viên
EXEC dbo.sp_BaoMat_TaoTaiKhoan 
    @Username = 'Admin123', 
    @Password = 'AdminPassword123!', 
    @TargetRole = 'Role_Admin';

-- 2. Tạo tài khoản cho một Nhân viên điều hành bay
EXEC dbo.sp_BaoMat_TaoTaiKhoan 
    @Username = 'NV_DieuHanh01', 
    @Password = 'DieuHanh001!', 
    @TargetRole = 'Role_NhanVienDieuHanh';

-- 3. Tạo tài khoản cho một Nhân viên bán vé tại quầy
EXEC dbo.sp_BaoMat_TaoTaiKhoan 
    @Username = 'NV_BanVe01', 
    @Password = 'BanVe001!', 
    @TargetRole = 'Role_NhanVienBanVe';

-- 4. Tạo tài khoản cho một Khách hàng
EXEC dbo.sp_BaoMat_TaoTaiKhoan 
    @Username = 'nguyenvana', 
    @Password = 'HanhKhach001!', 
    @TargetRole = 'Role_KhachHang';
GO
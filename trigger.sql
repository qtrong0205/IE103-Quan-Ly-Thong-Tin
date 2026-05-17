CREATE OR ALTER TRIGGER dbo.TR_BANGGIAVE_CheckThoiGianSoVoiLichBay
ON dbo.BANGGIAVE
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        INNER JOIN dbo.LICHBAY lb ON lb.MaLich = i.MaLich
        WHERE i.ThoiDiemBatDau >= lb.ThoiGianDi
           OR i.ThoiDiemKetThuc >= lb.ThoiGianDi
           OR i.ThoiDiemKetThuc <= i.ThoiDiemBatDau
    )
    BEGIN
        THROW 50001, N'Thoi diem gia ve phai nho hon thoi gian di cua lich bay va ket thuc phai lon hon bat dau.', 1;
    END;
END
GO

CREATE OR ALTER TRIGGER dbo.TR_VE_CheckTrangThai
ON dbo.VE
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        WHERE i.ThoiGianTT IS NOT NULL
          AND i.TrangThai <> N'Da thanh toan'
    )
    BEGIN
        THROW 50002, N'Ve co ThoiGianTT phai co TrangThai la Da thanh toan.', 1;
    END;
END
GO

CREATE OR ALTER TRIGGER dbo.TR_VE_CheckSucChua
ON dbo.VE
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH LichBayBiTacDong AS
    (
        SELECT DISTINCT bgv.MaLich
        FROM inserted i
        INNER JOIN dbo.BANGGIAVE bgv ON bgv.MaGia = i.MaGia
    ),
    SoVeTheoLich AS
    (
        SELECT bgv.MaLich, COUNT_BIG(1) AS SoVeDaDat
        FROM dbo.VE v WITH (UPDLOCK, HOLDLOCK)
        INNER JOIN dbo.BANGGIAVE bgv ON bgv.MaGia = v.MaGia
        INNER JOIN LichBayBiTacDong lbt ON lbt.MaLich = bgv.MaLich
        WHERE v.TrangThai IN (N'Da dat', N'Da thanh toan')
        GROUP BY bgv.MaLich
    )
    IF EXISTS
    (
        SELECT 1
        FROM SoVeTheoLich sv
        INNER JOIN dbo.LICHBAY lb ON lb.MaLich = sv.MaLich
        INNER JOIN dbo.MAYBAY mb ON mb.SoHieu = lb.SoHieuMB
        INNER JOIN dbo.LOAIMAYBAY lmb ON lmb.MaLoai = mb.MaLoai
        WHERE sv.SoVeDaDat > lmb.SucChua
    )
    BEGIN
        THROW 50003, N'Tong so ve da dat hoac da thanh toan vuot qua suc chua may bay. ', 1;
    END;
END
GO


/*MaSB_DI khác MaSB_Den*/
CREATE OR ALTER TRIGGER dbo.TR_MaSB_DI_DEN
ON dbo.CHUYENBAY
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        WHERE i.MaSB_Den = i.MaSB_Di
    )
    BEGIN
        THROW 50002, N'Ma san bay den khac san bay di', 1;
    END;
END
GO

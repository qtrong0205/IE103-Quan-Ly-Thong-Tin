-- Lấy thông tin vé
create or alter function FN_LayThongTinVe
(
    @MaVe CHAR(10)
)
returns table
as
return
(
    select V.MaVe, HK.HoTen, V.SoGhe, V.TrangThai, V.ThoiGianDat, V.ThoiGianTT
    from VE V
    join HANHKHACH HK on V.MaHK = HK.MaHK
    where V.MaVe = @MaVe
)
go

-- Tìm chuyến bay
create or alter function FN_TimChuyenBay
(
    @MaCB_Di  char(5),
    @MaCB_Den char(5),
    @ngay     date
)
returns table
as
return
(
    select lb.MaLich, lb.MaCB, lb.ThoiGianDi, lb.ThoiGianDen, lb.TrangThai,
           sb1.TenSB as TenSanBayDi, sb2.TenSB as TenSanBayDen,
           lmb.SucChua - isnull(count(v.MaVe), 0) as SoGheCon
    from LICHBAY lb
    join CHUYENBAY cb   on lb.MaCB        = cb.MaCB
    join SANBAY    sb1  on cb.MaSB_Di     = sb1.MaSB      
    join SANBAY    sb2  on cb.MaSB_Den    = sb2.MaSB     
    join MAYBAY    mb   on lb.SoHieuMB   = mb.SoHieu
    join LOAIMAYBAY lmb on mb.MaLoai     = lmb.MaLoai
    left join BANGGIAVE bg on bg.MaLich  = lb.MaLich
    left join VE v         on v.MaGia    = bg.MaGia
                          and v.TrangThai <> N'Da huy'
    where cb.MaSB_Di  = @MaCB_Di          
      and cb.MaSB_Den = @MaCB_Den       
      and cast(lb.ThoiGianDi as date) = @ngay
      and lb.TrangThai <> N'Huy'
    group by lb.MaLich, lb.MaCB, lb.ThoiGianDi, lb.ThoiGianDen, lb.TrangThai,
             sb1.TenSB, sb2.TenSB, lmb.SucChua
)
go

-- Tìm số ghế đã đặt 
create or alter function FN_SoGheDaDat
(
    @MaLich char(10)
)
returns int
as
begin
    declare @kq int

    select @kq = count(V.MaVe)
    from VE V
    join BANGGIAVE BG on V.MaGia = BG.MaGia
    where BG.MaLich = @MaLich
      and V.TrangThai <> N'Da huy'

    return isnull(@kq, 0)
end
go

-- Danh sách vé theo hành khách 
create or alter function FN_LayDanhSachVeTheoHanhKhach
(
    @MaHK char(10)
)
returns table
as
return
(
    select V.MaVe, V.SoGhe, V.TrangThai, V.ThoiGianDat,
           LB.MaLich, LB.ThoiGianDi,
           SB1.TenSB as SanBayDi, SB2.TenSB as SanBayDen
    from VE V
    join BANGGIAVE BG  on V.MaGia    = BG.MaGia
    join LICHBAY   LB  on BG.MaLich  = LB.MaLich
    join CHUYENBAY CB  on LB.MaCB    = CB.MaCB
    join SANBAY    SB1 on CB.MaSB_Di  = SB1.MaSB
    join SANBAY    SB2 on CB.MaSB_Den = SB2.MaSB
    where V.MaHK = @MaHK
)
go

-- Chi tiết lịch bay
create or alter function FN_ChiTietLichBay
(
    @MaLich char(10)
)
returns table
as
return
(
    select LB.MaLich, LB.MaCB, LB.SoHieuMB,
           LMB.TenLoaiMB, LMB.SucChua,
           LB.ThoiGianDi, LB.ThoiGianDen, LB.TrangThai
    from LICHBAY LB
    join MAYBAY     MB  on LB.SoHieuMB = MB.SoHieu
    join LOAIMAYBAY LMB on MB.MaLoai   = LMB.MaLoai
    where LB.MaLich = @MaLich
)
go

-- Tính tổng trọng lượng hành lý theo mã vé
create or alter function FN_TongTrongLuongHanhLy
(
    @MaVe char(10)
)
returns decimal(5,2)
as
begin
    declare @kq decimal(5,2)

    select @kq = sum(TrongLuong)
    from HANHLY
    where MaVe = @MaVe

    return isnull(@kq, 0)
end
go

-- Lấy danh sách nhân viên theo lịch bay 
create or alter function FN_DanhSachNhanVienTheoLich
(
    @MaLich char(10)
)
returns table
as
return
(
    select NV.MaNV, NV.TenNV, PC.VaiTro, NV.ChucVu
    from BANGPHANCONG PC
    join NHANVIEN NV on PC.MaNV = NV.MaNV
    where PC.MaLich = @MaLich
)
go
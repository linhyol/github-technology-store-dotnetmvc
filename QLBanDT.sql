-----Tao CSDL QLBanSP
create database QLBANSP
GO
use QLBANSP
-----Tao CSDL QLBan
CREATE TABLE KHACHHANG
(
MaKH INT IDENTITY(1,1),
HoTen nVarchar(50) NOT NULL,
Taikhoan Varchar(50) UNIQUE,
Matkhau Varchar(50) NOT NULL,
Email Varchar(100) UNIQUE,
DiachiKH nVarchar(200),
DienthoaiKH Varchar(50),
Ngaysinh DATETIME,
CONSTRAINT PK_Khachhang PRIMARY KEY(MaKH)
)
GO

Create Table LOAI
(
MaLoai int Identity(1,1),
TenLoai nvarchar(50) NOT NULL,
CONSTRAINT PK_ChuDe PRIMARY KEY(MaLoai)
)
GO

Create Table NHASX
(
MaNSX int identity(1,1),
TenNSX nvarchar(50) NOT NULL,
Diachi NVARCHAR(200),
DienThoai VARCHAR(50),
CONSTRAINT PK_NhaSanXuat PRIMARY KEY(MaNSX)
)
Go
CREATE TABLE DT
(
Madt INT IDENTITY(1,1),
Tendt NVARCHAR(100) NOT NULL,
Giaban Decimal(18,0) CHECK (Giaban>=0),
Mota NVarchar(Max),
Anhbia VARCHAR(50),
Ngaycapnhat DATETIME,
Soluongton INT,
MaLoai INT,
MaNSX INT,
Constraint PK_DT Primary Key(Madt),
Constraint FK_Loai Foreign Key(MaLoai) REFERENCES LOAI(MaLoai),
Constraint FK_NhaSX_DT Foreign Key(MaNSX)REFERENCES NHASX(MaNSX)
)
GO


CREATE TABLE DONDATHANG
(
MaDonHang INT IDENTITY(1,1),
Dathanhtoan bit,
Tinhtranggiaohang bit,
Ngaydat Datetime,
Ngaygiao Datetime,
MaKH INT,
CONSTRAINT FK_Khachhang FOREIGN KEY (MaKH) REFERENCES dbo.KHACHHANG(MaKH),
CONSTRAINT PK_DonDatHang PRIMARY KEY (MaDonHang)
)
Go
CREATE TABLE CHITIETDONTHANG
(
MaDonHang INT,
Madt INT,
Soluong Int Check(Soluong>0),
Dongia Decimal(18,0) Check(Dongia>=0),
CONSTRAINT PK_CTDatHang PRIMARY KEY(MaDonHang,Madt),
CONSTRAINT FK_Donhang FOREIGN KEY (Madonhang) REFERENCES Dondathang(Madonhang),
CONSTRAINT FK_DT_CTDH FOREIGN KEY (Madt) REFERENCES DT(Madt)
)

insert into LOAI(TenLoai) values (N'ĐIỆN THOẠI'),--1
										(N'MÁY TÍNH BẢNG'),--2
										(N'LAPTOP')--3
							
insert into nhaSX(TenNSX, Diachi, DienThoai) values(N'Apple',N'China','+1 609.865.5965'),--1
													(N'SamSung',N'VietNam',' 1800.588.855'),--2
													(N'Oppo',N'China','1800.577.776'),--3
													(N'Nokia',N'Finland','+1 408 737 0900'),--4
													(N'Huawei',N'China','028 39208468'),--5
													(N'Lenovo',N'China','120-11550'),--6
													(N'Mobell',N'China','028 3948 7033'),--7
													(N'Dell',N'America','120-11511150'),--8
													(N'Asus',N'Taiwan','+12 384093'),--9
													(N'Hp',N'USA','+1400 12011-11550'),--10
													(N'Acer',N'Taiwan','+12 09730-11550')--11
-- Điện Thoại
insert into DT(Tendt, Giaban, Mota, Anhbia, Ngaycapnhat, Soluongton,MaLoai,  MaNSX) 
	values(N'Iphone XR',20000000,N'Bán Thận',N'/images/apr.jpg',GETDATE(),12,1,1),
	(N'Iphone8',19000000,N'Nửa Quả Thận',N'/images/ap8.jpg',GETDATE(),12,1,1),
	(N'Iphone X',18000000,N'3/4 Quả Thận',N'/images/apx.jpg',GETDATE(),12,1,1),
	(N'Samsung Note 9',20000000,N'1Quả Thận',N'/images/ss3.jpg',GETDATE(),12,1,2),
	(N'Samsung Note  A7',10000000,N'1/2Quả Thận',N'/images/ssa7.jpg',GETDATE(),12,1,2),
	(N'Samsung NoteA6+',8000000,N'1/5Quả Thận',N'/images/ssa6.png',GETDATE(),12,1,2),
	(N'Oppo F9',10000000,N'1/3 Quả Thận',N'/images/oppo1.jpg',GETDATE(),12,1,3),
	(N'Oppo F7',10000000,N'1/3 Quả Thận',N'/images/oppo2.jpg',GETDATE(),12,1,3),
	(N'Oppo F1',10000000,N'1/3 Quả Thận',N'/images/oppo3.jpg',GETDATE(),12,1,3),
	(N'Oppo F1s',10000000,N'1/3 Quả Thận',N'/images/oppo4.jpg',GETDATE(),12,1,3),
	(N'Oppo F3',10000000,N'1/3 Quả Thận',N'/images/oppo5.jpg',GETDATE(),12,1,3),
	(N'Oppo F4',10000000,N'1/3 Quả Thận',N'/images/oppo6.jpg',GETDATE(),12,1,3),
	(N'Nokia 5.1',10000,N'1/3 Quả Thận',N'/images/nokia1.jpg',GETDATE(),12,1,4),
	(N'Nokia 6.1',10000,N'1/3 Quả Thận',N'/images/nokia2.jpg',GETDATE(),12,1,4),
	(N'Nokia 6',10000,N'1/3 Quả Thận',N'/images/nokia3.jpg',GETDATE(),12,1,4),
	(N'Nokia 3',10000,N'1/3 Quả Thận',N'/images/nokia4.jpg',GETDATE(),12,1,4),
	(N'Nokia 4',10000,N'1/3 Quả Thận',N'/images/nokia5.jpg',GETDATE(),12,1,4),
	(N'Nokia 5',10000,N'1/3 Quả Thận',N'/images/nokia6.jpg',GETDATE(),12,1,4),
	(N'Huawei nova 3i',10000,N'1/3 Quả Thận',N'/images/h2.jpg',GETDATE(),12,1,5),
	(N'Huawei Mate 20 Pro',20000000,N'1 Quả Thận',N'/images/h1.jpg',GETDATE(),12,1,5),
	(N'Huawei Y9',1000000,N'1/3 Quả Thận',N'/images/hy9.jpg',GETDATE(),12,1,5),
	(N'Huawei nova 3e',10000,N'1/3 Quả Thận',N'/images/huawei4.jpg',GETDATE(),12,1,5),
	(N'Huawei nova 2',10000,N'1/3 Quả Thận',N'/images/huawei5.jpg',GETDATE(),12,1,5),
	(N'Huawei nova 2ii',10000,N'1/3 Quả Thận',N'/images/huawei6.jpg',GETDATE(),12,1,5),
	(N'Mobell  2q',5000000,N'1/3 Quả Thận',N'/images/mobell1.jpg',GETDATE(),12,2,7),
	(N'Mobell  2w',5000000,N'1/3 Quả Thận',N'/images/mobell2.jpg',GETDATE(),12,2,7),
	(N'Mobell  2e',5000000,N'1/3 Quả Thận',N'/images/mobell3.jpg',GETDATE(),12,2,7)
--Máy Tính Bảng
INSERT INTO DT(Tendt, Giaban, Mota, Anhbia, Ngaycapnhat, Soluongton,MaLoai,  MaNSX) 
	VALUES(N'Ipab Pro 10.1',20000000,N'1 Quả Thận',N'/images/ip1.jpg',GETDATE(),12,2,1),
	(N'Ipab Pro 10.5',22000000,N'1 Quả Thận',N'/images/ip2.jpg',GETDATE(),12,2,1),
	(N'Ipab Air',19000000,N'1 Quả Thận',N'/images/ip3.jpg',GETDATE(),12,2,1),
	(N'SamSung Tab A6',7005000,N'1/3 Quả Thận',N'/images/tabs1.jpg',GETDATE(),12,2,2),
	(N'SamSung Tab A',7005000,N'1/3 Quả Thận',N'/images/tabs2.jpg',GETDATE(),12,2,2),
	(N'SamSung Tab S6',7005000,N'1/3 Quả Thận',N'/images/tabs3.jpg',GETDATE(),12,2,2),
	(N'Lenovo tab2',5000000,N'1/3 Quả Thận',N'/images/tabl1.jpg',GETDATE(),12,2,6),
	(N'Lenovo tab s2',5000000,N'1/3 Quả Thận',N'/images/tabl2.jpg',GETDATE(),12,2,6),
	(N'Lenovo tab pab2',5000000,N'1/3 Quả Thận',N'/images/tabl3.jpg',GETDATE(),12,2,6),
	(N'Lenovo tab s2',5000000,N'1/3 Quả Thận',N'/images/tabl2.jpg',GETDATE(),12,2,6),
	(N'Lenovo tab s2',5000000,N'1/3 Quả Thận',N'/images/tabl2.jpg',GETDATE(),12,2,6),
	(N'Lenovo tab s2',5000000,N'1/3 Quả Thận',N'/images/tabl2.jpg',GETDATE(),12,2,6),
	(N'Mobell tab10',5000000,N'1/3 Quả Thận',N'/images/tabm1.jpg',GETDATE(),12,2,7),
	(N'Mobell tab 8',5000000,N'1/3 Quả Thận',N'/images/tabm2.jpg',GETDATE(),12,2,7),
	(N'Mobell tab 8',5000000,N'1/3 Quả Thận',N'/images/tabm2.jpg',GETDATE(),12,2,7),
	(N'Mobell tab 8',5000000,N'1/3 Quả Thận',N'/images/tabm2.jpg',GETDATE(),12,2,7),
	(N'Mobell tab 2',5000000,N'1/3 Quả Thận',N'/images/tabm3.jpg',GETDATE(),12,2,7)
--Laptop
INSERT INTO DT(Tendt, Giaban, Mota, Anhbia, Ngaycapnhat, Soluongton,MaLoai,  MaNSX) 
	VALUES(N'Macbook pro',59000000,N'2 Quả Thận',N'/images/macbook1.jpg',GETDATE(),12,3,1),
	(N'Macbook pro 1',44000000,N'2 Quả Thận',N'/images/macbook2.jpg',GETDATE(),12,3,1),
	(N'Macbook pro 2',50000000,N'2 Quả Thận',N'/images/macboo31.jpg',GETDATE(),12,3,1),
	(N'Dell Inspiron 7570 i7',25000000,N'1 Quả Thận',N'/images/dell1.jpg',GETDATE(),12,3,8),
	(N'Dell Inspiron 7570 i5',25000000,N'1 Quả Thận',N'/images/dell2.jpg',GETDATE(),12,3,8),
	(N'Dell Inspiron 7570 i3',25000000,N'1 Quả Thận',N'/images/dell3.jpg',GETDATE(),12,3,8),
	(N'Asus ROG Strix Scar GL504GM i7',50000000,N'2 Quả Thận',N'/images/asus1.jpg',GETDATE(),12,3,9),
	(N'Asus Vivobook S15 S530UA i5',29000000,N'1 Quả Thận',N'/images/asus2.jpg',GETDATE(),12,3,9),
	(N'Asus VivoBook S510UN i5',25000000,N'1 Quả Thận',N'/images/asus3.jpg',GETDATE(),12,3,9),
	(N'Asus VivoBook S510UN i5',25000000,N'1 Quả Thận',N'/images/asus3.jpg',GETDATE(),12,3,9),
	(N'Asus VivoBook S510UN i5',25000000,N'1 Quả Thận',N'/images/asus3.jpg',GETDATE(),12,3,9),
	(N'HP Envy 13 ah0027TU i7',5000000000,N'2 Quả Thận',N'/images/hp1.jpg',GETDATE(),12,3,10),
	(N'HP Envy 13 ah0025TU i5',4000000000,N'2 Quả Thận',N'/images/hp2.jpg',GETDATE(),12,3,10),
	(N'HP Envy 13 ah0027TU i3',3000000000,N'2 Quả Thận',N'/images/hp3.jpg',GETDATE(),12,3,10),
	(N'HP Envy 13 ah0027TU i3',3000000000,N'2 Quả Thận',N'/images/hp3.jpg',GETDATE(),12,3,10),
	(N'HP Envy 13 ah0027TU i3',3000000000,N'2 Quả Thận',N'/images/hp3.jpg',GETDATE(),12,3,10),
	(N'Acer Nitro 5 AN515 52 70AE i7',5000000000,N'2 Quả Thận',N'/images/acer2.jpg',GETDATE(),12,3,11),
	(N'Acer Nitro 5 AN515 52 70AE i5',4000000000,N'2 Quả Thận',N'/images/acer1.jpg',GETDATE(),12,3,11),
	(N'Acer Nitro 5 AN515 52 70AE i3',3000000000,N'2 Quả Thận',N'/images/acer3.jpg',GETDATE(),12,3,11),
	(N'Acer Nitro 5 AN515 52 70AE i5',4000000000,N'2 Quả Thận',N'/images/acer1.jpg',GETDATE(),12,3,11),
	(N'Acer Nitro 5 AN515 52 70AE i5',4000000000,N'2 Quả Thận',N'/images/acer1.jpg',GETDATE(),12,3,11)


	
select * from dbo.NHASX
select * from dbo.DT
SELECT * FROM dbo.LOAI
SELECT * FROM dbo.KHACHHANG

SELECT *FROM dbo.DONDATHANG
SELECT * FROM dbo.CHITIETDONTHANG





CREATE TABLE ADMIN
(
	UserAdmin VARCHAR(30) PRIMARY KEY,
	PassAdmin VARCHAR(30) NOT NULL,
	HoTen NVARCHAR(50)
)
INSERT INTO dbo.ADMIN VALUES ('linh','123','Nguyen Vuong Linh')
INSERT INTO dbo.ADMIN VALUES ('hieu','123','Nguyen Minh Hieu')
		 SELECT * FROM dbo.ADMIN	
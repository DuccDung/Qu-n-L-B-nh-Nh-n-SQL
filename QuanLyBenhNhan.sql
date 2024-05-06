create database QUANLYBENHNHAN
go 
use QUANLYBENHNHAN
go

create table BệnhNhân(
   MaBN varchar(10) constraint PK_BN primary key, 
   Họ nvarchar(50),
   Tên nvarchar(50),
   Ngaysinh DATE,
   Địachỉ nvarchar(100),
   Sdt varchar(50),
   giớitính nvarchar(10),
   Bảohiểmytế nvarchar(50) 
);


create table ThânNhân(
   MaBN varchar(10) not null constraint FK_BN3  foreign key(MaBN)  references [dbo].[BệnhNhân](MABN),
   Họ nvarchar(50),
   Tên nvarchar(50),
   DịaChỉ nvarchar(100),
   GiớiTính nvarchar(10),
   MốiQuanHệ nvarchar(10)
);


create table HồSơBệnhÁn(
MaHS varchar(10) constraint PK_HS primary key,
MaP varchar(10) not null, -- thieu
MaPNV varchar(10) not null,
MaBN varchar(10) not null constraint PK_MaBN foreign key references [dbo].[BệnhNhân](MaBN),
ChuanDoan nvarchar(500),
PhươngPhápDiềuTrị nvarchar(500)
);


create table PhiếuXuấtViện(
MaPXV varchar(10) constraint PK_PXV primary key,
NgàyXuấtViện date,
MaHS varchar(10) constraint FK_HS foreign key references[dbo].[HồSơBệnhÁn](MaHS)
);

create table DịchVụ (
 MaDV varchar(10) constraint PK_DV primary key,
 TênDịchVụ nvarchar(50),
 Giá float
);


create table BệnhNhân_DịchVụ(
    MaBN varchar(10) not null constraint FK_BN foreign key references [dbo].[BệnhNhân](MaBN),
	MaDV varchar(10) not null constraint FK_DV foreign key references [dbo].[DịchVụ](MaDV),
	NgàySửDụng date
);




create table Thuốc(
MaT varchar(10) constraint PK_T primary key,
MaDT varchar(10) not null ,
TênThuốc varchar(50) not null,
HDSD nvarchar(500) not null,
LiềuLượng nvarchar(50) not null,
Giá float
);

create table HóaĐơn(
MaHD varchar(10) constraint PK_MaHD primary key,
MaBN varChar(10) not null constraint FK_MaBN foreign key references  [dbo].[BệnhNhân](MaBN),
NgàyHạn date,
TổngTiền float
);

create table ChiTiếtHóaĐơn(
MaHD varchar(10) not null constraint FK_MaHD foreign key references [dbo].[HóaĐơn](MaHD),
TiềnKhám float,
MaDV varchar(10) not null constraint FK_MaDV foreign key references [dbo].[DịchVụ](MaDV),
MaT varchar(10) not null constraint FK_MaT foreign key references [dbo].[Thuốc](MaT)
);


create table ĐơnThuốc (
MaDT varchar(10) constraint PK_MaDT primary key,
MaBS varchar(10) not null,
MaHS varchar(10) not null,
NgàyKêĐơn varchar(10) not null,
GiáĐơnThuốc float
);
-- alter
Alter table [dbo].[ĐơnThuốc]
add constraint FK_HS2 foreign key ([MaHS])
references [dbo].[HồSơBệnhÁn](MaHS);


create table ĐơnThuốc_Thuốc(
MaDT varchar(10) not null constraint FK_MaDT foreign key references [dbo].[ĐơnThuốc](MaDT),
MaT varchar(10) not null constraint FK_T foreign key references [dbo].[Thuốc](MaT),
SốLượng int
);

create table BácSĩ(
MaBS varchar(10) constraint PK_BS primary key,
Họ nvarchar(50) not null,
Tên nvarchar(50) not null,
SDT varchar(20),
ĐịaChỉ nvarchar(50) 
);
-- alter
Alter table [dbo].[ĐơnThuốc]
add constraint FK_BS3 foreign key ([MaBS])
references [dbo].[BácSĩ](MaBS);

create table Khoa(
MaK varchar(10) constraint PK_K primary key,
MaTK varchar(10) not null constraint FK_BS foreign key references [dbo].[BácSĩ](MaBS),
TênKHoa nvarchar(50) not null
);

create table Phòng(
MaP varchar(10) constraint PK_P primary key,
MaK varchar(10) not null constraint FK_K foreign key references [dbo].[Khoa](MaK),
TênPhòng nvarchar(10),
LoạiPhòng nvarchar(10),
ĐịaChỉ nvarchar(10)
);
--alter 
alter table [dbo].[HồSơBệnhÁn]
add constraint FK_MaP2 foreign key ([MaP])
references [dbo].[Phòng](MaP);

create table Phòng_BácSĩ(
MaP varchar(10) not null constraint FK_P foreign key references [dbo].[Phòng](MaP),
MaBS varchar(10) not null constraint FK_BS1  foreign key references [dbo].[BácSĩ](MaBS),
PhụTrách nvarchar(10)
);

create table PhiếuNhậpViện(
MaPNV varchar(10) constraint PK_PNV primary key,
NgàyNhậpViện date,
MaP varchar(10) constraint FK_P2 foreign key references [dbo].[Phòng](MaP)
);
-- alter
alter table [dbo].[HồSơBệnhÁn]
add constraint FK_MaPNV foreign key([MaPNV])
references [dbo].[PhiếuNhậpViện](MaPNV);

create table Phòng_BN(
MaP varchar(10) constraint FK_P3 foreign key references [dbo].[Phòng](MaP),
MaBN varchar(10) constraint FK_MaBN1 foreign key references [dbo].[BệnhNhân](MaBN),
ThờiGianKhám date,
ThờiGianĐiềuTrị date
);

create table BácSĩ_HồSơBệnhÁn(
MaBS varchar(10) constraint FK_BS2 foreign key references [dbo].[BácSĩ](MaBS),
MaHS varchar(10) constraint FK_HS1 foreign key references [dbo].[HồSơBệnhÁn](MaHS),
KhámBệnh nvarchar(10),
Điềutrị nvarchar(10)
);
GO
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS001',N'Lê Xuân',N'An',N'0987654321',N'Hà Nội')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS002',N'Nguyễn Mai',N'Anh',N'0987654312',N'Hà Nội')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS003',N'Lê Ngọc',N'Ánh',N'0987654231',N'Phú Thọ')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS004',N'Vũ Mạnh',N'Bảo',N'0987654213',N'Hưng Yên')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS005',N'Nguyễn Thị Ngọc',N'Bích',N'0987654123',N'Hà Nội')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS006',N'Nguyễn Hùng',N'Cường',N'0987654132',N'Hà Nội')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS007',N'Vũ Mạnh',N'Cường',N'0987651234',N'Hưng Yên')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS008',N'Trịnh Xuân',N'Dũng',N'0987651243',N'Thanh Hoá')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS009',N'Nguyễn Thái',N'Dương',N'0987651324',N'Thái Nguyên')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS010',N'Phùng Văn',N'Dương',N'0987651342',N'Hải Dương')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS011',N'Nguyễn Đức',N'Dũng',N'0987123456',N'Bắc Giang')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS012',N'Nguyễn Quốc',N'Khánh',N'0987123465',N'Hà Nội')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS013',N'Hoàng Mạnh',N'Khiêm',N'0987123546',N'Thanh Hóa')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS014',N'Lê Trung',N'Kiên',N'0987123564',N'Bắc Giang')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS015',N'Nguyễn Văn Hoàng',N'Lâm',N'0987213456',N'Thái Bình')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS016',N'Lê Quang',N'Long',N'0987213465',N'Hà Nội')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS017',N'Trương Xuân',N'Lộc',N'0987214356',N'Hà Nội')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS018',N'Phạm Duy',N'Lợi',N'0987214365',N'Thái Bình')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS019',N'Nguyễn Hữu',N'Minh',N'0987214635',N'Hà Nội')
INSERT [dbo].[BácSĩ]([MaBS],[Họ],[Tên],[SDT],[ĐịaChỉ]) VALUES (N'BS020',N'Nguyễn Văn',N'Minh',N'0987231456',N'Thái Bình')

INSERT [dbo].[BệnhNhân]([MaBN],[Họ],[Tên],[giớitính],[Ngaysinh],[Địachỉ],[Sdt],[Bảohiểmytế]) VALUES (N'BN001',N'Trần Xuân',N'Đạt',N'Nam', CAST(N'2009-02-14T00:00:00.000' AS DateTime), N'Hà Nội',N'0987651423','222631085')
INSERT [dbo].[BệnhNhân]([MaBN],[Họ],[Tên],[giớitính],[Ngaysinh],[Địachỉ],[Sdt],[Bảohiểmytế]) VALUES (N'BN002',N'Trương Quảng',N'Đông',N'Nam', CAST(N'1997-09-02T00:00:00.000' AS DateTime), N'Hà Nội',N'0987612345','222631088')
INSERT [dbo].[BệnhNhân]([MaBN],[Họ],[Tên],[giớitính],[Ngaysinh],[Địachỉ],[Sdt],[Bảohiểmytế]) VALUES (N'BN003',N'Nguyễn Minh',N'Đức',N'Nam', CAST(N'1990-02-17T00:00:00.000' AS DateTime), N'Thanh Hoá',N'0987651423','222631089')
INSERT [dbo].[BệnhNhân]([MaBN],[Họ],[Tên],[giớitính],[Ngaysinh],[Địachỉ],[Sdt],[Bảohiểmytế]) VALUES (N'BN004',N'Giang Thị',N'Hải',N'Nữ', CAST(N'1993-06-02T00:00:00.000' AS DateTime), N'Ninh Bình',N'0987651423','222631091')
INSERT [dbo].[BệnhNhân]([MaBN],[Họ],[Tên],[giớitính],[Ngaysinh],[Địachỉ],[Sdt],[Bảohiểmytế]) VALUES (N'BN005',N'Trần Minh',N'Hiếu',N'Nam', CAST(N'1940-04-21T00:00:00.000' AS DateTime), N'Phú Thọ',N'0987651423','222631095')
INSERT [dbo].[BệnhNhân]([MaBN],[Họ],[Tên],[giớitính],[Ngaysinh],[Địachỉ],[Sdt],[Bảohiểmytế]) VALUES (N'BN006',N'Vũ Minh',N'Hiếu',N'Nam', CAST(N'2001-11-04T00:00:00.000' AS DateTime), N'Hà Nội',N'0987651423','222631096')
INSERT [dbo].[BệnhNhân]([MaBN],[Họ],[Tên],[giớitính],[Ngaysinh],[Địachỉ],[Sdt],[Bảohiểmytế]) VALUES (N'BN007',N'Đỗ Duy',N'Huân',N'Nam', CAST(N'1999-01-01T00:00:00.000' AS DateTime), N'Nam Định',N'0987651423','222631098')
INSERT [dbo].[BệnhNhân]([MaBN],[Họ],[Tên],[giớitính],[Ngaysinh],[Địachỉ],[Sdt],[Bảohiểmytế]) VALUES (N'BN008',N'Bùi Quang',N'Huy',N'Nam', CAST(N'1962-11-27T00:00:00.000' AS DateTime), N'Hà Nội',N'0987651423','222631101')
INSERT [dbo].[BệnhNhân]([MaBN],[Họ],[Tên],[giớitính],[Ngaysinh],[Địachỉ],[Sdt],[Bảohiểmytế]) VALUES (N'BN009',N'Vũ Quang',N'Huy',N'Nam', CAST(N'2020-02-08T00:00:00.000' AS DateTime), N'Hà Nội',N'0987651423','222631102')
INSERT [dbo].[BệnhNhân]([MaBN],[Họ],[Tên],[giớitính],[Ngaysinh],[Địachỉ],[Sdt],[Bảohiểmytế]) VALUES (N'BN010',N'Mai Đức',N'Khánh',N'Nam', CAST(N'2012-08-23T00:00:00.000' AS DateTime), N'Hà Tĩnh',N'0987651423','222631103')

INSERT [dbo].[Khoa] ([MaK],[MaTK],[TênKHoa]) VALUES (N'K001', N'BS001', N'Khoa Sản-Nhi')
INSERT [dbo].[Khoa] ([MaK],[MaTK],[TênKHoa]) VALUES (N'K002', N'BS004', N'Khoa Nội tổng hợp')
INSERT [dbo].[Khoa] ([MaK],[MaTK],[TênKHoa]) VALUES (N'K003', N'BS008', N'Khoa Ngoại tổng hợp')
INSERT [dbo].[Khoa] ([MaK],[MaTK],[TênKHoa]) VALUES (N'K004', N'BS005', N'Khoa Truyền nhiễm')
INSERT [dbo].[Khoa] ([MaK],[MaTK],[TênKHoa]) VALUES (N'K005', N'BS0014', N'Khoa Da liễu')
INSERT [dbo].[Khoa] ([MaK],[MaTK],[TênKHoa]) VALUES (N'K006', N'BS0012', N'Khoa Huyết học lâm sàng')
INSERT [dbo].[Khoa] ([MaK],[MaTK],[TênKHoa]) VALUES (N'K007', N'BS0018', N'Khoa Thần kinh')
INSERT [dbo].[Khoa] ([MaK],[MaTK],[TênKHoa]) VALUES (N'K008', N'BS0020', N'Khoa Chuẩn đoán hình ảnh')

--Khoa Sản-Nhi
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P01A', N'K001', N'PKSPK', N'Phòng khám sản phụ khoa', N'Tầng 2, Khu A') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P02A', N'K001', N'PKNK', N'Phòng khám nhi khoa', N'Tầng 2, Khu A') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P03A', N'K001', N'PS', N'Phòng sinh', N'Tầng 3, Khu A') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P04A', N'K001', N'PHS', N'Phòng hậu sản', N'Tầng 3, Khu A') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P05A', N'K001', N'PCSSS', N'Phòng chăm sóc, điều trị sơ sinh', N'Tầng 3, Khu A') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P06A', N'K001', N'PPT', N'Phòng phẫu thuật', N'Tầng 3, Khu A')
--Khoa Nội tổng hợp
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P01B', N'K002', N'PKNTH', N'Phòng khám', N'Tầng 2, Khu B') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P02B', N'K002', N'PĐTN', N'Phòng điều trị', N'Tầng 2, Khu B') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P03B', N'K002', N'PXNN', N'Phòng xét nghiệm', N'Tầng 2, Khu B') 
--Khoa Ngoại tổng hợp
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P04B', N'K003', N'PKNGTH', N'Phòng khám', N'Tầng 3, Khu B') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P05B', N'K003', N'PĐTNG', N'Phòng điều trị', N'Tầng 3, Khu B') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P06B', N'K003', N'PXNNG', N'Phòng xét nghiệm', N'Tầng 3, Khu B') 
--Khoa Truyền nhiễm
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P01E', N'K004', N'PKTN', N'Phòng khám', N'Tầng 2, Khu E') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P02E', N'K004', N'PCC', N'Phòng cấp cứu', N'Tầng 1, Khu E') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P03E', N'K004', N'PTĐ', N'Phòng tiếp đón và điều trị nội trú', N'Tầng 1, Khu E') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P04E', N'K004', N'PXN', N'Phòng xét nghiệm', N'Tầng 2, Khu E') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P05E', N'K004', N'PCSSS', N'Phòng cách ly', N'Tầng 3, Khu E') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P06E', N'K004', N'PPT', N'Phòng tiêm phòng', N'Tầng 1, Khu E')
--Khoa Da liễu
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P01G', N'K005', N'PKDL', N'Phòng khám & tư vấn da liễu', N'Tầng 2, Khu G') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P02G', N'K005', N'PXN', N'Phòng xét nghiệm', N'Tầng 2, Khu G') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P03G', N'K005', N'PĐT', N'Phòng điều trị', N'Tầng 3, Khu G') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P04G', N'K005', N'PLS', N'Phòng laser da liễu', N'Tầng 3, Khu G') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P05G', N'K005', N'PQTL', N'Phòng quang trị liệu', N'Tầng 3, Khu G') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P06G', N'K005', N'PPT', N'Phòng can thiệp da liễu', N'Tầng 3, Khu G')
--Khoa Huyết học lâm sàng
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P01D', N'K006', N'PKHH', N'Phòng khám Huyết học', N'Tầng 2, Khu D') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P02D', N'K006', N'PT', N'Phòng Tiêm dịch và Huyết quản', N'Tầng 2, Khu D') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P03D', N'K006', N'PTM', N'Phòng truyền máu', N'Tầng 3, Khu D') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P04D', N'K006', N'PXNM', N'Phòng xét nghiệm', N'Tầng 3, Khu D') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P05D', N'K006', N'PCSĐT', N'Phòng chăm sóc, điều trị', N'Tầng 3, Khu D') 
--Khoa Thần kinh
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P01C', N'K007', N'PKTK', N'Phòng khám thần kinh', N'Tầng 2, Khu C') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P02C', N'K007', N'PEEG', N'Phòng Điện não đồ(EEG)', N'Tầng 2, Khu C') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P03C', N'K007', N'PĐTK', N'Phòng Điện thần kinh (EMG/NCS)', N'Tầng 3, Khu C') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P04C', N'K007', N'PCTTK', N'Phòng Can thiệp Thần kinh', N'Tầng 3, Khu C') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P05C', N'K007', N'PICU', N'Phòng Hồi sức đặc biệt (ICU)', N'Tầng 3, Khu C') 
--Khoa Chuẩn đoán hình ảnh
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P11B', N'K008', N'PCXQ', N'Phòng chụp X-quang', N'Tầng 4, Khu B')
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P12B', N'K008', N'PCCT', N'Phòng chụp CT', N'Tầng 4, Khu B') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P13B', N'K008', N'PMRI',N'Phòng chụp MRI', N'Tầng 4, Khu B') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P14B', N'K008', N'PSA', N'Phòng siêu âm', N'Tầng 4, Khu B') 
INSERT [dbo].[Phòng] ([MaP],[MaK],[TênPhòng],[LoạiPhòng],[ĐịaChỉ]) VALUES (N'P15B', N'K008', N'PNS', N'Phòng nội soi', N'Tầng 4, Khu B') 

INSERT [dbo].[ThânNhân] ([MaBN],[Họ],[Tên],[DịaChỉ],[GiớiTính],[MốiQuanHệ]) VALUES (N'BN001', N'Trần Huy', N'Nam', N'Hà Nội', N'Nam', N'Bố')
INSERT [dbo].[ThânNhân] ([MaBN],[Họ],[Tên],[DịaChỉ],[GiớiTính],[MốiQuanHệ]) VALUES (N'BN002', N'Bùi Ngọc', N'Anh', N'Hà Nội', N'Nữ', N'Mẹ')
INSERT [dbo].[ThânNhân] ([MaBN],[Họ],[Tên],[DịaChỉ],[GiớiTính],[MốiQuanHệ]) VALUES (N'BN003', N'Đỗ Thảo', N'Linh', N'Thanh Hóa', N'Nữ', N'Vợ')
INSERT [dbo].[ThânNhân] ([MaBN],[Họ],[Tên],[DịaChỉ],[GiớiTính],[MốiQuanHệ]) VALUES (N'BN004', N'Đỗ Huy', N'Long', N'Ninh Bình', N'Nam', N'Chồng')
INSERT [dbo].[ThânNhân] ([MaBN],[Họ],[Tên],[DịaChỉ],[GiớiTính],[MốiQuanHệ]) VALUES (N'BN005', N'Trần Minh', N'Hoàng', N'Phú Thọ', N'Nam', N'Con trai')
INSERT [dbo].[ThânNhân] ([MaBN],[Họ],[Tên],[DịaChỉ],[GiớiTính],[MốiQuanHệ]) VALUES (N'BN006', N'Vũ Đăng', N'Hưng', N'Hà Nội', N'Nam', N'Bố')
INSERT [dbo].[ThânNhân] ([MaBN],[Họ],[Tên],[DịaChỉ],[GiớiTính],[MốiQuanHệ]) VALUES (N'BN007', N'Đỗ Phi', N'Hùng', N'Nam Định', N'Nam', N'Mẹ')
INSERT [dbo].[ThânNhân] ([MaBN],[Họ],[Tên],[DịaChỉ],[GiớiTính],[MốiQuanHệ]) VALUES (N'BN008', N'BÙi Văn', N'Thi', N'Hà Nội', N'Nam', N'Con gái')
INSERT [dbo].[ThânNhân] ([MaBN],[Họ],[Tên],[DịaChỉ],[GiớiTính],[MốiQuanHệ]) VALUES (N'BN009', N'Vũ Hải', N'Dương', N'Hà Nội', N'Nam', N'Bố')
INSERT [dbo].[ThânNhân] ([MaBN],[Họ],[Tên],[DịaChỉ],[GiớiTính],[MốiQuanHệ]) VALUES (N'BN010', N'Mai Văn', N'Hùng', N'Hà Tĩnh', N'Nam', N'Bố')

INSERT [dbo].[DịchVụ]([MaDV],[TênDịchVụ],[Giá]) VALUES (N'DV001', N'Khám bệnh', N'100000')
INSERT [dbo].[DịchVụ]([MaDV],[TênDịchVụ],[Giá]) VALUES (N'DV002', N'Xét nghiệm máu', N'100000')
INSERT [dbo].[DịchVụ]([MaDV],[TênDịchVụ],[Giá]) VALUES (N'DV003', N'Chụp X-quang', N'150000')
INSERT [dbo].[DịchVụ]([MaDV],[TênDịchVụ],[Giá]) VALUES (N'DV004', N'Siêu âm', N'100000')

INSERT [dbo].[HóaĐơn] ([MaHD],[MaBN],[NgàyHạn],[TổngTiền]) VALUES (N'HD001', N'BN001',CAST(N'2024-05-06T00:00:00.000' AS DateTime, N'200000')
INSERT [dbo].[HóaĐơn] ([MaHD],[MaBN],[NgàyHạn],[TổngTiền]) VALUES (N'HD002', N'BN005',CAST(N'2024-07-06T00:00:00.000' AS DateTime, N'345000')
INSERT [dbo].[HóaĐơn] ([MaHD],[MaBN],[NgàyHạn],[TổngTiền]) VALUES (N'HD003', N'BN010',CAST(N'2024-04-26T00:00:00.000' AS DateTime, N'150000')

INSERT [dbo].[ChiTiếtHóaĐơn]([MaHD],[TiềnKhám],[MaDV],[MaT]) VALUES (N'HD001', N'100000', N'DV001', N'T001')
INSERT [dbo].[ChiTiếtHóaĐơn]([MaHD],[TiềnKhám],[MaDV],[MaT]) VALUES (N'HD001', N'200000', N'DV002', N'T002')
INSERT [dbo].[ChiTiếtHóaĐơn]([MaHD],[TiềnKhám],[MaDV],[MaT]) VALUES (N'HD002', N'150000', N'DV003', N'T001')
INSERT [dbo].[ChiTiếtHóaĐơn]([MaHD],[TiềnKhám],[MaDV],[MaT]) VALUES (N'HD002', N'100000', N'DV004', N'T003')

INSERT [dbo].[PhiếuNhậpViện] ([MaPNV], [NgàyNhậpViện],[MaP] ) VALUES (N'PN201', CAST(N'2024-03-26T00:00:00.000' AS DateTime, N'P05E')
INSERT [dbo].[PhiếuNhậpViện] ([MaPNV], [NgàyNhậpViện],[MaP] ) VALUES (N'PN303', CAST(N'2024-03-20T00:00:00.000' AS DateTime, N'P05D')
INSERT [dbo].[PhiếuNhậpViện] ([MaPNV], [NgàyNhậpViện],[MaP] ) VALUES (N'PN408', CAST(N'2023-11-15T00:00:00.000' AS DateTime, N'P03G')

INSERT [dbo].[HồSơBệnhÁn] ([MaHS], [MaP], [MaPNV], [MaBN],[ChuanDoan],[PhươngPhápDiềuTrị]) VALUES (N'HS001', N'P05E', N'PN201', N'BN004', N'Nhiễm COVID-19', N'Uống thuốc và cách ly')
INSERT [dbo].[HồSơBệnhÁn] ([MaHS], [MaP], [MaPNV], [MaBN],[ChuanDoan],[PhươngPhápDiềuTrị]) VALUES (N'HS002', N'P05D', N'PN303', N'BN005', N'Thiếu máu nặng', N'Truyền máu')
INSERT [dbo].[HồSơBệnhÁn] ([MaHS], [MaP], [MaPNV], [MaBN],[ChuanDoan],[PhươngPhápDiềuTrị]) VALUES (N'HS003', N'P03G', N'PN408', N'BN009', N'Viêm da cơ địa', N'Uống thuốc và bôi thuốc')

INSERT [dbo].[PhiếuXuấtViện] ([MaPXV],[NgàyXuấtViện],[MaHS]) VALUES (N'PX201',  CAST(N'2024-05-06T00:00:00.000' AS DateTime, N'HS001')
INSERT [dbo].[PhiếuXuấtViện] ([MaPXV],[NgàyXuấtViện],[MaHS]) VALUES (N'PX303',  CAST(N'2024-04-06T00:00:00.000' AS DateTime, N'HS002')
INSERT [dbo].[PhiếuXuấtViện] ([MaPXV],[NgàyXuấtViện],[MaHS]) VALUES (N'PX408',  CAST(N'2024-04-06T00:00:00.000' AS DateTime, N'HS003')

INSERT [dbo].[ĐơnThuốc] ([MaDT], [MaBS], [MaHS],[NgàyKêĐơn],[GiáĐơnThuốc]) VALUES (N'', N'', N'', N'', N'')

INSERT [dbo].[Thuốc] ([MaT],[MaDT],[TênThuốc],[HDSD],[LiềuLượng],[Giá]) VALUES (N'', N'', N'', N'', N'', N'')



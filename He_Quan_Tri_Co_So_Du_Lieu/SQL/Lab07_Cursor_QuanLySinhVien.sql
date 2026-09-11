/* =========================================================
   LAB 7 - SỬ DỤNG CON TRỎ CURSOR TRONG SQL SERVER
   Database: QuanLySinhVien
   Ghi chú:
   - Chạy từng phần để dễ chụp ảnh kết quả.
   - Không chạy lại phần INSERT nếu dữ liệu đã có sẵn.
   ========================================================= */


/* =========================================================
   PHẦN 0. KIỂM TRA DỮ LIỆU BAN ĐẦU
   Mục đích: Kiểm tra 3 bảng SinhVien, MonHoc, KetQua
   ========================================================= */

USE QuanLySinhVien;
GO

SELECT * FROM SinhVien;
SELECT * FROM MonHoc;
SELECT * FROM KetQua;
GO



/* =========================================================
   PHẦN 1 - BÀI 1
   Sử dụng con trỏ để tính và in điểm trung bình của mỗi sinh viên
   Kết quả xem ở tab Messages
   ========================================================= */

USE QuanLySinhVien;
GO

DECLARE @MASV CHAR(3);
DECLARE @DiemTrungBinh FLOAT;

-- Khai báo cursor để duyệt từng sinh viên
DECLARE SinhVien_Cursor CURSOR FOR
SELECT MASV
FROM SinhVien;

-- Mở cursor
OPEN SinhVien_Cursor;

-- Lấy sinh viên đầu tiên
FETCH NEXT FROM SinhVien_Cursor INTO @MASV;

-- Duyệt từng sinh viên
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Tính điểm trung bình của sinh viên hiện tại
    SELECT @DiemTrungBinh = AVG(DIEM)
    FROM KetQua
    WHERE MASV = @MASV;

    -- In kết quả ra màn hình Messages
    PRINT N'Sinh viên ' + @MASV
        + N' có điểm trung bình là: '
        + CAST(@DiemTrungBinh AS NVARCHAR(20));

    -- Lấy sinh viên tiếp theo
    FETCH NEXT FROM SinhVien_Cursor INTO @MASV;
END;

-- Đóng và giải phóng cursor
CLOSE SinhVien_Cursor;
DEALLOCATE SinhVien_Cursor;
GO



/* =========================================================
   PHẦN 1 - BÀI 2
   Sử dụng con trỏ để cập nhật học bổng cho sinh viên
   Quy tắc:
   - ĐTB >= 8.0: học bổng 3000000
   - 6.5 <= ĐTB < 8.0: học bổng 1500000
   - ĐTB < 6.5: học bổng 0
   ========================================================= */

USE QuanLySinhVien;
GO

DECLARE @MASV CHAR(3);
DECLARE @DiemTrungBinh FLOAT;

-- Khai báo cursor duyệt danh sách sinh viên
DECLARE SinhVien_Cursor CURSOR FOR
SELECT MASV
FROM SinhVien;

-- Mở cursor
OPEN SinhVien_Cursor;

-- Lấy sinh viên đầu tiên
FETCH NEXT FROM SinhVien_Cursor INTO @MASV;

-- Duyệt từng sinh viên
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Tính điểm trung bình
    SELECT @DiemTrungBinh = AVG(DIEM)
    FROM KetQua
    WHERE MASV = @MASV;

    -- Cập nhật học bổng theo điểm trung bình
    IF @DiemTrungBinh >= 8.0
    BEGIN
        UPDATE SinhVien
        SET HOCBONG = 3000000
        WHERE MASV = @MASV;
    END
    ELSE IF @DiemTrungBinh >= 6.5
    BEGIN
        UPDATE SinhVien
        SET HOCBONG = 1500000
        WHERE MASV = @MASV;
    END
    ELSE
    BEGIN
        UPDATE SinhVien
        SET HOCBONG = 0
        WHERE MASV = @MASV;
    END;

    -- Lấy sinh viên tiếp theo
    FETCH NEXT FROM SinhVien_Cursor INTO @MASV;
END;

-- Đóng và giải phóng cursor
CLOSE SinhVien_Cursor;
DEALLOCATE SinhVien_Cursor;
GO

-- Kiểm tra kết quả sau khi cập nhật học bổng
SELECT * FROM SinhVien;
GO



/* =========================================================
   PHẦN 2 - CÂU 1
   Duyệt cursor và hiển thị danh sách sinh viên gồm:
   - Mã sinh viên
   - Họ tên sinh viên
   - Mã khoa
   - Tổng số môn thi
   Kết quả xem ở tab Messages
   ========================================================= */

USE QuanLySinhVien;
GO

DECLARE @MASV CHAR(3);
DECLARE @HOTEN NVARCHAR(100);
DECLARE @MAKHOA CHAR(10);
DECLARE @TongSoMonThi INT;

-- Khai báo cursor lấy thông tin sinh viên
DECLARE SV_Cursor CURSOR FOR
SELECT MASV, HOTEN, MAKHOA
FROM SinhVien;

-- Mở cursor
OPEN SV_Cursor;

-- Lấy sinh viên đầu tiên
FETCH NEXT FROM SV_Cursor INTO @MASV, @HOTEN, @MAKHOA;

-- Duyệt từng sinh viên
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Đếm tổng số môn sinh viên đã thi
    SELECT @TongSoMonThi = COUNT(*)
    FROM KetQua
    WHERE MASV = @MASV;

    -- In kết quả
    PRINT N'Mã SV: ' + @MASV
        + N' | Họ tên: ' + @HOTEN
        + N' | Mã khoa: ' + @MAKHOA
        + N' | Tổng số môn thi: ' + CAST(@TongSoMonThi AS NVARCHAR(10));

    -- Lấy sinh viên tiếp theo
    FETCH NEXT FROM SV_Cursor INTO @MASV, @HOTEN, @MAKHOA;
END;

-- Đóng và giải phóng cursor
CLOSE SV_Cursor;
DEALLOCATE SV_Cursor;
GO



/* =========================================================
   PHẦN 2 - CÂU 2
   Duyệt cursor và hiển thị danh sách môn học có thêm cột Ghi chú
   Quy tắc:
   - Nếu đã có sinh viên thi: "Đã có xxx SV thi"
   - Nếu chưa có sinh viên thi: "Chưa có SV thi"
   Kết quả xem ở tab Messages
   ========================================================= */

USE QuanLySinhVien;
GO

DECLARE @MAMH CHAR(5);
DECLARE @TENMH NVARCHAR(100);
DECLARE @SoSVThi INT;
DECLARE @GhiChu NVARCHAR(100);

-- Khai báo cursor lấy danh sách môn học
DECLARE MH_Cursor CURSOR FOR
SELECT MAMH, TENMH
FROM MonHoc;

-- Mở cursor
OPEN MH_Cursor;

-- Lấy môn học đầu tiên
FETCH NEXT FROM MH_Cursor INTO @MAMH, @TENMH;

-- Duyệt từng môn học
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Đếm số sinh viên đã thi môn hiện tại
    SELECT @SoSVThi = COUNT(DISTINCT MASV)
    FROM KetQua
    WHERE MAMH = @MAMH;

    -- Tạo nội dung ghi chú
    IF @SoSVThi > 0
    BEGIN
        SET @GhiChu = N'Đã có ' + CAST(@SoSVThi AS NVARCHAR(10)) + N' SV thi';
    END
    ELSE
    BEGIN
        SET @GhiChu = N'Chưa có SV thi';
    END;

    -- In kết quả
    PRINT N'Mã môn: ' + @MAMH
        + N' | Tên môn: ' + @TENMH
        + N' | Ghi chú: ' + @GhiChu;

    -- Lấy môn học tiếp theo
    FETCH NEXT FROM MH_Cursor INTO @MAMH, @TENMH;
END;

-- Đóng và giải phóng cursor
CLOSE MH_Cursor;
DEALLOCATE MH_Cursor;
GO



/* =========================================================
   PHẦN 2 - CÂU 3
   Duyệt cursor và giảm học bổng của sinh viên theo điểm trung bình
   Quy tắc:
   - Không giảm nếu ĐTB >= 8.5
   - Giảm 5% nếu 7.5 <= ĐTB < 8.5
   - Giảm 10% nếu 7 <= ĐTB < 7.5
   - Nếu ĐTB < 7 thì không xử lý vì đề không yêu cầu
   ========================================================= */

USE QuanLySinhVien;
GO

DECLARE @MASV CHAR(3);
DECLARE @DiemTrungBinh FLOAT;

-- Khai báo cursor duyệt sinh viên
DECLARE HB_Cursor CURSOR FOR
SELECT MASV
FROM SinhVien;

-- Mở cursor
OPEN HB_Cursor;

-- Lấy sinh viên đầu tiên
FETCH NEXT FROM HB_Cursor INTO @MASV;

-- Duyệt từng sinh viên
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Tính điểm trung bình của sinh viên hiện tại
    SELECT @DiemTrungBinh = AVG(DIEM)
    FROM KetQua
    WHERE MASV = @MASV;

    -- Không giảm học bổng nếu điểm trung bình >= 8.5
    IF @DiemTrungBinh >= 8.5
    BEGIN
        UPDATE SinhVien
        SET HOCBONG = HOCBONG
        WHERE MASV = @MASV;
    END
    -- Giảm 5% nếu 7.5 <= ĐTB < 8.5
    ELSE IF @DiemTrungBinh >= 7.5
    BEGIN
        UPDATE SinhVien
        SET HOCBONG = HOCBONG * 0.95
        WHERE MASV = @MASV;
    END
    -- Giảm 10% nếu 7 <= ĐTB < 7.5
    ELSE IF @DiemTrungBinh >= 7.0
    BEGIN
        UPDATE SinhVien
        SET HOCBONG = HOCBONG * 0.90
        WHERE MASV = @MASV;
    END;

    -- Lấy sinh viên tiếp theo
    FETCH NEXT FROM HB_Cursor INTO @MASV;
END;

-- Đóng và giải phóng cursor
CLOSE HB_Cursor;
DEALLOCATE HB_Cursor;
GO

-- Kiểm tra kết quả học bổng sau khi giảm
SELECT
    MASV,
    HOTEN,
    MAKHOA,
    HOCBONG
FROM SinhVien;
GO

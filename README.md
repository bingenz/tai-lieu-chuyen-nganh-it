# Tài liệu chuyên ngành IT

Kho lưu trữ bài giảng, bài thực hành, mã nguồn và tài liệu ôn tập cho các môn thuộc ngành Công nghệ thông tin.

## Danh mục môn học

| Thư mục | Môn học | Cách tổ chức chính |
|---|---|---|
| `Co_So_Du_Lieu` | Cơ sở dữ liệu | `Bai_Giang`, `Thuc_Hanh`, `SQL`, `Huong_Dan`, `Tham_Khao` |
| `Co_So_Lap_Trinh_Java` | Cơ sở lập trình Java | Giáo trình và bài tập |
| `He_Dieu_Hanh` | Hệ điều hành | `Bai_Giang`, `Thuc_Hanh`, `On_Tap` |
| `He_Quan_Tri_Co_So_Du_Lieu` | Hệ quản trị cơ sở dữ liệu | `Bai_Giang`, `Thuc_Hanh`, `SQL` |
| `Kien_Truc_May_Tinh` | Kiến trúc máy tính | Bài lab, trắc nghiệm và video hướng dẫn |
| `Ky_Thuat_Lap_Trinh_Java` | Kỹ thuật lập trình Java | Bài giảng và bài lab |
| `Thiet_Ke_Web` | Thiết kế Web | `Bai_Giang`, `Thuc_Hanh` |

## Quy ước sắp xếp tài liệu

- Mỗi môn dùng một thư mục riêng, đặt tên tiếng Việt không dấu và nối từ bằng dấu gạch dưới.
- Khi số lượng tài liệu đủ lớn, phân loại vào các thư mục: `Bai_Giang`, `Thuc_Hanh`, `On_Tap`, `SQL`, `Huong_Dan` hoặc `Tham_Khao`.
- Tên file phải mô tả được loại tài liệu, số chương/bài nếu có và chủ đề chính; không dùng tên chung chung như `file1`, `tailieu-moi` hoặc `final`.
- Tên file không dùng dấu tiếng Việt, không có khoảng trắng và giữ đúng phần mở rộng.
- Không commit đồng thời file nén và các bản đã giải nén của cùng một bộ tài liệu. Ưu tiên file đã giải nén, được phân loại riêng.
- Trước khi thêm file phải kiểm tra trùng lặp bằng SHA-256. Nếu hai file khác hash nhưng nội dung tương đương, chỉ giữ bản rõ ràng, đầy đủ và dễ sử dụng hơn; chỉ giữ cả hai khi chúng thực sự là các phiên bản khác nhau và tên file thể hiện rõ sự khác biệt.
- Không đưa mật khẩu, token, dữ liệu cá nhân nhạy cảm, file tạm hoặc file sinh tự động không cần thiết vào repository.

## Quy định bắt buộc dành cho Agent

Mọi Agent tự động thêm hoặc push tài liệu phải đọc và tuân thủ [`AGENTS.md`](AGENTS.md). Tối thiểu phải thực hiện đủ các bước sau:

1. Đọc nội dung hoặc metadata để xác định đúng môn học; không phân loại chỉ dựa vào tên file.
2. Kiểm tra cấu trúc hiện có và đặt tên nhất quán với repository.
3. Kiểm tra trùng hash và trùng nội dung trước khi sao chép.
4. Giải nén, phân loại tài liệu; không lưu thêm vỏ nén gây trùng lặp.
5. Chỉ stage các thay đổi thuộc nhiệm vụ, kiểm tra kích thước và dữ liệu nhạy cảm.
6. Cập nhật README khi thêm môn hoặc thay đổi cấu trúc thư mục.
7. Kiểm tra lại `git status`, nội dung commit và trạng thái remote trước khi push.
8. Không force-push, không xóa hay ghi đè tài liệu hiện có nếu chưa được yêu cầu rõ ràng.

## Contact

<p>
  <a href="https://instagram.com/bingenz_ig">Instagram</a> |
  <a href="https://www.tiktok.com/@bingenz_">TikTok</a> |
  <a href="https://bingenz.com/">Website</a>
</p>

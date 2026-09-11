# AGENTS.md

## Phạm vi

Các quy định trong file này áp dụng cho toàn bộ repository. Mọi Agent tạo, đổi tên, di chuyển, commit hoặc push tài liệu đều phải tuân thủ.

## Nguyên tắc chung

1. Bảo toàn tài liệu hiện có và lịch sử Git.
2. Không đoán môn học hoặc nội dung từ tên file. Phải kiểm tra trực tiếp nội dung, tiêu đề, metadata hoặc mã nguồn.
3. Không tự sửa nội dung học thuật của tài liệu nguồn. Việc chuẩn hóa chỉ áp dụng cho tên file và vị trí lưu, trừ khi nhiệm vụ yêu cầu sửa nội dung.
4. Không xóa, thay thế hoặc ghi đè file hiện có nếu chưa chứng minh đó là bản trùng và chưa có yêu cầu phù hợp.
5. Không commit thông tin đăng nhập, token, khóa API, dữ liệu cá nhân nhạy cảm, file tạm, cache hoặc output không cần thiết.

## Cấu trúc thư mục

- Tên thư mục môn học: tiếng Việt không dấu, dùng dấu gạch dưới, ví dụ `He_Dieu_Hanh`.
- Ưu tiên các nhóm chuẩn sau khi phù hợp:
  - `Bai_Giang`: giáo trình, slide và bài giảng lý thuyết.
  - `Thuc_Hanh`: đề bài lab, bài tập và hướng dẫn thực hành.
  - `On_Tap`: đề thi, trắc nghiệm và ngân hàng câu hỏi.
  - `SQL`: script cơ sở dữ liệu.
  - `Huong_Dan`: tài liệu hướng dẫn bổ trợ.
  - `Tham_Khao`: sách và tài liệu tham khảo ngoài chương trình chính.
- Không tạo thêm tầng thư mục nếu chỉ có một file và việc phân tầng không làm cấu trúc rõ hơn.

## Quy tắc đặt tên

- Dùng tên không dấu, không khoảng trắng, không ký tự trang trí.
- Tên phải nêu rõ loại tài liệu và chủ đề, ví dụ:
  - `BaiGiang05_QuanLyBoNho.pdf`
  - `Lab07_Cursor_QuanLySinhVien.sql`
  - `NganHangCauHoi_Chuong03_DieuPhoiTienTrinh.pdf`
- Giữ đúng phần mở rộng và không đổi định dạng chỉ để đổi tên.
- Nếu số bài ghi trong tên gốc khác số bài bên trong tài liệu, ưu tiên số bài được ghi trong nội dung và xác minh trước khi đổi tên.
- Khi giữ nhiều phiên bản có nội dung thực sự khác nhau, tên phải chỉ rõ khác biệt như `TracNghiemGoc`, `NganHangCauHoi`, `CoHuongDan` hoặc năm phát hành.

## Kiểm tra trùng lặp

Trước khi thêm tài liệu, Agent bắt buộc phải:

1. Lập danh sách file mới và file đang có trong repository.
2. So sánh SHA-256 để phát hiện file trùng tuyệt đối, kể cả khi tên khác nhau.
3. Với file khác hash nhưng cùng tiêu đề/chương, kiểm tra nội dung để phát hiện bản scan, bản xuất lại hoặc bản đổi tên của cùng một tài liệu.
4. Chỉ giữ một bản nếu nội dung tương đương; ưu tiên bản đầy đủ, dễ đọc, có thể tìm kiếm văn bản và dung lượng hợp lý.
5. Chỉ giữ nhiều bản khi nội dung hoặc công dụng khác nhau; đặt tên để người đọc phân biệt được ngay.
6. Với `.zip`, `.rar` hoặc gói nén tương tự: giải nén an toàn, kiểm tra file con, phân loại file con và không commit cả vỏ nén lẫn các file đã giải nén.

## Quy trình Git bắt buộc

1. Đọc `README.md`, `AGENTS.md` và mọi `AGENTS.md` gần thư mục đích trước khi sửa.
2. Kiểm tra nhánh, trạng thái working tree và remote; đồng bộ bằng phương thức không làm mất lịch sử.
3. Không làm thay đổi hoặc xóa các chỉnh sửa không thuộc nhiệm vụ.
4. Sau khi sắp xếp file, kiểm tra:
   - số lượng và đường dẫn file;
   - file rỗng hoặc hỏng;
   - trùng SHA-256;
   - tên file sai quy ước;
   - file vượt giới hạn của GitHub;
   - dữ liệu nhạy cảm;
   - kết quả `git diff --check`.
5. Cập nhật `README.md` nếu thêm môn học, đổi cấu trúc hoặc thay đổi quy ước.
6. Chỉ stage các file thuộc nhiệm vụ và xem lại danh sách staged trước khi commit.
7. Commit message phải mô tả đúng thay đổi, không dùng nội dung chung chung như `update` hoặc `files`.
8. Kiểm tra remote một lần nữa trước khi push. Nếu remote đã thay đổi, tích hợp an toàn rồi kiểm tra lại.
9. Không dùng force-push, không rewrite lịch sử và không bỏ qua hook kiểm tra.
10. Sau khi push, xác nhận commit đã xuất hiện trên đúng nhánh remote và báo cáo số file/môn đã thêm.

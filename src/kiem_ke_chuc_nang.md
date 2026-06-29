# Trang Kiểm kê tài sản

Trang quản lý kiểm kê thiết bị định kỳ theo quý. Tạo phiếu kiểm kê mới (Superadmin/Admin) với tên đợt kiểm, ngày kiểm, phòng ban, quý/năm. Hệ thống tự động lấy danh sách thiết bị đang quản lý thành chi tiết kiểm kê.

Quy trình: **Bản nháp** → **Đang kiểm kê** → **Hoàn thành**. Khi xử lý thiết bị đầu tiên, phiếu tự động chuyển sang `in_progress`.

Kiểm tra thiết bị: Cập nhật trạng thái thực tế (Còn/Thiếu/Hỏng/Đã điều chuyển), nhập vị trí thực tế, ghi chú. Thiết bị thiếu/hỏng được ưu tiên hiển thị đầu danh sách. Progress bar hiển thị % kiểm tra.

Hoàn thành kiểm kê: Yêu cầu kiểm tra hết tất cả thiết bị. Tự động thống kê số liệu (tìm thấy, thiếu, hỏng, điều chuyển).

Báo cáo: Xuất biên bản PDF chi tiết. Lọc theo trạng thái, quý, tìm kiếm mã/tên phiếu. Phân quyền: Admin tạo/sửa/xóa, User chỉ xem.
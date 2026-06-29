# Chức năng trang Quản lý Sự cố

Trang quản lý báo cáo hư hỏng và sự cố thiết bị với đầy đủ chức năng theo dõi, xử lý và báo cáo.

## Thống kê tổng quan
Bốn thẻ KPI hiển thị: Tổng số, Mới, Đang xử lý, Đã giải quyết (tương ứng với các trạng thái open, in_progress, resolved)

## Quản lý sự cố

### Tạo báo cáo sự cố mới
- Chọn thiết bị từ danh sách thiết bị đang quản lý
- Nhập vấn đề (bắt buộc), mô tả chi tiết
- Chọn mức độ nghiêm trọng: Thấp, Trung bình, Cao, Khẩn cấp (Low/Medium/High/Critical)
- **Tự động cập nhật trạng thái thiết bị sang `broken`** khi báo cáo ở mức độ Critical hoặc High

### Cập nhật và xử lý sự cố
- Cập nhật trạng thái: Mở, Đang xử lý, Đã giải quyết, Đóng
- Gán kỹ thuật viên phụ trách (phân công)
- Nhập kết quả xử lý, chi phí sửa chữa
- **Tự động khôi phục trạng thái thiết bị sang `active`** khi đánh dấu resolved

### Chi tiết sự cố
- Xem thông tin thiết bị (mã, tên, phòng ban, loại)
- Xem vấn đề, mô tả chi tiết
- Xem người báo, thời gian, người phụ trách, mức độ
- Xem kết quả xử lý và thời gian hoàn thành

## Tìm kiếm & lọc
Thanh tìm kiếm theo tên thiết bị, vấn đề, người báo
Dropdown lọc theo trạng thái và mức độ

## Báo cáo PDF
Xuất biên bản sự cố chi tiết ra file PDF

## Phân quyền truy cập
- **Superadmin/Admin**: Tạo, cập nhật, xóa sự cố
- **User**: Xem danh sách, tạo báo cáo sự cố
- **Technician**: Xem danh sách, cập nhật trạng thái sự cố được phân công
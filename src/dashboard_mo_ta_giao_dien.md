# Mô tả giao diện trang Dashboard

## Tổng quan bố cục
Giao diện được thiết kế theo **layout sidebar-left + content-right** với tổng thể tối giản, tông màu tím-blue chủ đạo, mang phong cách hiện đại và chuyên nghiệp.

---

## 1. Sidebar trái (Dark navy #1e1e2d)
- **Logo**: Trường Đại học Trà Vinh (TVU-ITAM) ở trên cùng
- **Menu điều hướng** chia thành các nhóm:
  - **TỔNG QUAN**: Dashboard (đang active, nền tím sáng)
  - **QUẢN LÝ**: Thiết bị, Bảo trì, Sự cố, Điều chuyển, Thanh lý
  - **QUẢN TRỊ**: Người dùng, Lịch sử đăng nhập, Nhật ký hệ thống, Cài đặt, Phòng ban
- **User footer**: Avatar "HT" + tên "superadmin Quản trị viên cấp cao"

---

## 2. Header chính
- Tiêu đề "Dashboard" + mô tả phụ "Tổng quan hệ thống"
- **Statistics nhanh góc phải**:
  - TỔNG THIẾT BỊ: 86
  - ĐANG HOẠT ĐỘNG: 66
  - Bell icon thông báo (số 5)
  - Icon tải xuống
  - Icon đăng xuất

---

## 3. Banner chào mừng (Purple gradient)
- Nội dung: *"Chào buổi sáng, Quản trị viên hệ thống"*
- Ngày tháng: Thứ Ba, 23 tháng 6, 2026
- Nút **Xuất báo cáo** (icon file + chữ) ở góc phải

---

## 4. KPI Cards (5 thẻ thống kê)
Thiết kế glassmorphism với nền xanh nhạt, border mờ:

| Icon | Chỉ số | Label | Phụ |
|------|--------|-------|-----|
| 🖥️ Màu tím | **86** | TỔNG THIẾT BỊ | Tất cả tài sản CNTT |
| 📈 Màu tím | **66** | ĐANG HOẠT ĐỘNG | 77% tổng số |
| 🔧 Màu tím | **2** | ĐANG BẢO TRÌ | Cần kiểm tra |
| ⚠️ Màu cam | **5** | SỰ CỐ | Đang chờ xử lý |
| 📅 Màu tím | **8** | BẢO TRÌ ĐÃ LÊN LỊCH | Chờ thực hiện |

→ Nhấn mạnh trạng thái hoạt động của hệ thống qua màu cam cho sự cố.

---

## 5. Phân bố theo phòng ban (Bar Chart)
- **Tiêu đề**: Biểu đồ cột dọc với label trên mỗi cột
- **KCNTT**: 44 (cột cao nhất, tím đậm — gần bằng 44)
- **PCNTT**: 10
- **BGH, PHC**: 4 mỗi đơn vị
- **KKTCN**: 3
- **KKT, PDT**: 2 mỗi đơn vị
- **PKT, PKT2, PKHCN**: 1 mỗi đơn vị

---

## 6. Cơ cấu loại thiết bị (Bar Chart - ngang)
- **Máy tính để bàn**: 14
- **Máy tính xách tay (Server)**: 11
- **Thiết bị mạng**: 9
- **Màn hình**: 8
- **Máy in**: 8
- **Máy chiếu**: 7
- **UPS / Nguồn điện**: 7
- **Thiết bị lưu trữ**: 4
- **Thiết bị liên lạc**: 4
- **Thiết bị ngoại vi**: 3

---

## Đánh giá thiết kế
- **Typography**: Font sans-serif hiện đại, kích thước rõ ràng
- **Color System**: 60-30-10 (nền trắng/sidebar tối + tím làm chủ màu + cam làm accent)
- **Spacing**: Consistent padding 24-32px giữa các sections
- **Cards**: Border-radius 12-16px, shadow nhẹ tạo chiều sâu
- **Interactive**: Skeleton loading states thể hiện qua hình ảnh placeholder

Đây là dashboard quản trị hệ thống quản lý tài sản CNTT, tập trung vào metrics quan trọng: số lượng thiết bị, tình trạng hoạt động/triển khai/bảo trì, phân bố địa lý (phòng ban) và phân bố loại thiết bị trong tổ chức giáo dục.

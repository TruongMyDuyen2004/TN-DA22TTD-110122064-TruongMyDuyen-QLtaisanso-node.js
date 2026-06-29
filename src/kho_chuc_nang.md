# Trang Quản lý Kho

Trang quản lý kho bao gồm 4 tab: Tồn kho, Nhập kho, Xuất kho, Quản lý kho. Quản lý kho: thêm/sửa/xóa kho, mã tự sinh `WH{ số}`. Tồn kho: hiển thị thiết bị trạng thái `in_stock` nhóm theo kho, xuất PDF.

Nhập kho: tạo phiếu nhập (mã `NK{ số}`), chọn kho, ngày, nhà cung cấp, danh sách thiết bị ID. Thiết bị nhập cập nhật trạng thái thành `in_stock`.

Xuất kho: tạo phiếu xuất (mã `XK{ số}`), chọn kho, phòng ban, người nhận, thiết bị. Thiết bị xuất cập nhật trạng thái `active` và vị trí mới.

Phân quyền: Admin tạo/sửa/xóa phiếu; User chỉ xem danh sách.
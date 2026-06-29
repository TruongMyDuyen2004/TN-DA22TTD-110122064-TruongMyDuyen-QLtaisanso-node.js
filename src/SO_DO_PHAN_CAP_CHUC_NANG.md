# Sơ đồ phân cấp chức năng hệ thống TVU-ITAM

## Mô tả tổng quan

Hệ thống được thiết kế theo mô hình phân quyền rõ ràng, phân rã thành **bốn phân hệ lớn** tương ứng với bốn nhóm đối tượng tương tác: **Khách (Guest), Người dùng (User), Quản trị viên (Admin)** và **Quản trị hệ thống (SuperAdmin)**.

Hệ thống chính đóng vai trò là **hạt nhân trung tâm** điều phối và phân luồng dữ liệu, giúp chuyển tiếp chính xác các yêu cầu từ giao diện người dùng đến các cấu trúc xử lý nghiệp vụ cơ sở bên dưới.

---

## 1. Phân hệ Khách (Guest)

Đối tượng Khách là nhóm người dùng không cần đăng nhập, được hệ thống mở ra **cổng chức năng công khai duy nhất** trên giao diện tuyến đầu nhằm tối ưu hóa việc tra cứu thông tin tài sản nhanh chóng.

Luồng chức năng khởi đầu từ việc **quét mã QR** được gắn trên thiết bị thực tế, sử dụng camera của thiết bị di động để giải mã định danh duy nhất của tài sản. Khi mã hợp lệ, chức năng **tra cứu thông tin thiết bị công khai** sẽ hoạt động, truy vấn cơ sở dữ liệu và trả về các thông tin cốt lõi bao gồm tên thiết bị, mã số, loại, phòng ban quản lý và tình trạng hiện tại.

Cuối cùng, chức năng **xác nhận thông tin kiểm kê** cho phép Khách ghi nhận kết quả đối soát thực tế, góp phần nâng cao tính minh bạch và hiệu quả trong công tác kiểm kê tài sản định kỳ của nhà trường.

| Chức năng | Mô tả |
|-----------|-------|
| Quét mã QR thiết bị | Truy cập công khai không cần đăng nhập qua đường dẫn `/q/MA-THIET-BI` |
| Tra cứu thông tin công khai | Xem tên, mã số, loại, phòng ban, tình trạng thiết bị |
| Xác nhận thông tin kiểm kê | Ghi nhận kết quả đối soát thực tế trong phiên kiểm kê |

---

## 2. Phân hệ Người dùng (User)

Người dùng sau khi xác thực thành công, tài khoản được mở khóa **chuỗi chức năng cá nhân hóa** nhằm phục vụ nhu cầu tra cứu và tương tác cơ bản với hệ thống quản lý tài sản.

Người dùng có thể thực hiện **đăng nhập hệ thống** bằng thư điện tử và mật khẩu, sau đó truy cập vào **bảng điều khiển Dashboard tổng quan** để nắm bắt nhanh tình hình tài sản của đơn vị mình thông qua các chỉ số thống kê trực quan.

Quá trình tra cứu được điều hành bởi chức năng **xem danh sách thiết bị** với khả năng tìm kiếm theo từ khóa, lọc theo phòng ban hoặc tình trạng và sắp xếp theo nhiều tiêu chí. Khi chọn một thiết bị cụ thể, chức năng **xem chi tiết thiết bị** hiển thị đầy đủ thông số kỹ thuật, lịch sử bảo trì và mã QR đính kèm.

Trong quá trình sử dụng, nếu phát hiện thiết bị hư hỏng, Người dùng có quyền **gửi báo cáo hỏng** kèm mô tả lỗi và mức độ nghiêm trọng; hệ thống ghi nhận và tự động cập nhật trạng thái thiết bị thành "đang hỏng", đồng thời thông báo đến bộ phận bảo trì để xử lý kịp thời. Người dùng cũng có thể **theo dõi tiến độ xử lý** báo cáo của mình để cập nhật tình trạng khắc phục.

> **Phạm vi quyền hạn:** Người dùng chỉ được phép xem và báo cáo sự cố. Các chức năng quản trị như thêm/sửa/xóa thiết bị, quản lý bảo trì, điều chuyển tài sản, thanh lý, quản lý người dùng và cấu hình hệ thống được hệ thống chặn truy cập.

| Chức năng | Mô tả |
|-----------|-------|
| Đăng nhập hệ thống | Xác thực bằng email/username và mật khẩu |
| Dashboard tổng quan | Xem thống kê tài sản của phòng ban |
| Danh sách thiết bị | Tìm kiếm, lọc, sắp xếp thiết bị |
| Chi tiết thiết bị | Xem thông số, lịch sử bảo trì, mã QR |
| Gửi báo cáo hỏng | Báo cáo sự cố với mô tả và mức độ |
| Theo dõi tiến độ | Xem trạng thái xử lý sự cố của mình |

---

## 3. Phân hệ Quản trị viên (Admin)

Quản trị viên được phân quyền tiếp cận **hệ thống bảng điều khiển toàn diện** để quản lý kho tài sản, điều phối bảo trì và giám sát vận hành nền tảng.

Sau khi đăng nhập quản trị, chức năng đầu tiên là **xem Dashboard quản trị**, tự động tổng hợp dữ liệu để kết xuất các biểu đồ trực quan về tổng số thiết bị, tình trạng sử dụng, thiết bị đang bảo trì và giá trị tài sản, phục vụ việc đưa ra quyết định vận hành kịp thời.

Nhằm duy trì tính toàn vẹn của kho dữ liệu tài sản cốt lõi, chức năng **quản lý thiết bị** cho phép Quản trị viên can thiệp trực tiếp vào kho lưu trữ thông qua các tác vụ thêm thiết bị mới, sửa đổi thông tin, xóa thiết bị, **import danh sách từ Excel**, **export báo cáo ra Excel hoặc PDF**, và **in mã QR** gắn trên thiết bị thực tế.

Chức năng **quản lý bảo trì** đóng vai trò duy trì tuổi thọ thiết bị, cho phép Quản trị viên lập lịch bảo trì định kỳ, phân công kỹ thuật viên phụ trách, cập nhật tiến độ thực hiện và ghi nhận kết quả cùng chi phí sau khi hoàn thành.

Đối với các sự cố phát sinh, chức năng **quản lý sự cố** cho phép tiếp nhận báo cáo từ Người dùng, phân công xử lý, cập nhật tiến độ và đóng sự cố khi đã khắc phục xong.

Khi có nhu cầu luân chuyển tài sản giữa các phòng ban, chức năng **điều chuyển tài sản** hỗ trợ tạo yêu cầu điều chuyển, phê duyệt và tự động cập nhật phòng ban sở hữu mới trong cơ sở dữ liệu, đồng thời xuất biên bản bàn giao dạng PDF.

Chức năng **thanh lý tài sản** cho phép đề xuất thanh lý các thiết bị hết khấu hao, phê duyệt và cập nhật trạng thái thành "đã thanh lý".

Cuối cùng, chức năng **báo cáo thống kê** cung cấp cái nhìn toàn cảnh về tình trạng tài sản thông qua các biểu đồ và chỉ số, hỗ trợ xuất dữ liệu ra Excel hoặc PDF phục vụ công tác báo cáo định kỳ.

| Chức năng | Mô tả |
|-----------|-------|
| Dashboard quản trị | Biểu đồ tổng hợp tình trạng tài sản |
| Quản lý thiết bị | CRUD, Import/Export Excel, in mã QR, xuất PDF |
| Quản lý bảo trì | Lập lịch định kỳ/đột xuất, phân công, ghi nhận kết quả |
| Quản lý sự cố | Tiếp nhận, phân công, xử lý, đóng sự cố |
| Điều chuyển tài sản | Yêu cầu, phê duyệt, bàn giao, xuất biên bản PDF |
| Thanh lý tài sản | Đề xuất, kiểm tra, phê duyệt, cập nhật trạng thái |
| Báo cáo thống kê | Biểu đồ, chỉ số, xuất Excel/PDF |

---

## 4. Phân hệ Quản trị hệ thống (SuperAdmin)

Quản trị hệ thống (Super Admin) là nhóm đối tượng có **quyền hạn cao nhất**, kế thừa toàn bộ chức năng của Quản trị viên và được bổ sung thêm các chức năng quản trị cấp hệ thống.

Sau khi đăng nhập, Super Admin có thể thực hiện **quản lý người dùng** toàn hệ thống bao gồm thêm tài khoản mới, phân quyền vai trò (superadmin, admin, user), khóa hoặc mở khóa tài khoản và reset mật khẩu khi cần thiết.

Chức năng **quản lý phòng ban** cho phép thiết lập cơ cấu tổ chức của trường học, thêm và sửa các phòng ban, khoa, trung tâm làm cơ sở cho việc gán quyền sở hữu tài sản.

Chức năng **xem nhật ký hoạt động** ghi lại toàn bộ thao tác của người dùng trong hệ thống, phục vụ công tác giám sát, kiểm tra và truy vết khi xảy ra sự cố hoặc sai phạm.

Chức năng **cấu hình hệ thống** cho phép Super Admin điều chỉnh các tham số vận hành chung như thời gian phiên đăng nhập, cài đặt bảo mật, thông tin trường học, logo và các tham số cảnh báo bảo trì — đảm bảo chỉ người quản trị cao nhất mới có thể can thiệp vào cấu hình lõi của hệ thống.

| Chức năng | Mô tả |
|-----------|-------|
| Quản lý người dùng | Thêm/sửa/xóa tài khoản, phân quyền, khóa/mở khóa, reset mật khẩu |
| Quản lý phòng ban | Thêm/sửa phòng ban, khoa, trung tâm |
| Xem nhật ký hoạt động | Audit log, lịch sử đăng nhập, truy vết thao tác |
| Cấu hình hệ thống | Tham số vận hành, bảo mật, thông tin trường, logo, cảnh báo |

---

## Bảng phân quyền chức năng theo vai trò

| Chức năng | Khách | Người dùng | Quản trị viên | Quản trị hệ thống |
|-----------|:-----:|:----------:|:--------------:|:-----------------:|
| Quét mã QR | ✓ | ✓ | ✓ | ✓ |
| Tra cứu thiết bị công khai | ✓ | ✓ | ✓ | ✓ |
| Xác nhận kiểm kê | ✓ | ✓ | ✓ | ✓ |
| Đăng nhập | ✗ | ✓ | ✓ | ✓ |
| Xem Dashboard | ✗ | ✓ | ✓ | ✓ |
| Xem danh sách thiết bị | ✗ | ✓ | ✓ | ✓ |
| Xem chi tiết thiết bị | ✗ | ✓ | ✓ | ✓ |
| Gửi báo cáo hỏng | ✗ | ✓ | ✓ | ✓ |
| Theo dõi tiến độ xử lý | ✗ | ✓ | ✓ | ✓ |
| Quản lý thiết bị (CRUD) | ✗ | ✗ | ✓ | ✓ |
| Import/Export thiết bị | ✗ | ✗ | ✓ | ✓ |
| In mã QR | ✗ | ✗ | ✓ | ✓ |
| Quản lý bảo trì | ✗ | ✗ | ✓ | ✓ |
| Quản lý sự cố | ✗ | ✗ | ✓ | ✓ |
| Điều chuyển tài sản | ✗ | ✗ | ✓ | ✓ |
| Thanh lý tài sản | ✗ | ✗ | ✓ | ✓ |
| Báo cáo thống kê | ✗ | ✗ | ✓ | ✓ |
| Quản lý người dùng | ✗ | ✗ | ✗ | ✓ |
| Quản lý phòng ban | ✗ | ✗ | ✗ | ✓ |
| Xem nhật ký hoạt động | ✗ | ✗ | ✗ | ✓ |
| Cấu hình hệ thống | ✗ | ✗ | ✗ | ✓ |

---

## Kết luận

Mô hình phân quyền **4 tầng** này đảm bảo nguyên tắc **đặc quyền tối thiểu** (least privilege), trong đó mỗi tác nhân chỉ có quyền truy cập chức năng phù hợp với trách nhiệm công việc. Từ đó, hệ thống vận hành linh hoạt, bảo mật cao và dễ dàng mở rộng khi nhà trường có nhu cầu phát triển thêm các phân hệ chức năng mới trong tương lai.

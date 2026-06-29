CHƯƠNG 5. KẾT LUẬN VÀ HƯỚNG PHÁT TRIỂN

5.1. Kết luận

Đề tài "Thiết kế và xây dựng hệ thống quản lý tài sản số cho Đại học Trà Vinh" đã được thực hiện thành công với mục tiêu xây dựng một hệ thống quản lý tài sản công nghệ thông tin tập trung, hiện đại, thay thế phương pháp quản lý thủ công bằng các file Excel rời rạc trước đây. Sau quá trình nghiên cứu, phân tích, thiết kế và triển khai, đề tài đã đạt được những kết quả cụ thể như sau:

**Về mặt lý thuyết:**

Đề tài đã nghiên cứu và hệ thống hóa các kiến thức nền tảng về kiến trúc Client-Server 3 tầng, RESTful API, Node.js, Express.js, MySQL, JWT, QR Code, cùng các thư viện hỗ trợ như bcryptjs, exceljs, pdfkit, nodemailer, helmet, cors và morgan. Những kiến thức này không chỉ được trình bày một cách có hệ thống tại Chương 2 mà còn được vận dụng hiệu quả trong suốt quá trình xây dựng hệ thống. Việc lựa chọn các công nghệ mã nguồn mở phù hợp đã giúp giảm chi phí phát triển, tận dụng được cộng đồng hỗ trợ rộng lớn và đảm bảo khả năng mở rộng trong tương lai.

**Về mặt phân tích và thiết kế:**

Thông qua khảo sát thực tế tại các khoa, phòng ban và đơn vị trực thuộc Trường Đại học Trà Vinh, đề tài đã xác định được bảy nhóm hạn chế chính trong công tác quản lý tài sản hiện tại: dữ liệu phân tán, khó khăn trong kiểm kê, quản lý vòng đời tài sản chưa đầy đủ, thiếu cơ chế cảnh báo tự động, khó kiểm soát trách nhiệm sử dụng, báo cáo thủ công và nhu cầu cấp thiết về một hệ thống số hóa tập trung.

Từ những hạn chế đó, hệ thống TVU-ITAM đã được thiết kế với kiến trúc ba tầng (Presentation Layer, Application Layer, Data Layer) đảm bảo tính tách biệt, dễ bảo trì và mở rộng. Cơ sở dữ liệu được thiết kế với 12 bảng quan hệ (users, departments, device_categories, devices, maintenance_schedules, maintenance_logs, asset_transfers, disposals, incident_reports, audit_logs, system_settings, login_history) và 3 view tổng hợp (v_device_details, v_maintenance_details, v_dashboard_stats), sử dụng InnoDB Engine với các ràng buộc khóa ngoại và chỉ mục nhằm đảm bảo tính toàn vẹn dữ liệu và tối ưu hiệu suất truy vấn. Bốn tác nhân chính được xác định gồm Super Admin, Admin, User và Guest, với phạm vi chức năng được phân định rõ ràng thông qua sơ đồ use case chi tiết.

**Về mặt triển khai thực tế:**

Phân hệ Frontend được xây dựng dưới dạng Single Page Application thuần JavaScript, tổ chức theo Page-based Module Pattern với 15 trang tính năng. Hệ thống sử dụng Hash-based routing cho điều hướng, Fetch API với Interceptor cho giao tiếp Backend, localStorage cho quản lý trạng thái đăng nhập và Toast notification cho thông báo người dùng. Giao diện được thiết kế Responsive với CSS Custom Properties, CSS Grid và Flexbox, đảm bảo trải nghiệm nhất quán trên cả máy tính và thiết bị di động.

Phân hệ Backend được xây dựng trên nền tảng Node.js và Express.js với hơn 50 endpoint API được tổ chức theo mô hình MVC-inspired. Hệ thống tích hợp cơ chế xác thực JWT kết hợp RBAC ba cấp, Prepared Statements chống SQL Injection, mã hóa mật khẩu bằng bcrypt, audit logging cho mọi thao tác thay đổi dữ liệu và các middleware bảo mật như Helmet, CORS.

Các dịch vụ nền tảng bao gồm cron job nhắc nhở bảo trì qua email (chạy hàng ngày lúc 8:00 sáng), dịch vụ tính khấu hao theo phương pháp số dư giảm dần, dịch vụ sinh 7 loại báo cáo PDF với letterhead trường, dịch vụ xuất/nhập Excel thông minh hỗ trợ ánh xạ cột tiếng Việt và tiếng Anh, dịch vụ gửi email qua SMTP Gmail và dịch vụ tự động phát hiện URL công khai cho mã QR qua cơ chế bốn tầng.

**Về mặt kiểm thử và đánh giá:**

Hệ thống đã trải qua quy trình kiểm thử đa tầng bao gồm kiểm thử đơn vị (Auth Logic, Depreciation Service), kiểm thử tích hợp (API-Database-Security), kiểm thử chức năng (18 kịch bản), kiểm thử hiệu năng (Apache JMeter với 50 người dùng đồng thời, ~200 requests/giây, tỷ lệ lỗi 0%) và kiểm thử bảo mật (SQL Injection, XSS, truy cập trái phép). Kết quả cho thấy hệ thống hoạt động ổn định, đáp ứng 100% (15/15) các mục tiêu chức năng đề ra.

**Đánh giá tổng quát:**

Hệ thống TVU-ITAM là một giải pháp quản lý tài sản số hoàn chỉnh, có khả năng quản lý vòng đời thiết bị từ nhập kho, phân bổ, bảo trì, điều chuyển đến thanh lý. Hệ thống góp phần số hóa quy trình quản lý, giảm khối lượng công việc thủ công, nâng cao tính chính xác và minh bạch, đồng thời hỗ trợ nhà quản lý đưa ra quyết định dựa trên dữ liệu thực tế. Đề tài đã khẳng định tính khả thi của việc ứng dụng công nghệ web hiện đại vào giải quyết bài toán quản lý tài sản thực tiễn tại Trường Đại học Trà Vinh, góp phần thúc đẩy quá trình chuyển đổi số trong công tác quản trị nhà trường.

5.2. Hướng phát triển

Mặc dù đã đạt được những kết quả nhất định, hệ thống vẫn còn một số hạn chế và có thể được cải tiến, mở rộng trong tương lai theo các hướng sau:

**5.2.1. Phát triển ứng dụng di động**

Hiện tại, hệ thống chỉ hoạt động trên nền tảng web, chưa có ứng dụng di động riêng. Trong tương lai, việc phát triển ứng dụng cho Android và iOS sẽ giúp người dùng tra cứu thông tin thiết bị, quét mã QR, thực hiện kiểm kê và nhận thông báo bảo trì mọi lúc mọi nơi mà không cần truy cập qua trình duyệt web. Ứng dụng di động cũng cho phép tận dụng tối đa camera và cảm biến của thiết bị để hỗ trợ các tác vụ như quét QR, chụp ảnh thiết bị và ghi nhận vị trí GPS phục vụ kiểm kê thực địa.

**5.2.2. Tích hợp công nghệ RFID**

QR Code hiện tại yêu cầu quét từng thiết bị một, chưa tối ưu cho kiểm kê số lượng lớn. Việc tích hợp công nghệ RFID (Radio Frequency Identification) sẽ cho phép quét hàng loạt thiết bị trong cùng một khu vực chỉ trong vài giây, giúp rút ngắn thời gian kiểm kê từ nhiều ngày xuống còn vài giờ. Mỗi thiết bị sẽ được gắn thẻ RFID, và cán bộ kiểm kê chỉ cần đi qua khu vực với đầu đọc RFID là hệ thống tự động ghi nhận danh sách thiết bị hiện có.

**5.2.3. Cảnh báo thông minh dựa trên dữ liệu lịch sử**

Hệ thống hiện tại chỉ cảnh báo bảo trì dựa trên lịch định kỳ cố định. Trong tương lai, có thể bổ sung mô hình học máy (Machine Learning) để phân tích dữ liệu lịch sử sự cố, tần suất hỏng hóc, điều kiện môi trường và thời gian sử dụng để dự đoán thời điểm thiết bị có nguy cơ hỏng cao. Điều này giúp chuyển từ bảo trì định kỳ sang bảo trì dự đoán (Predictive Maintenance), tối ưu chi phí và kéo dài tuổi thọ thiết bị.

**5.2.4. Mở rộng quản lý đa cơ sở**

Hiện tại, hệ thống mới chỉ thiết kế cho một cơ sở duy nhất. Trong tương lai, cần mở rộng hỗ trợ quản lý tài sản trên nhiều cơ sở của Trường Đại học Trà Vinh như cơ sở Vĩnh Long, Trà Vinh và các trung tâm liên kết đào tạo khác trên cùng một nền tảng thống nhất. Mỗi cơ sở sẽ có bộ dữ liệu riêng nhưng vẫn đảm bảo khả năng tổng hợp báo cáo toàn trường cho Ban lãnh đạo.

**5.2.5. Phát triển API mở và tích hợp hệ thống**

Xây dựng API mở (Open API) theo chuẩn RESTful cho phép các hệ thống khác của nhà trường tích hợp với TVU-ITAM. Cụ thể, có thể tích hợp với hệ thống quản lý nhân sự để đồng bộ thông tin người dùng và phòng ban, hệ thống quản lý đào tạo để theo dõi thiết bị phòng thực hành theo lịch học, và phần mềm kế toán để tự động cập nhật giá trị tài sản và khấu hao. Việc tích hợp này tạo thành một hệ sinh thái số đồng bộ, loại bỏ hoàn toàn tình trạng dữ liệu phân tán giữa các hệ thống.

**5.2.6. Nâng cấp kiến trúc và triển khai đám mây**

Kiến trúc Monolithic hiện tại phù hợp với quy mô hiện nay nhưng có thể gặp hạn chế khi số lượng người dùng và thiết bị gia tăng. Trong tương lai, hệ thống có thể được chuyển đổi sang kiến trúc microservices, trong đó mỗi module nghiệp vụ (thiết bị, bảo trì, điều chuyển, người dùng, báo cáo) là một dịch vụ độc lập có thể triển khai và mở rộng riêng biệt. Song song đó, việc triển khai hệ thống lên hạ tầng đám mây (AWS, Google Cloud hoặc Azure) sẽ đảm bảo tính sẵn sàng cao, khả năng chịu tải tốt và giảm chi phí vận hành, bảo trì hạ tầng.

**5.2.7. Bổ sung chức năng phân tích trực quan nâng cao**

Nâng cấp hệ thống báo cáo với các công cụ phân tích trực quan (Business Intelligence) như biểu đồ tương tác, bảng điều khiển tùy chỉnh theo vai trò, xuất báo cáo tự động theo lịch (hàng tuần, hàng tháng, hàng quý) và khả năng khoan xuống (drill-down) từ dữ liệu tổng quan đến chi tiết từng thiết bị. Điều này giúp Ban lãnh đạo nhà trường có cái nhìn sâu sắc hơn về tình hình sử dụng tài sản và hỗ trợ ra quyết định chiến lược.

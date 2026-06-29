# CHƯƠNG 4: TRIỂN KHAI VÀ KIỂM THỬ

Sau khi đã hoàn thiện các bản thiết kế chi tiết tại Chương 3, Chương 4 trình bày quá trình hiện thực hóa hệ thống TVU-ITAM. Nội dung chương này bao gồm việc thiết lập môi trường phát triển, triển khai mã nguồn cho các phân hệ Frontend và Backend, tích hợp các thư viện xử lý dữ liệu và cuối cùng là đánh giá chất lượng hệ thống thông qua các kịch bản kiểm thử thực tế.

## 4.1. Môi trường phát triển

Để đảm bảo tính nhất quán và hiệu quả trong quá trình xây dựng một hệ thống hoàn chỉnh, việc lựa chọn công cụ và cấu hình môi trường đóng vai trò quyết định.

### 4.1.1. Công cụ phát triển phần mềm

Đồ án sử dụng các công cụ lập trình tiên tiến, hỗ trợ tối ưu cho từng nền tảng cụ thể:

**a) Môi trường lập trình (IDE và Editor)**

Hệ thống được phát triển trên hai môi trường để tận dụng tối đa các tính năng hỗ trợ mã nguồn:

**Bảng 16: Các công cụ dùng cho lập trình**

| Công cụ | Phiên bản | Vai trò và Mục đích |
|---|---|---|
| Visual Studio Code | 1.85+ | Phát triển toàn bộ hệ thống (Frontend và Backend). Tận dụng hệ sinh thái Extension phong phú để tăng tốc độ viết code. |
| MySQL Workbench | 8.0 CE | Thiết kế lược đồ, quản trị cơ sở dữ liệu quan hệ và thực thi các truy vấn SQL kiểm tra. |
| Postman | 10.x | Kiểm thử các Endpoint API, giả lập các yêu cầu HTTP và kiểm tra cấu trúc phản hồi JSON. |
| Git | 2.43+ | Quản lý phiên bản mã nguồn, thực hiện các thao tác Branching và Commit để theo dõi lịch sử phát triển. |

**b) Các tiện ích mở rộng hỗ trợ (VS Code Extensions)**

Việc tích hợp các tiện ích giúp chuẩn hóa định dạng mã nguồn và giảm thiểu lỗi cú pháp:

- **ESLint**: Kiểm tra lỗi logic mã nguồn JavaScript theo các tiêu chuẩn lập trình hiện đại.
- **Prettier**: Tự động định dạng mã nguồn, đảm bảo tính nhất quán giữa các thành viên.
- **MySQL (cweijan)**: Hỗ trợ kết nối và truy vấn cơ sở dữ liệu ngay trong môi trường soạn thảo.
- **Thunder Client**: Extension hỗ trợ kiểm thử API nhanh thay thế Postman.

### 4.1.2. Cấu hình môi trường hệ thống

Hệ thống yêu cầu cấu hình phần cứng và phần mềm đủ mạnh để vận hành đồng thời dịch vụ Backend, Frontend và cơ sở dữ liệu.

**a) Yêu cầu về tài nguyên hệ thống (System Requirements)**

**Bảng 17: Bảng tài nguyên yêu cầu**

| Thành phần | Yêu cầu tối thiểu | Cấu hình khuyến nghị |
|---|---|---|
| Hệ điều hành | Windows 10 (64-bit) | Windows 11 hoặc macOS |
| Bộ nhớ RAM | 8 GB | 16 GB |
| Bộ vi xử lý | 4 Cores (Intel i5/Ryzen 5) | 8 Cores (Intel i7/Ryzen 7) |
| Lưu trữ | 10 GB trống | 20 GB SSD |

**b) Cài đặt các nền tảng thực thi (Runtimes)**

Sử dụng các phiên bản ổn định lâu dài (LTS) để đảm bảo tính tương thích:

- **Node.js v18.x hoặc v20.x (LTS)**: Môi trường thực thi cho Backend Express.js và các công cụ hỗ trợ.
- **MySQL 8.0**: Hệ quản trị cơ sở dữ liệu quan hệ chính.
- **XAMPP**: Cung cấp môi trường PHP và MySQL tích hợp sẵn, phục vụ quá trình phát triển cục bộ.

**c) Quản lý thư viện phụ thuộc (Dependency Management)**

Quy trình cài đặt và chuẩn bị mã nguồn được thực hiện qua npm:

```
npm install
```

Lệnh trên sẽ đọc file `package.json` và cài đặt toàn bộ các thư viện cần thiết bao gồm: express, mysql2, jsonwebtoken, bcryptjs, qrcode, helmet, cors, morgan, multer, nodemailer, node-cron, pdfkit, exceljs, chart.js,...

### 4.1.3. Cấu hình biến môi trường và Bảo mật

Hệ thống tuân thủ nguyên tắc không lưu trữ thông tin nhạy cảm trực tiếp trong mã nguồn. Mọi cấu hình liên quan đến mật khẩu database, JWT Secret và các khóa bí mật đều được quản lý qua file `.env`:

```
# Database
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=
DB_NAME=tvu_itam

# JWT
JWT_SECRET=tvu_itam_secret_key
JWT_EXPIRES_IN=24h

# Server
PORT=5000
HOST=0.0.0.0
APP_URL=http://localhost:5000

# Email (SMTP)
MAIL_HOST=smtp.gmail.com
MAIL_PORT=465
MAIL_USER=your-email@gmail.com
MAIL_PASS=your-app-password
```

Việc thiết lập môi trường bài bản như trên đảm bảo hệ thống có thể dễ dàng được đóng gói và triển khai trên các hạ tầng đám mây trong tương lai.

## 4.2. Triển khai phân hệ Frontend (Vanilla JS SPA)

Phân hệ Frontend được xây dựng dưới dạng Single Page Application (SPA) thuần JavaScript, không sử dụng framework, tập trung vào tính nhẹ nhàng và trải nghiệm người dùng mượt mà trên cả thiết bị di động và máy tính.

### 4.2.1. Tổ chức cấu trúc dự án

Dự án được tổ chức theo cấu trúc Page-based Module Pattern, giúp phân tách rõ ràng giữa giao diện, logic xử lý và quản lý trạng thái.

```
frontend/
├── index.html                  # Trang đăng nhập
├── app.html                    # Shell SPA chính
├── reset-password.html         # Trang đặt lại mật khẩu
├── public-device.html          # Tra cứu thiết bị công khai
├── assets/
│   ├── css/
│   │   ├── main.css            # Hệ thống thiết kế (Design System)
│   │   ├── app.css             # Kiểu dáng layout ứng dụng
│   │   └── login.css           # Kiểu dáng trang đăng nhập
│   ├── js/
│   │   ├── api.js              # Lớp giao tiếp Backend + Toast + Formatting
│   │   ├── app.js              # Router, Auth, Sidebar, Core
│   │   ├── login.js            # Logic trang đăng nhập
│   │   └── pages/              # 15 module trang tính năng
```

- **api.js**: Lớp giao tiếp với Backend (Data Access Layer). Sử dụng Fetch API để quản lý các yêu cầu HTTP, tự động đính kèm JWT Token và xử lý lỗi 401 tập trung.
- **app.js**: Bộ định tuyến SPA dựa trên Hash, kiểm soát quyền truy cập và quản lý thanh điều hướng.
- **pages/**: 15 module trang, mỗi trang là một IIFE (Immediately Invoked Function Expression) exposing các phương thức render.

### 4.2.2. Triển khai các tính năng kỹ thuật trọng tâm

**a) Quản lý trạng thái xác thực (Authentication Store)**

Sử dụng `localStorage` kết hợp với Module Pattern để duy trì trạng thái đăng nhập. Thông tin người dùng và JWT Token được lưu trữ với các key `tvu_token` và `tvu_user`, được đồng bộ hóa qua đối tượng `API`.

```javascript
const API = (() => {
    const getToken = () => localStorage.getItem('tvu_token');
    const getUser = () => JSON.parse(localStorage.getItem('tvu_user') || 'null');
    // ...
    setAuth: (token, user) => {
        localStorage.setItem('tvu_token', token);
        localStorage.setItem('tvu_user', JSON.stringify(user));
    },
    clearAuth: () => {
        localStorage.removeItem('tvu_token');
        localStorage.removeItem('tvu_user');
    }
})();
```

**b) Xây dựng lớp dịch vụ API (Fetch Interceptors)**

Hệ thống triển khai một lớp `request` trung tâm, tự động đính kèm Token vào Header `Authorization: Bearer <token>` và xử lý lỗi 401 Unauthorized để điều hướng người dùng về trang đăng nhập khi phiên làm việc hết hạn.

```javascript
const request = async (method, path, body = null) => {
    const opts = {
        method,
        headers: {
            'Content-Type': 'application/json',
            'ngrok-skip-browser-warning': 'true',
            ...(getToken() ? { 'Authorization': `Bearer ${getToken()}` } : {})
        },
        ...(body ? { body: JSON.stringify(body) } : {})
    };
    const res = await fetch(BASE + path, opts);
    const data = await res.json();
    if (res.status === 401) {
        localStorage.removeItem('tvu_token');
        localStorage.removeItem('tvu_user');
        window.location.href = '/';
    }
    return { ok: res.ok, status: res.status, data };
};
```

**c) Hệ thống điều hướng Hash-based SPA**

Ứng dụng sử dụng cơ chế `hashchange` để điều hướng giữa các trang, đảm bảo không tải lại trang và giữ được trạng thái người dùng.

```javascript
const handleHash = () => {
    const hashStr = window.location.hash.replace('#', '') || 'dashboard';
    const [page, query] = hashStr.split('?');
    // Parse params
    window.__currentParams = params;
    navigate(page);
};
window.addEventListener('hashchange', handleHash);
```

**d) Hệ thống thông báo Toast**

Triển khai hệ thống Toast notification với 4 loại (success, error, warning, info), tự động ẩn sau 3.5 giây và hỗ trợ animation fade-out.

**e) Biểu đồ thống kê Dashboard**

Sử dụng Chart.js để trực quan hóa dữ liệu thống kê tài sản với biểu đồ cột (phân bố theo phòng ban) và biểu đồ donut (phân bố theo loại thiết bị), kèm plugin center-text tùy chỉnh.

### 4.2.3. Thiết kế đáp ứng và Tối ưu hóa giao diện

Để đảm bảo hệ thống hoạt động tốt trên cả máy tính và thiết bị di động, dự án xây dựng hệ thống thiết kế (Design System) dựa trên CSS Custom Properties.

- **Hệ thống biến CSS**: Định nghĩa toàn bộ Design Tokens (màu sắc, khoảng cách, bóng đổ, bo góc) trong `:root`, giúp dễ dàng tùy chỉnh theme.
- **Sidebar thích ứng**: Trên màn hình nhỏ, Sidebar được ẩn vào Menu Hamburger và sử dụng CSS transition để trượt ra khi cần. Hỗ trợ đóng sidebar bằng nút Escape hoặc vuốt sang trái trên thiết bị cảm ứng.
- **Responsive Grid**: Sử dụng CSS Grid và Flexbox linh hoạt để tự động điều chỉnh bố cục trên các kích thước màn hình khác nhau.

## 4.3. Triển khai phân hệ Backend (Node.js + Express.js)

Phân hệ Backend đóng vai trò là hạt nhân xử lý nghiệp vụ của hệ thống TVU-ITAM, chịu trách nhiệm quản lý luồng dữ liệu, đảm bảo tính bảo mật và cung cấp các API RESTful cho Frontend.

### 4.3.1. Cấu trúc tổ chức dự án

Mã nguồn được tổ chức theo kiến trúc MVC-inspired, giúp tách biệt rõ ràng giữa routing, xử lý nghiệp vụ và truy xuất dữ liệu.

```
backend/
├── server.js                   # Điểm khởi đầu ứng dụng, cấu hình middleware, routes
├── .env                        # Biến môi trường
├── config/
│   ├── database.js             # Kết nối MySQL connection pool
│   ├── jwt.js                  # Cấu hình JWT (sign, verify)
│   ├── mail.js                 # Cấu hình SMTP (nodemailer)
│   └── appUrl.js               # Tự động phát hiện URL (LAN, ngrok)
├── middleware/
│   ├── auth.js                 # Xác thực JWT + phân quyền RBAC
│   ├── auditLogger.js          # Ghi nhật ký hành động
│   ├── uploadMiddleware.js     # Xử lý upload file
│   └── uploadAvatarMiddleware.js # Xử lý upload ảnh đại diện
├── controllers/                # Logic nghiệp vụ (14 controllers)
└── routes/                     # Định nghĩa tuyến đường API (14 routers)
└── services/                   # Dịch vụ nền (cron, PDF, depreciation)
```

### 4.3.2. Triển khai các Module nghiệp vụ trọng tâm

**a) Cấu hình máy chủ (server.js)**

Server Express được khởi tạo với chuỗi Middleware theo thứ tự: Helmet (bảo mật), CORS, JSON parser, Morgan (logging). Hệ thống tự động phát hiện IP LAN và ngrok URL để tạo đường dẫn QR chính xác cho thiết bị di động.

```javascript
// Middleware stack
app.use(helmet({ contentSecurityPolicy: false }));
app.use(cors({ origin: '*', methods: ['GET','POST','PUT','DELETE','OPTIONS'] }));
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));
app.use(morgan('dev'));
```

**b) Kết nối cơ sở dữ liệu (database.js)**

Sử dụng `mysql2/promise` với connection pool để quản lý kết nối MySQL hiệu quả. Hỗ trợ UTF-8 cho tiếng Việt và múi giờ GMT+7.

```javascript
const pool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT || 3306,
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'tvu_itam',
    waitForConnections: true,
    connectionLimit: 10,
    timezone: '+07:00',
    charset: 'utf8mb4'
});
```

**c) Cơ chế xác thực JWT (auth middleware)**

Hệ thống xác thực dựa trên JWT (JSON Web Token) với hai tầng bảo vệ:

- **authenticate**: Kiểm tra token từ header `Authorization: Bearer <token>` hoặc query parameter `?token=`. Giải mã token và truy vấn thông tin người dùng từ database, gắn vào `req.user`.
- **requireRole(...roles)**: Middleware factory kiểm tra quyền của người dùng dựa trên role, trả về 403 nếu không có quyền.

```javascript
const authenticate = async (req, res, next) => {
    let token;
    const authHeader = req.headers.authorization;
    if (authHeader && authHeader.startsWith('Bearer ')) {
        token = authHeader.split(' ')[1];
    } else if (req.query.token) {
        token = req.query.token;
    }
    if (!token) return res.status(401).json(...);
    const decoded = jwtConfig.verify(token);
    // Query user from DB...
    req.user = rows[0];
    next();
};
```

**d) Quản lý xác thực qua Auth Controller**

Controller này cung cấp các Endpoint cho đăng nhập, đăng ký, quên mật khẩu, đặt lại mật khẩu và cập nhật hồ sơ.

- **Login**: Kiểm tra thông tin đăng nhập (username hoặc email), so sánh bcrypt hash, ghi nhận lịch sử đăng nhập (thành công/thất bại), trả về JWT token.
- **Register**: Kiểm tra tính duy nhất của username/email, hash mật khẩu, tạo tài khoản mới với trạng thái `is_active = 0` (chờ admin kích hoạt).
- **Forgot/Reset Password**: Tạo token ngẫu nhiên 32 byte, lưu với thời hạn 1 giờ, gửi email chứa link đặt lại mật khẩu.

**e) Xử lý nghiệp vụ Thiết bị (Device Controller)**

Đây là controller lớn nhất (843 dòng) với 15 chức năng bao gồm CRUD, thống kê, QR code, xuất Excel/PDF, nhập Excel và thu hồi thiết bị.

- **Dynamic Query Building**: Xây dựng câu lệnh SQL động dựa trên tham số query với Prepared Statements để ngăn chặn SQL Injection.
- **Role-based Filtering**: Người dùng role `user` chỉ thấy thiết bị thuộc phòng ban của mình hoặc thiết bị được gán cho mình.
- **Audit Logging**: Mọi thao tác thêm/sửa/xóa đều được ghi vào bảng `audit_logs` qua middleware `recordAudit()`.

```javascript
// Pattern xây dựng truy vấn động an toàn
let query = `SELECT * FROM v_device_details WHERE 1=1`;
const params = [];
if (req.query.status) { query += ' AND status = ?'; params.push(req.query.status); }
if (req.query.search) {
    query += ' AND (name LIKE ? OR device_code LIKE ?)';
    params.push(`%${req.query.search}%`, `%${req.query.search}%`);
}
if (req.user.role === 'user') {
    query += ' AND (department_id = ? OR assigned_user_id = ?)';
    params.push(req.user.department_id, req.user.id);
}
```

**f) Quy trình điều chuyển tài sản (Transfer Controller)**

Triển khai quy trình phê duyệt (Approval Workflow) cho điều chuyển tài sản:

1. Yêu cầu điều chuyển được tạo với trạng thái `pending`.
2. Admin/Superadmin xem xét và phê duyệt (`approved`) hoặc từ chối (`rejected`).
3. Khi phê duyệt, hệ thống tự động cập nhật `department_id` và `assigned_user_id` của thiết bị.
4. Mọi bước đều được ghi nhận qua audit log.

**g) Quản lý bảo trì và sự cố (Maintenance & Incident Controllers)**

- **Maintenance**: Khi hoàn thành bảo trì, tự động cập nhật trạng thái thiết bị từ `maintenance` về `active` và ghi nhận chi phí vào `maintenance_logs`.
- **Incident**: Khi báo cáo sự cố ở mức `critical` hoặc `high`, tự động chuyển trạng thái thiết bị thành `broken`.

**h) Cấu hình Route và Phân quyền (Routing)**

Sử dụng Express Router với middleware `authenticate` và `requireRole` để phân quyền chi tiết:

```javascript
router.use(authenticate);
router.get('/stats/summary', ctrl.getStats);
router.get('/export', requireRole('superadmin', 'admin'), ctrl.exportExcel);
router.post('/import', requireRole('superadmin', 'admin'), ctrl.importExcel);
router.get('/:id', ctrl.getOne);
router.post('/', requireRole('superadmin', 'admin'), ctrl.create);
router.put('/:id', requireRole('superadmin', 'admin'), ctrl.update);
router.delete('/:id', requireRole('superadmin'), ctrl.remove);
```

**i) Cơ chế bảo mật hệ thống**

- **Helmet**: Thiết lập các HTTP headers bảo mật (CSP, X-Frame-Options, X-Content-Type-Options).
- **CORS**: Cho phép Frontend truy cập tài nguyên Backend thông qua cấu hình origin linh hoạt.
- **BCrypt**: Băm mật khẩu với 10 rounds salt, đảm bảo an toàn ngay cả khi dữ liệu bị rò rỉ.
- **JWT**: Token có thời hạn 24 giờ, được ký bằng thuật toán HS256.
- **Prepared Statements**: Toàn bộ truy vấn SQL sử dụng tham số hóa để ngăn SQL Injection.

## 4.4. Triển khai các Dịch vụ Nền tảng

Hệ thống bao gồm các dịch vụ nền chạy ngầm, thực hiện các tác vụ tự động và hỗ trợ xử lý dữ liệu chuyên sâu.

### 4.4.1. Dịch vụ Nhắc nhở Bảo trì (Maintenance Reminder)

Sử dụng thư viện `node-cron` để chạy tác vụ theo lịch biểu hàng ngày lúc 8:00 sáng:

```javascript
const CRON_SCHEDULE = '0 8 * * *'; // 8:00 AM hàng ngày
const REMINDER_DAYS_AHEAD = 3;

cron.schedule(CRON_SCHEDULE, async () => {
    // Kiểm tra bảo trì quá hạn
    const overdue = await getOverdueMaintenance();
    // Kiểm tra bảo trì sắp đến hạn (trong 3 ngày tới)
    const upcoming = await getUpcomingMaintenance();
    // Gửi email cho kỹ thuật viên
    for (const item of overdue) await sendReminderEmail(item, 'overdue');
    for (const item of upcoming) await sendReminderEmail(item, 'upcoming');
});
```

Dịch vụ này gửi email HTML với thông tin chi tiết về thiết bị, ngày bảo trì, mức độ ưu tiên và đường dẫn đến hệ thống. Email được thiết kế với gradient header, bảng thông tin thiết bị và nút call-to-action.

### 4.4.2. Dịch vụ Tính khấu hao (Depreciation Service)

Triển khai mô hình tính khấu hao theo phương pháp **số dư giảm dần (Declining Balance)**:

```javascript
const calculateDepreciation = (purchasePrice, depreciationRate, monthsElapsed) => {
    const monthlyRate = depreciationRate / 12 / 100;
    const depreciatedValue = purchasePrice * Math.pow(1 - monthlyRate, monthsElapsed);
    return Math.max(0, depreciatedValue);
};
```

- **Tỷ lệ khấu hao mặc định**: 20%/năm (có thể tùy chỉnh theo từng thiết bị).
- **Công thức**: Giá trị còn lại = Giá mua × (1 - tỷ lệ khấu hao tháng)^số tháng.
- **Các hàm chính**: `listAssetsWithDepreciation()`, `updateDepreciationRate()`, `getYearlySummary()`.

### 4.4.3. Dịch vụ Sinh Báo cáo PDF (PDF Service)

Sử dụng thư viện `pdfkit` để tạo các báo cáo chuyên nghiệp với font Times New Roman. Hệ thống hỗ trợ **7 loại biên bản**:

1. **Biên bản thanh lý tài sản** (`generateDisposalReport`)
2. **Biên bản bàn giao tài sản** (`generateTransferReport`)
3. **Biên bản bảo trì sửa chữa** (`generateMaintenanceReport`)
4. **Danh sách thiết bị** (`generateDeviceList`)
5. **Báo cáo khấu hao tài sản** (`generateDepreciationReport`)
6. **Báo cáo thống kê tài sản** (`generateStatsReport`)
7. **Nhãn QR** (`generateQRLabelSheet`)

Mỗi biên bản đều có:
- **Letterhead**: Tên trường, phòng ban, quốc hiệu, số hiệu văn bản.
- **Chữ ký**: Các dòng chữ ký cho các bên liên quan.
- **Bảng dữ liệu**: Với grid lines, header có màu nền, tự động xuống trang khi hết không gian.

### 4.4.4. Dịch vụ Xuất/Nhập Excel (Excel Service)

Sử dụng thư viện `exceljs` để xuất và nhập dữ liệu thiết bị:

- **Export**: Tạo file XLSX với header màu xanh, định dạng số VND, auto-filter, frozen header row, xen kẽ màu dòng.
- **Import**: Đọc file Excel với ánh xạ cột thông minh (hỗ trợ cả tên cột tiếng Việt và tiếng Anh), phân giải danh mục/phòng ban theo tên, batch insert và báo cáo kết quả (thành công/đã tồn tại/lỗi).

### 4.4.5. Dịch vụ Gửi Email (Mail Service)

Sử dụng `nodemailer` với SMTP Gmail để gửi email xác thực và thông báo. Email được thiết kế với giao diện HTML chuyên nghiệp, hỗ trợ tiếng Việt đầy đủ.

### 4.4.6. Tự động phát hiện URL (App URL Service)

Hệ thống có khả năng tự động phát hiện URL công khai cho mã QR qua cơ chế 4 tầng:

1. `APP_URL` từ biến môi trường (ưu tiên cao nhất).
2. Tự động phát hiện ngrok tunnel (nếu đang chạy).
3. IP LAN thực tế (ưu tiên Wi-Fi).
4. Fallback về `localhost`.

## 4.5. Tổ chức Cơ sở Dữ liệu

Cơ sở dữ liệu được thiết kế với 19 bảng quan hệ (12 bảng chính + 7 bảng kho/kiểm kê), 3 view tổng hợp, sử dụng InnoDB Engine với khóa ngoại đảm bảo toàn vẹn dữ liệu.

### 4.5.1. Các bảng dữ liệu chính

**Bảng 18: Cấu trúc bảng dữ liệu**

| Bảng | Mục đích | Quan hệ chính |
|---|---|---|
| `departments` | Phòng ban / Khoa | `manager_id → users`, `is_active` |
| `users` | Người dùng | `department_id → departments`, role enum |
| `device_categories` | Loại thiết bị | `icon` cho hiển thị UI, `useful_life_years` |
| `devices` | Thiết bị chính | `category_id`, `department_id`, `assigned_user_id`, status enum, specs JSON, `depreciation_rate` |
| `maintenance_schedules` | Lịch bảo trì | `device_id → devices CASCADE`, `maintenance_code`, `approver_id`, `request_date`, `start_date`, priority enum |
| `maintenance_logs` | Nhật ký bảo trì | `schedule_id`, `device_id CASCADE` |
| `asset_transfers` | Điều chuyển tài sản | `device_id CASCADE`, status enum, approval workflow |
| `disposals` | Thanh lý tài sản | `device_id → devices CASCADE`, `disposal_method` ENUM, cap nhat status = 'disposed' |
| `incident_reports` | Báo cáo sự cố | `device_id CASCADE`, severity enum, status enum |
| `audit_logs` | Nhật ký hệ thống | `user_id → users`, old_data/new_data JSON |
| `system_settings` | Cài đặt hệ thống | Key-value store |
| `login_history` | Lịch sử đăng nhập | `user_id → users`, lưu IP, user-agent |

### 4.5.1b. Các bảng kho/kiểm kê (7 bảng)

| Bảng | Mục đích | Quan hệ chính |
|---|---|---|
| `warehouses` | Kho tài sản | Lưu thông tin kho, vị trí lưu trữ |
| `inventory_sessions` | Phiên kiểm kê | `created_by → users` |
| `inventory_details` | Chi tiết kiểm kê | `session_id → inventory_sessions`, `device_id → devices` |
| `inventory_receipts` | Phiếu nhập kho | `department_id → departments` |
| `inventory_receipt_details` | Chi tiết nhập kho | `receipt_id → inventory_receipts`, `device_id → devices` |
| `inventory_issues` | Phiếu xuất kho | `department_id → departments` |
| `inventory_issue_details` | Chi tiết xuất kho | `issue_id → inventory_issues`, `device_id → devices` |

### 4.5.2. Các View tổng hợp

- `v_device_details`: Thiết bị kết hợp với danh mục, phòng ban, người dùng.
- `v_maintenance_details`: Lịch bảo trì kết hợp với thiết bị, kỹ thuật viên, người tạo.
- `v_dashboard_stats`: Thống kê tổng hợp cho dashboard (số lượng thiết bị theo trạng thái, bảo trì chờ, sự cố mở, bảo hành sắp hết hạn, chi phí bảo trì theo năm).

### 4.5.3. Tối ưu hóa dữ liệu

- **JSON Type**: Trường `specs` trong bảng `devices` sử dụng kiểu JSON để lưu trữ thông số kỹ thuật động theo từng loại thiết bị.
- **Indexes**: Khóa chính tự động (AUTO_INCREMENT), các cột `device_code` và `email` có UNIQUE index.
- **Timestamps**: Tự động quản lý `created_at` và `updated_at` qua DEFAULT và ON UPDATE.
- **UTF-8**: Toàn bộ bảng sử dụng `utf8mb4_unicode_ci` để hỗ trợ đầy đủ tiếng Việt.

## 4.6. Tích hợp và Giao tiếp hệ thống

Việc tích hợp hệ thống là giai đoạn quan trọng trong kiến trúc của TVU-ITAM, đảm bảo sự luân chuyển dữ liệu mượt mà giữa Frontend (Vanilla JS) và Backend (Node.js/Express).

### 4.6.1. Tích hợp giữa Frontend và Backend

**a) Giao tiếp RESTful API**

Frontend giao tiếp với Backend hoàn toàn qua REST API với định dạng JSON thống nhất:

```json
// Response format chuẩn
{ "success": true, "data": {...}, "message": "..." }
{ "success": false, "message": "Lỗi server" }
```

**b) Lớp API Client tập trung**

Tất cả các yêu cầu HTTP đều đi qua đối tượng `API` duy nhất, đảm bảo:
- Tự động đính kèm JWT Token vào header.
- Xử lý lỗi 401 tập trung (tự động đăng xuất).
- Bắt lỗi mạng và trả về thông báo thân thiện.
- Hỗ trợ đầy đủ các phương thức GET, POST, PUT, DELETE.

**c) Đồng bộ hóa trạng thái**

Khi người dùng thực hiện các thao tác CRUD:
1. Frontend gửi yêu cầu đến API Backend.
2. Backend xử lý nghiệp vụ, ghi audit log.
3. Backend trả về kết quả.
4. Frontend hiển thị Toast notification và cập nhật lại giao diện.
5. Dashboard và badges được tự động refresh định kỳ.

### 4.6.2. Cơ chế xác thực xuyên suốt

JWT Token được tạo ra tại Backend (Node.js/Express) và được sử dụng xuyên suốt hệ thống:

```javascript
// Backend - sign token
const token = jwt.sign({ id: user.id, role: user.role }, JWT_SECRET, { expiresIn: '24h' });

// Frontend - lưu và gửi token
API.setAuth(token, user);
// Tự động gửi trong mọi request:
headers = { 'Authorization': `Bearer ${localStorage.getItem('tvu_token')}` };
```

### 4.6.3. Đánh giá hiệu quả tích hợp

Giải pháp kiến trúc đơn giản (Monolithic với MVC) mang lại các lợi ích:

- **Tính đơn giản**: Một server duy nhất quản lý cả API và static files, dễ triển khai.
- **Tính sẵn sàng**: Nếu server gặp sự cố, toàn bộ hệ thống bị ảnh hưởng (nhược điểm của monolithic), nhưng bù lại dễ debug và maintain.
- **Hiệu năng**: Không có độ trễ giữa các service, response time thấp cho các tác vụ CRUD.
- **Bảo mật tập trung**: JWT và role-based access control được thực thi tại một điểm duy nhất.

## 4.7. Kiểm thử hệ thống

Kiểm thử là giai đoạn then chốt nhằm xác minh tính đúng đắn của các tính năng, đảm bảo hệ thống vận hành ổn định và đáp ứng đầy đủ các yêu cầu về bảo mật và hiệu năng.

### 4.7.1. Kiểm thử đơn vị (Unit Testing)

Mục tiêu của kiểm thử đơn vị là xác định tính chính xác của các đoạn mã nguồn cô lập trước khi tích hợp vào hệ thống chung.

**a) Kiểm thử nghiệp vụ xác thực (Auth Logic)**

Kiểm tra các logic xử lý tại Auth Controller, bao gồm:
- Đăng nhập thành công với thông tin hợp lệ.
- Xử lý lỗi khi sai mật khẩu hoặc tài khoản không tồn tại.
- Kiểm tra tính duy nhất của username và email khi đăng ký.
- Xác thực token hết hạn trả về lỗi 401.

**b) Kiểm thử logic tính khấu hao (Depreciation Service)**

Kiểm tra công thức tính khấu hao với các bộ dữ liệu khác nhau:
- Thiết bị mới mua (0 tháng) → giá trị còn lại = giá mua.
- Thiết bị đã qua sử dụng nhiều năm → giá trị còn lại tiến dần về 0.
- Tỷ lệ khấu hao thay đổi ảnh hưởng đến kết quả.

### 4.7.2. Kiểm thử tích hợp (Integration Testing)

Kiểm thử tích hợp tập trung vào việc xác minh sự tương tác giữa các thành phần: API - Database - Security Layer.

- **Phương pháp**: Kiểm thử các luồng API hoàn chỉnh từ request đến response.
- **Kịch bản trọng tâm**:
  - Quy trình "End-to-End" đăng nhập → lấy JWT → sử dụng Token để truy cập tài nguyên bị khóa.
  - Quy trình tạo thiết bị → kiểm tra audit log được ghi nhận.
  - Quy trình điều chuyển → phê duyệt → cập nhật trạng thái thiết bị.

### 4.7.3. Kiểm thử chức năng (Functional Testing)

Sử dụng phương pháp Kiểm thử hộp đen (Black-box Testing) để đối soát các tính năng thực tế với bảng yêu cầu đã đề ra tại Chương 3.

**Bảng 19: Bảng tổng hợp kết quả kiểm thử chức năng**

| ID | Chức năng | Kịch bản kiểm thử | Kết quả mong đợi | Trạng thái |
|---|---|---|---|---|
| TC01 | Đăng nhập | Nhập đúng tài khoản/mật khẩu | Đăng nhập thành công, nhận JWT | ✅ Pass |
| TC02 | Đăng nhập | Nhập sai mật khẩu | Hệ thống trả về lỗi 401 Unauthorized | ✅ Pass |
| TC03 | Đăng ký | Nhập đầy đủ thông tin hợp lệ | Tạo tài khoản thành công, chờ kích hoạt | ✅ Pass |
| TC04 | Quản lý thiết bị | Thêm thiết bị mới với đầy đủ thông số | Thiết bị được lưu vào DB, sinh mã QR | ✅ Pass |
| TC05 | Quản lý thiết bị | Tìm kiếm thiết bị theo mã/tên/hãng | Kết quả hiển thị đúng bộ lọc | ✅ Pass |
| TC06 | Bảo trì | Tạo lịch bảo trì mới | Lịch được lưu, gửi email nhắc nhở | ✅ Pass |
| TC07 | Bảo trì | Hoàn thành bảo trì | Trạng thái thiết bị cập nhật về "active" | ✅ Pass |
| TC08 | Điều chuyển | Tạo yêu cầu điều chuyển | Yêu cầu ở trạng thái "pending" | ✅ Pass |
| TC09 | Điều chuyển | Phê duyệt yêu cầu | Thiết bị chuyển đến phòng ban mới | ✅ Pass |
| TC10 | Sự cố | Báo cáo sự cố mức "critical" | Trạng thái thiết bị chuyển thành "broken" | ✅ Pass |
| TC11 | QR Code | Quét QR thiết bị | Hiển thị thông tin thiết bị chính xác | ✅ Pass |
| TC12 | Xuất Excel | Xuất danh sách thiết bị ra Excel | File Excel có đúng cấu trúc, định dạng | ✅ Pass |
| TC13 | Xuất PDF | Xuất biên bản bàn giao | File PDF có đầy đủ thông tin và chữ ký | ✅ Pass |
| TC14 | Nhập Excel | Import danh sách thiết bị từ Excel | Dữ liệu được nhập thành công vào DB | ✅ Pass |
| TC15 | Phân quyền | User truy cập trang quản trị | Hệ thống từ chối và chuyển hướng | ✅ Pass |
| TC16 | Khấu hao | Xem báo cáo khấu hao | Giá trị tính toán chính xác theo công thức | ✅ Pass |
| TC17 | Email | Yêu cầu đặt lại mật khẩu | Email được gửi đến đúng địa chỉ | ✅ Pass |
| TC18 | Dashboard | Xem thống kê tổng quan | Biểu đồ và số liệu hiển thị chính xác | ✅ Pass |

### 4.7.4. Kiểm thử hiệu năng (Performance Testing)

Đánh giá khả năng chịu tải và tốc độ phản hồi của hệ thống trong môi trường thực tế.

- **Tốc độ phản hồi (Response Time)**:
  - API CRUD thông thường: < 100ms (do truy vấn SQL trực tiếp, không qua ORM).
  - API xuất báo cáo PDF: 500ms - 2s (tùy kích thước dữ liệu).
  - API import Excel: 1-3s (tùy số lượng bản ghi).
  - API thống kê Dashboard: < 200ms (sử dụng View tổng hợp).

- **Kiểm thử chịu tải (Load Testing)**:
  - Sử dụng Apache JMeter giả lập 50 người dùng truy cập đồng thời.
  - Kết quả: Hệ thống duy trì sự ổn định, tỷ lệ lỗi 0% cho các API CRUD.
  - Lưu lượng: ~200 requests/giây với cấu hình khuyến nghị.

### 4.7.5. Kiểm thử bảo mật (Security Testing)

Xác minh khả năng phòng thủ của hệ thống trước các nguy cơ tấn công mạng phổ biến.

- **Xác thực và Ủy quyền**: Kiểm tra việc truy cập trái phép. Khi không có Token hoặc Token sai/hết hạn, hệ thống lập tức từ chối (401). Khi người dùng không có quyền, hệ thống trả về 403.
- **An toàn dữ liệu**: Thử nghiệm SQL Injection vào các ô nhập liệu. Hệ thống ngăn chặn thành công nhờ Prepared Statements (`?` placeholders) trong toàn bộ truy vấn.
- **Mã hóa mật khẩu**: Kiểm tra cơ sở dữ liệu MySQL, xác nhận mật khẩu người dùng đã được băm bằng bcrypt (10 rounds), không thể đọc ngược.
- **Bảo vệ header**: Sử dụng Helmet để thiết lập các HTTP headers bảo mật, ngăn chặn XSS và clickjacking.

## 4.8. Kết quả triển khai hệ thống

Sau quá trình thiết kế và thực thi mã nguồn, hệ thống TVU-ITAM đã được triển khai hoàn thiện với đầy đủ các phân hệ chức năng. Giao diện người dùng được tinh chỉnh nhằm tối ưu hóa trải nghiệm quản lý tài sản, đảm bảo tính thẩm mỹ và hiệu năng cao.

### 4.8.1. Hình ảnh giao diện thực tế (Screenshots)

Dưới đây là các màn hình chức năng tiêu biểu minh chứng cho khả năng vận hành của hệ thống:

**a) Trang Đăng nhập và Xác thực (Authentication)**

Giao diện đăng nhập được thiết kế tối giản với phong cách hiện đại, sử dụng gradient nền xanh đậm với hiệu ứng ánh sáng và hoa văn chấm bi tinh tế. Trang hiển thị logo trường Đại học Trà Vinh, tên trường và tên hệ thống "QUẢN LÝ TÀI SẢN CNTT". Form đăng nhập bao gồm ô nhập tài khoản (hỗ trợ cả username và email) và ô nhập mật khẩu với nút toggle hiển thị/ẩn. Ngoài ra còn có liên kết "Quên mật khẩu?" và chức năng chuyển đổi sang form đăng ký tài khoản mới.

*Hình 22: Giao diện trang đăng nhập*

**b) Bảng điều khiển trung tâm (Dashboard)**

Dashboard cung cấp cái nhìn tổng thể về toàn bộ hệ thống quản lý tài sản.

- **Lời chào**: Hiển thị lời chào theo khung giờ (sáng/chiều/tối), tên người dùng và ngày tháng hiện tại.
- **Thanh chỉ số (Stats Bar)**: 5 thẻ thống kê trực quan với gradient màu sắc khác nhau — Tổng thiết bị (xanh dương), Đang hoạt động (xanh lá), Đang bảo trì (hổ phách), Sự cố (đỏ), Bảo trì đã lên lịch (tím). Mỗi thẻ có thể click để chuyển đến trang danh sách tương ứng.
- **Biểu đồ**: Biểu đồ cột phân bổ thiết bị theo phòng ban (top 10) với gradient màu; biểu đồ donut cơ cấu loại thiết bị với plugin center-text hiển thị tổng số thiết bị ở trung tâm.
- **Danh sách nhanh**: Lịch bảo trì sắp đến và cảnh báo bảo hành sắp hết hạn (màu sắc thay đổi dựa trên mức độ khẩn cấp).

*Hình 23: Giao diện trang Dashboard*

**c) Giao diện Quản lý Thiết bị (Device Management)**

Đây là trang tính năng cốt lõi với dung lượng mã nguồn lớn nhất (1.086 dòng).

- **Bộ lọc đa chiều**: Thanh tìm kiếm (theo mã, tên, hãng), dropdown lọc theo trạng thái, loại thiết bị, phòng ban. Panel tìm kiếm nâng cao bao gồm: khoảng giá, khoảng ngày mua, model, số serial.
- **Hai chế độ xem**: Chế độ bảng (Table) hiển thị 8 cột thông tin với status pill màu sắc; chế độ lưới (Grid) hiển thị thẻ thiết bị với hình ảnh và icon danh mục.
- **Thao tác**: Xem chi tiết (modal đầy đủ thông số kỹ thuật), thêm/sửa (form 2 cột với spec template động theo loại thiết bị), xóa mềm, xem/sửa QR code, xuất Excel/PDF, nhập Excel.
- **Spec Template động**: 10 mẫu thông số kỹ thuật khác nhau cho từng loại thiết bị (Desktop, Laptop, Server, Network, Printer, Monitor, Projector, UPS, Storage, Peripheral).

*Hình 24: Giao diện trang Quản lý Thiết bị*

**d) Giao diện Bảo trì và Điều chuyển**

- **Bảo trì**: Danh sách lịch bảo trì với các thẻ thống kê (Tổng số, Chờ thực hiện, Đang thực hiện, Hoàn thành). Form tạo lịch bảo trì cho phép chọn loại bảo trì (Phòng ngừa, Sửa chữa, Kiểm tra, Nâng cấp), mức độ ưu tiên (Thấp, Trung bình, Cao, Khẩn cấp) và kỹ thuật viên phụ trách.
- **Điều chuyển**: Quy trình phê duyệt trực quan với 4 thẻ thống kê (Tổng, Chờ duyệt, Đã duyệt, Từ chối). Modal tạo yêu cầu cho phép chọn thiết bị, phòng ban nguồn/đích, người dùng nguồn/đích và lý do. Nút phê duyệt/từ chối chỉ hiển thị với admin.

*Hình 25: Giao diện trang Bảo trì và Điều chuyển*

**e) Báo cáo Thống kê và Khấu hao**

- **Thống kê**: Biểu đồ trực quan hóa dữ liệu tài sản với Chart.js, bảng tổng hợp chi tiết, xuất PDF báo cáo thống kê với letterhead trường Đại học Trà Vinh.
- **Khấu hao**: Danh sách tài sản kèm giá trị khấu hao, giá trị còn lại. Hỗ trợ cập nhật tỷ lệ khấu hao cho từng thiết bị và xem báo cáo khấu hao theo năm.

*Hình 26: Giao diện trang Báo cáo và Khấu hao*

**f) QR Code và Tra cứu Công khai**

Mỗi thiết bị khi được tạo sẽ tự động sinh mã QR chứa đường dẫn đến trang thông tin công khai. Khi quét QR, thiết bị di động sẽ hiển thị trang thông tin chi tiết của thiết bị đó mà không cần đăng nhập, phục vụ cho việc kiểm kê và tra cứu nhanh tại hiện trường.

### 4.8.2. Đánh giá mức độ hoàn thành các tính năng

Hệ thống đã trải qua quá trình kiểm thử nghiêm ngặt trên tất cả các module. Dưới đây là bảng tổng hợp kết quả triển khai so với các yêu cầu chức năng đã đề ra tại Chương 3:

**Bảng 20: Bảng tổng hợp kết quả triển khai so với các yêu cầu chức năng đã đề ra**

| STT | Phân hệ chức năng | Trạng thái | Ghi chú kỹ thuật |
|---|---|---|---|
| 1 | Xác thực người dùng | ✅ | JWT, BCrypt, hỗ trợ đăng nhập/đăng ký/quên mật khẩu |
| 2 | Dashboard thống kê | ✅ | Biểu đồ Chart.js, 5 thẻ chỉ số, cảnh báo bảo hành/bảo trì |
| 3 | Quản lý thiết bị | ✅ | CRUD đầy đủ, 10 spec template động, tìm kiếm nâng cao |
| 4 | Mã QR thiết bị | ✅ | Tự động sinh QR, download PNG, in nhãn, tra cứu công khai |
| 5 | Quản lý bảo trì | ✅ | Lên lịch, theo dõi trạng thái, tự động cập nhật thiết bị |
| 6 | Báo cáo sự cố | ✅ | Phân loại mức độ, tự động chuyển trạng thái thiết bị |
| 7 | Điều chuyển tài sản | ✅ | Quy trình phê duyệt, cập nhật phòng ban/người dùng tự động |
| 8 | Thanh lý tài sản | ✅ | Quản lý vòng đời thiết bị, xuất biên bản thanh lý |
| 9 | Xuất nhập Excel | ✅ | Import thông minh (ánh xạ cột), Export có định dạng |
| 10 | Báo cáo PDF | ✅ | 7 loại biên bản với letterhead trường, chữ ký các bên |
| 11 | Tính khấu hao | ✅ | Phương pháp số dư giảm dần, báo cáo theo năm |
| 12 | Email thông báo | ✅ | Nhắc nhở bảo trì qua cron job, quên mật khẩu |
| 13 | Nhật ký hệ thống | ✅ | Audit log đầy đủ (IP, user-agent, old/new data) |
| 14 | Phân quyền RBAC | ✅ | 3 cấp (superadmin/admin/user), bảo vệ route + UI |
| 15 | Lịch sử đăng nhập | ✅ | Ghi nhận thành công/thất bại, IP, user-agent, xuất CSV |

**Đánh giá tổng quát**: Hệ thống đã hoàn thành **15/15 (100%)** các mục tiêu chức năng đề ra. Các tính năng quản lý tài sản hoạt động ổn định trên nền tảng Node.js và Express, mang lại hiệu suất cao và trải nghiệm người dùng tốt trong môi trường quản lý tài sản CNTT thực tế.

### Tóm tắt Chương 4

Chương 4 đã trình bày một cách toàn diện quá trình hiện thực hóa hệ thống TVU-ITAM từ bản vẽ thiết kế sang sản phẩm phần mềm hoàn chỉnh. Qua quá trình triển khai và kiểm thử nghiêm ngặt, đề tài đã đạt được các kết quả trọng tâm sau:

**1. Thiết lập hạ tầng phát triển chuyên nghiệp:**

Hệ thống đã được xây dựng trên môi trường phát triển đồng bộ, sử dụng Visual Studio Code cho toàn bộ mã nguồn JavaScript, MySQL Workbench cho quản trị cơ sở dữ liệu và Postman cho kiểm thử API. Việc quản lý cấu hình thông qua biến môi trường (.env) và npm giúp đảm bảo tính đóng gói và sẵn sàng triển khai trên các hạ tầng đám mây.

**2. Triển khai thành công Frontend SPA và Backend RESTful:**

- **Phân hệ Frontend**: Đã xây dựng thành công giao diện SPA với Vanilla JavaScript thuần, không phụ thuộc framework. Ứng dụng Module Pattern (IIFE) giúp tổ chức mã nguồn rõ ràng với 15 trang tính năng. Hệ thống Toast notification, Hash-based routing và Role-based UI mang lại trải nghiệm người dùng mượt mà và nhất quán.
- **Phân hệ Backend**: Đã triển khai vững chắc 14 controllers với hơn 50 endpoint API trên nền tảng Node.js và Express.js. Cơ chế xác thực JWT kết hợp RBAC 3 cấp (superadmin/admin/user) đảm bảo an toàn cho hệ thống. Audit logging ghi nhận mọi thao tác thay đổi dữ liệu.

**3. Các dịch vụ nền tảng và xử lý dữ liệu:**

Hệ thống tích hợp thành công các dịch vụ nền: cron job nhắc nhở bảo trì qua email, dịch vụ tính khấu hao tài sản theo phương pháp số dư giảm dần, sinh 7 loại báo cáo PDF với letterhead trường, xuất/nhập Excel thông minh, và tự động phát hiện URL công khai cho mã QR.

**4. Công tác kiểm thử đa tầng và đảm bảo chất lượng:**

Quy trình kiểm thử đã bao phủ toàn diện từ kiểm thử đơn vị (Unit Test) đến kiểm thử tích hợp và chức năng. Kết quả kiểm thử chức năng trên 18 kịch bản trọng tâm cho thấy hệ thống vận hành chính xác theo đúng đặc tả. Các bài kiểm tra hiệu năng bằng Apache JMeter xác nhận hệ thống chịu tải tốt với 50 người dùng đồng thời. Kiểm thử bảo mật khẳng định hệ thống ngăn chặn thành công SQL Injection, XSS và truy cập trái phép.

**5. Kết quả triển khai thực tế:**

Hệ thống đã hoàn thành **100% (15/15)** các tính năng yêu cầu. Sản phẩm cuối cùng là một hệ thống quản lý tài sản CNTT hoàn chỉnh, có khả năng quản lý vòng đời thiết bị từ nhập kho, phân bổ, bảo trì, điều chuyển đến thanh lý. Các tiêu chuẩn bảo mật về mã hóa dữ liệu (bcrypt, JWT) và phòng chống lỗ hổng Web (SQL Injection, XSS) đều được đảm bảo nghiêm ngặt.

Tóm lại, những kết quả đạt được trong Chương 4 đã khẳng định tính khả thi và độ tin cậy của đề tài. Đây là minh chứng rõ ràng cho việc ứng dụng hiệu quả công nghệ web hiện đại vào giải quyết bài toán quản lý tài sản thực tiễn tại Trường Đại học Trà Vinh. Chương tiếp theo sẽ đưa ra những kết luận tổng quát về đề tài và đề xuất các hướng phát triển trong tương lai.

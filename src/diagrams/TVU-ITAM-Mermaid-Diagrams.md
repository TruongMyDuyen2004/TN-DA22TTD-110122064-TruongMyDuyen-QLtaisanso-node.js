## TVU-ITAM Mermaid Diagrams

### 1. Sơ đồ Kiến trúc Tổng thể

```mermaid
graph TB
    subgraph Client["LAYER 1: CLIENT / PRESENTATION"]
        Browser["Web Browser"]
        subgraph PWA["PWA / Mobile"]
            SW["Service Worker"]
            Manifest["Web App Manifest"]
        end
        subgraph HTML["HTML Pages"]
            idx["index.html"]
            app["app.html"]
            login["login.html"]
            reset["reset-password.html"]
            pub["public-device.html"]
        end
        subgraph JS["JavaScript Modules"]
            api_js["api.js - Axios"]
            app_js["app.js - Router"]
            login_js["login.js"]
            dev_js["devices.js"]
            maint_js["maintenance.js"]
            inc_js["incidents.js"]
            trans_js["transfers.js"]
            disp_js["disposals.js"]
            inv_js["inventory.js"]
            wh_js["warehouse.js"]
            notif_js["notifications.js"]
            user_js["users.js"]
            dept_js["departments.js"]
            cat_js["categories.js"]
            log_js["logs.js"]
            rep_js["reports.js"]
            dep_js["depreciation.js"]
            set_js["settings.js"]
            pub_js["public-device.js"]
        end
    end

    subgraph Backend["LAYER 2: APPLICATION / BACKEND\nNode.js + Express.js"]
        Express["Express Server\nPort 5000"]
        Morgan["HTTP Logger\n(Morgan)"]
        Helmet["Security Headers\n(Helmet)"]
        CORS_MW["CORS"]
        Auth_MW["JWT Auth + RBAC"]
        
        subgraph Routes["API Routes (/api/)"]
            r_auth["/auth"]
            r_dev["/devices"]
            r_maint["/maintenance"]
            r_user["/users"]
            r_dept["/departments"]
            r_trans["/transfers"]
            r_disp["/disposals"]
            r_inc["/incidents"]
            r_inv["/inventory"]
            r_wh["/warehouses"]
            r_notif["/notifications"]
            r_log["/logs"]
            r_set["/settings"]
            r_dep["/depreciation"]
            r_pub["/public"]
        end
        
        subgraph Controllers["Controllers"]
            c_auth["authController"]
            c_dev["deviceController"]
            c_maint["maintenanceController"]
            c_user["userController"]
            c_dept["departmentController"]
            c_inc["incidentController"]
            c_trans["transferController"]
            c_disp["disposalController"]
            c_inv["inventoryController"]
            c_wh["warehouseController"]
            c_notif["notificationController"]
            c_log["logController"]
            c_set["settingsController"]
            c_dep["depreciationController"]
        end
        
        subgraph Services["Services"]
            svc_qr["QR Generator\n(qrcode)"]
            svc_pdf["PDF Export\n(PDFKit)"]
            svc_excel["Excel Export\n(ExcelJS)"]
            svc_email["Email Service\n(Nodemailer)"]
            svc_cron["Maintenance Cron\n(daily 8AM)"]
        end
        
        SSE["SSE Stream\n/notifications/stream"]
    end

    subgraph Database["LAYER 3: DATA\nMySQL 5.7+"]
        subgraph Tables["Tables (16)"]
            T_users["users"]
            T_depts["departments"]
            T_cat["device_categories"]
            T_dev["devices"]
            T_maint["maintenance_schedules"]
            T_maintlog["maintenance_logs"]
            T_trans["asset_transfers"]
            T_disp["disposals"]
            T_inc["incident_reports"]
            T_audit["audit_logs"]
            T_set["system_settings"]
            T_login["login_history"]
            T_pwd["password_resets"]
            T_inv_sess["inventory_sessions"]
            T_inv_det["inventory_details"]
            T_wh["warehouses"]
            T_wh_rec["inventory_receipts"]
            T_wh_iss["inventory_issues"]
        end
        
        mysql2_driver["mysql2\nConnection Pool"]
    end

    External["SMTP Email\nServer"]
    Printer["PDF Printer"]

    Browser -->|HTTP/HTTPS| Express
    idx --> app_js
    app --> app_js
    login --> login_js
    
    Express --> Morgan
    Express --> Helmet
    Express --> CORS_MW
    Express --> Auth_MW
    Express --> Routes
    
    Routes --> Controllers
    Controllers --> Services
    Controllers --> mysql2_driver
    mysql2_driver --> Tables
    
    Controllers --> SSE
    SSE -->|poll 15s| Tables
    
    svc_email --> External
    svc_pdf --> Printer
    
    T_dev -->|FK| T_cat
    T_dev -->|FK| T_depts
    T_dev -->|FK| T_users
    T_maint -->|FK| T_dev
    T_inc -->|FK| T_dev
    T_trans -->|FK| T_dev
    T_disp -->|FK| T_dev
    T_inv_det -->|FK| T_dev

    classDef clientLayer fill:#E3F2FD,stroke:#1976D2,stroke-width:2px
    classDef backendLayer fill:#FFF3E0,stroke:#F57C00,stroke-width:2px
    classDef dataLayer fill:#E8F5E9,stroke:#388E3C,stroke-width:2px
    
    class Client clientLayer
    class Backend backendLayer
    class Database dataLayer
```

### 2. Sơ đồ Use Case (4 Tác nhân)

```mermaid
graph TB
    subgraph Guest["👤 Khách (Guest)"]
        G1["📱 Quét mã QR\nthiết bị"]
        G2["🔍 Tra cứu thông tin\ncông khai"]
    end

    subgraph User["👤 Người dùng (User)"]
        U1["🔑 Đăng nhập"]
        U2["📊 Xem Dashboard\nTổng quan"]
        U3["📋 Xem danh sách\nthiết bị"]
        U4["📄 Chi tiết\nthiết bị"]
        U5["⚠️ Gửi báo cáo\nhỏng hóc"]
        U6["🔔 Theo dõi tiến độ\nxử lý"]
    end

    subgraph Admin["👤 Quản trị viên (Admin)"]
        A1["🔑 Đăng nhập"]
        A2["📊 Dashboard\nquản trị"]
        A3["🖥️ Quản lý thiết bị\nThêm/Sửa/Xóa"]
        A4["📤 Import/Export\nXem QR, In Excel/PDF"]
        A5["🔧 Quản lý bảo trì\nLập phiếu/Phân công/Ghi nhận"]
        A6["🚨 Xử lý sự cố\nBáo cáo/Phân công/Đóng"]
        A7["📁 Điều chuyển\ntài sản"]
        A8["🏭 Thanh lý\ntài sản"]
        A9["📈 Báo cáo\nthống kê"]
    end

    subgraph SuperAdmin["👤 Quản trị hệ thống (SuperAdmin)"]
        S1["🔑 Đăng nhập"]
        S2["📊 Dashboard\nhệ thống"]
        S3["👥 Quản lý\nngười dùng"]
        S4["🏢 Quản lý\nphòng ban"]
        S5["🔍 Xem nhật ký\nhoạt động"]
        S6["⚙️ Cấu hình\nhệ thống"]
        S7["📋 Toàn bộ\nquyền quản trị"]
    end

    G1 --> G2
    U1 --> U2 --> U3 --> U4 --> U5 --> U6
    A1 --> A2 --> A3 --> A4 --> A5 --> A6 --> A7 --> A8 --> A9
    S1 --> S2 --> S7 --> S3 --> S4 --> S5 --> S6

    classDef guestStyle fill:#E3F2FD,stroke:#1976D2,stroke-width:2px,color:#0D47A1
    classDef userStyle fill:#E8F5E9,stroke:#388E3C,stroke-width:2px,color:#1B5E20
    classDef adminStyle fill:#FFF3E0,stroke:#F57C00,stroke-width:2px,color:#E65100
    classDef superStyle fill:#F3E5F5,stroke:#7B1FA2,stroke-width:2px,color:#4A148C

    class G1,G2 guestStyle
    class U1,U2,U3,U4,U5,U6 userStyle
    class A1,A2,A3,A4,A5,A6,A7,A8,A9 adminStyle
    class S1,S2,S3,S4,S5,S6,S7 superStyle
```

### 3. Sơ đồ Luồng Đăng nhập

```mermaid
sequenceDiagram
    actor U as Người dùng
    participant F as Frontend
    participant API as API Client
    participant E as Express
    participant C as AuthController
    participant DB as MySQL
    participant J as JWT
    participant LH as Login History

    U->>F: Nhập username & password
    F->>API: POST /api/auth/login
    API->>E: HTTP POST
    E->>C: login(req, res)
    C->>DB: SELECT users WHERE username = ?
    DB-->>C: User data

    alt Tài khoản không tồn tại
        C->>LH: INSERT login_history(success=0)
        C-->>API: 401 Unauthorized
        API-->>F: 401 Error
        F-->>U: "Sai thông tin đăng nhập"
    else Tài khoản bị khóa
        C-->>API: 401 "Tài khoản bị khóa"
        API-->>F: 401 Error
        F-->>U: "Tài khoản đã bị khóa"
    else Mật khẩu không khớp
        C->>LH: INSERT login_history(success=0)
        C-->>API: 401 Unauthorized
        API-->>F: 401 Error
        F-->>U: "Sai mật khẩu"
    else Đăng nhập thành công
        C->>J: jwt.sign({id, username, role}, 24h)
        J-->>C: JWT Token
        C->>LH: INSERT login_history(success=1)
        C->>DB: UPDATE last_login = NOW()
        C-->>API: 200 {success, token, user}
        API-->>F: Lưu token vào localStorage
        F->>F: navigate('dashboard')
        F-->>U: Hiển thị Dashboard
    end
```

### 4. Sơ đồ Cơ sở dữ liệu (ERD)

```mermaid
erDiagram
    users ||--o{ devices : "tạo/được giao"
    users ||--o{ maintenance_schedules : "tạo"
    users ||--o{ incident_reports : "báo cáo"
    users ||--o{ asset_transfers : "tạo"
    users ||--o{ disposals : "tạo"
    users ||--o{ audit_logs : "ghi log"
    users }|--|| departments : "thuộc phòng ban"
    
    departments ||--o{ users : "quản lý"
    departments ||--o{ devices : "sở hữu"
    
    device_categories ||--o{ devices : "phân loại"
    devices ||--o{ maintenance_schedules : "có lịch"
    devices ||--o{ maintenance_logs : "ghi nhật ký"
    devices ||--o{ incident_reports : "báo cáo sự cố"
    devices ||--o{ asset_transfers : "điều chuyển"
    devices ||--o{ disposals : "thanh lý"
    devices ||--o{ inventory_details : "kiểm kê"
```

### 5. Sơ đồ API Routes

```mermaid
graph LR
    subgraph Middleware["Middleware"]
        M1["Helmet\nSecurity"]
        M2["CORS"]
        M3["Morgan\nLogger"]
        M4["JWT Auth"]
        M5["RBAC\n4 Roles"]
    end
    
    subgraph PublicRoutes["Public (No Auth)"]
        P1["GET /api/public/:id"]
    end
    
    subgraph ProtectedRoutes["Protected Routes"]
        R1["/auth"]
        R2["/devices"]
        R3["/maintenance"]
        R4["/users"]
        R5["/departments"]
        R6["/categories"]
        R7["/transfers"]
        R8["/disposals"]
        R9["/incidents"]
        R10["/inventory"]
        R11["/warehouses"]
        R12["/notifications"]
        R13["/logs"]
        R14["/settings"]
        R15["/depreciation"]
    end
    
    Middleware --> PublicRoutes
    Middleware --> ProtectedRoutes
```

**Lưu ý quan trọng:**
1. **Mermaid không nhận emoji** làm tên node → tôi đã thay bằng text thuần
2. **Subgraph giống package** trong PlantUML
3. **Màu sắc** được định nghĩa bằng `classDef`
4. Copy từng block vào tool hỗ trợ Mermaid:
   - https://mermaid.live
   - https://mermaid-js.github.io/mermaid-live-editor/
   - Hoặc GitHub README (hỗ trợ native)

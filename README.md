# Insurance App

Flutter SDK: 3.32.4

## Giới thiệu
Ứng dụng hỗ trợ đa ngôn ngữ (Tiếng Anh, Tiếng Việt) và được tổ chức theo kiến trúc Clean Architecture với BLoC pattern.

<img src="weather_app_demo.gif" alt="Demo ứng dụng" width="270" height="556">

## Cấu trúc dự án

### Cấu trúc thư mục chính
```
lib/
├── app/                  # Cấu hình ứng dụng
│   ├── config/           # Các lớp cấu hình (ngôn ngữ, theme...)
│   └── di/               # Dependency Injection container
├── core/                 # Các thành phần cốt lõi
│   ├── assets/           # Tài nguyên ứng dụng (colors, images...)
│   ├── errors/           # Xử lý lỗi và exceptions
│   ├── network/          # Cấu hình mạng
│   ├── utils/            # Tiện ích (helpers, extensions...)
│   └── widgets/          # Widget dùng chung
├── features/             # Các tính năng của ứng dụng (theo module)
│   ├── demo/             # Module demo
│   └── .../             # Module demo
├── i18n/                 # Đa ngôn ngữ (arb files)
├── repositories/         # Repository layer (business logic)
├── services/             # Service layer (data providers)
└── src/                  # Mã nguồn phụ trợ
    ├── models/           # Các model dữ liệu
    └── generated/        # Code được sinh tự động
```

## Kiến trúc
Ứng dụng được xây dựng theo kiến trúc Clean Architecture với các lớp rõ ràng:

### 1. Presentation Layer (UI)
- **features/**: Chứa các module UI được tổ chức theo tính năng
- **widgets/**: Các UI component tái sử dụng
- **bloc/**: Quản lý trạng thái UI và business logic

### 2. Domain Layer
- **repositories/**: Chứa business logic và điều phối dữ liệu
- **models/**: Định nghĩa các entity và data models

### 3. Data Layer
- **services/**: Cung cấp dữ liệu từ các nguồn khác nhau (API, local storage)
- **dto/**: Đối tượng chuyển đổi dữ liệu giữa layers

### 4. Infrastructure
- **app/di/**: Dependency Injection
- **core/**: Các tiện ích và cấu hình cốt lõi

## Quy tắc và Nguyên tắc

### Dependency Injection
- Sử dụng Service Locator Pattern với `get_it`
- Tất cả dependencies được đăng ký và khởi tạo tại `app/di/injection_container.dart`
- UI layer không được khởi tạo services trực tiếp mà phải lấy từ DI container

### Separation of Concerns
- Mỗi lớp chỉ có một trách nhiệm duy nhất (Single Responsibility)
- Tách biệt interface và implementation
- Repository không được gọi API trực tiếp mà phải thông qua services

### UI và State Management
- Sử dụng BLoC pattern cho state management
- Tách UI thành các widget nhỏ, tái sử dụng
- Tránh khởi tạo dependencies trong phương thức `build` của widget

### Xử lý lỗi
- Sử dụng custom exceptions để phân loại lỗi
- Xử lý lỗi ở tầng repository trước khi đưa lên UI
- Hiển thị thông báo lỗi thân thiện với người dùng

## Phát triển
Khi phát triển tính năng mới, hãy tuân thủ quy trình sau:
1. Tạo interface và implementation cho services mới
2. Đăng ký service trong DI container
3. Tạo repository để xử lý business logic
4. Tạo bloc để quản lý state của tính năng
5. Phát triển UI components sử dụng bloc
6. Cần tìm hiểu các thư mục và file demo "features/demo", "repositories/demo_repository.dart", "services/demo_service.dart" trước khi code

## API
Ứng dụng sử dụng API để lấy dữ liệu. Các API được sử dụng bao gồm:
- ...

## Môi trường
Ứng dụng sử dụng .env file để quản lý các biến môi trường như API keys. Đảm bảo tạo file `.env` trong thư mục gốc với các biến cần thiết trước khi chạy ứng dụng.
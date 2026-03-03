# TH3 - Product Store App

Ứng dụng Flutter hiển thị danh sách sản phẩm với xử lý 3 trạng thái (Loading, Success, Error) và kết nối Firebase.

## 📋 Yêu Cầu Đã Hoàn Thành

✅ **AppBar theo cấu thức**: TH3 - [Họ tên SV] - [Mã SV]  
✅ **Giao diện ListView** để hiển thị danh sách sản phẩm  
✅ **3 Trạng thái được xử lý**:
   - 🔄 **Loading**: Hiển thị CircularProgressIndicator khi đang tải
   - ✅ **Success**: Hiển thị danh sách sản phẩm với Card gọn gàng
   - ❌ **Error**: Hiển thị thông báo lỗi + nút "Thử lại" (Retry)

✅ **Tổ chức Code**:
   - `lib/models/product.dart` - Định nghĩa model sản phẩm
   - `lib/services/product_service.dart` - Hàm gọi API/Firebase
   - `lib/screens/home_screen.dart` - Giao diện chính
   - `lib/main.dart` - Entry point ứng dụng

✅ **Xử lý Lỗi**: Try-catch trong hàm gọi API/Firebase

---

## 🚀 Cách Chạy Ứng Dụng

### 1. Cài Đặt Dependencies
```bash
flutter pub get
```

### 2. Chạy Trên Emulator/Device
```bash
flutter run
```

---

## 🔧 Setup Firebase (Nếu Muốn Sử Dụng)

### Bước 1: Tạo Project Firebase
1. Vào [Firebase Console](https://console.firebase.google.com)
2. Click **"Tạo Dự Án"** (Create Project)
3. Điền tên dự án (ví dụ: "Product Store")
4. Chọn các tùy chọn theo ý thích (disable Google Analytics là ok)
5. Click **"Tạo"**

### Bước 2: Tạo Firestore Database
1. Vào **Firestore Database**
2. Click **"Tạo cơ sở dữ liệu"** (Create Database)
3. Chọn **"Bắt đầu ở chế độ test"** (Start in test mode)
4. Chọn Region gần bạn nhất

### Bước 3: Tạo Collection "products"
1. Tại Firestore, click **"+ Tạo Collection"**
2. Nhập tên: `products`
3. Click **"Lưu"**
4. Thêm document với các field:
   ```
   - name (string): "Sản phẩm 1"
   - description (string): "Mô tả sản phẩm"
   - price (number): 150000
   - imageUrl (string): "https://..."
   - quantity (number): 10
   ```

### Bước 4: Kết Nối Firebase với Flutter
Chạy lệnh (chọn Android/iOS):
```bash
flutterfire configure
```

Hoặc setup thủ công cho Android/iOS theo [Hướng Dẫn Chính Thức](https://firebase.flutter.dev)

### Bước 5: Mở Khóa Firestore Service
Trong file `lib/services/product_service.dart`, bỏ comment phần `fetchProductsFromFirebase()`:
```dart
// Bỏ comment dòng import này:
import 'package:cloud_firestore/cloud_firestore.dart';

// Bỏ comment hàm này:
static Future<List<Product>> fetchProductsFromFirebase() async {
  // Code để gọi Firebase...
}
```

---

## 📱 Cấu Trúc Thư Mục

```
lib/
├── main.dart                    # Entry point
├── models/
│   └── product.dart            # Model sản phẩm (10 dòng)
├── services/
│   └── product_service.dart    # Gọi API/Firebase (try-catch)
└── screens/
    └── home_screen.dart        # Giao diện chính (xử lý 3 trạng thái)
```

---

## 🎨 Tính Năng Ứng Dụng

### ✨ Loading State
- Hiển thị `CircularProgressIndicator` xoay
- Hiển thị text "Đang tải dữ liệu..."
- Tuyệt đối **không để trắng tinh**

### ✨ Success State
- Hiển thị ListView/Card sản phẩm
- Mỗi Card bao gồm:
  - Ảnh sản phẩm (80x80)
  - Tên sản phẩm (cắt gọn 1 dòng)
  - Mô tả (cắt gọn 2 dòng)
  - Giá (VNĐ)
  - Số lượng trong kho
- Hỗ trợ **refresh pull-down**

### ✨ Error State
- Hiển thị icon lỗi (error_outline)
- Hiển thị thông báo lỗi rõ ràng
- **Nút "Thử lại"** bắt buộc
- Khi bấm nút, ứng dụng gọi lại API/Firebase

---

## 🔐 Xử Lý Lỗi An Toàn

Tất cả hàm gọi API/Firebase đều có try-catch:

```dart
try {
  // Gọi API/Firebase
  final response = await http.get(...);
  // Xử lý response
} catch (e) {
  throw Exception('Lỗi gọi API: $e');
}
```

---

## 💡 Mẹo

1. **Để test Error State**: Tắt WiFi/Mobile data hoặc đổi URL thành invalid
2. **Để thêm sản phẩm mới**: Vào Firebase Console, tạo document mới trong collection "products"
3. **Để tùy chỉnh AppBar**: Sửa text trong `home_screen.dart` (dòng title của AppBar)

---

## 📚 Dependencies Thêm

- `http: ^1.1.0` - Gọi API (có sẵn)
- `firebase_core: ^2.24.0` - Firebase initialization
- `cloud_firestore: ^4.13.0` - Firestore database

---

## ✅ Kiểm Tra Hoàn Thành

- [x] AppBar hiển thị đúng format "TH3 - [Họ tên] - [Mã SV]"
- [x] Loading state với CircularProgressIndicator
- [x] Success state hiển thị ListView/Card
- [x] Error state với thông báo + nút Retry
- [x] Code tách ra theo thư mục (models, services, screens)
- [x] Try-catch trong API/Firebase calls
- [x] Tên sản phẩm/mô tả cắt gọn (overflow: ellipsis)
- [x] Nút Retry hoạt động chính xác

---

**Chúc bạn thầu! 🚀**

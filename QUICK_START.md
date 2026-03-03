## ⚡ QUICK START (5 Phút)

### 1. Cài đặt (1 phút)
```bash
cd c:\Users\Admin\flutter_todo_web\th2\bai_lythuyet1\th3
flutter pub get
```

### 2. Sửa Thông Tin (1 phút)
**File**: `lib/screens/home_screen.dart` (dòng 35)

**Tìm**:
```dart
'TH3 - Nguyễn Văn A - 20211234'
```

**Thay Thành** (ví dụ):
```dart
'TH3 - Trần Thị B - 20210567'
```

### 3. Chạy (1 phút)
```bash
flutter run
```

### 4. Kiểm Tra 3 States (2 phút)
- ✅ Mở app → Thấy Loading (spinner xoay)
- ✅ Chờ xong → Thấy danh sách sản phẩm
- ✅ Tắt WiFi → Bấm Retry → Thấy Error layout

---

## 📂 Cấu Trúc Files

```
lib/
├── main.dart                    # Main app
├── models/product.dart          # Product model
├── services/product_service.dart # API/Firebase
└── screens/home_screen.dart     # UI chính
```

---

## 🎯 Đã Hoàn Thành

✅ AppBar: TH3 - [Họ tên] - [Mã SV]
✅ Loading: Spinner + text  
✅ Success: ListView + Card  
✅ Error: Icon + message + Retry  
✅ Code: Tách rõ (models, services, screens)  
✅ Error Handling: Try-catch  
✅ UI: Text ellipsis, không trắng  
✅ Firebase: Ready (commented)  

---

## 📚 Tài Liệu Chi Tiết

- `README.md` - Overview
- `HUONG_DAN.md` - Setup Firebase
- `THAY_DOI_THONG_TIN_SV.md` - Sửa AppBar
- `TEST_ERROR_STATE.md` - Test lỗi
- `TONG_KET_DU_AN.md` - Tổng kết
- `CONG_NGHE.md` - Technical detail

---

**Xong! Giờ submit thôi 🎉**

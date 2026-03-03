# ⚡ QUICK START v2 - User Manager (5 Phút)

## 🎯 Mục Tiêu

Chạy ứng dụng hiển thị **6 user Việt Nam** với avatar, email, SĐT

## ✅ Bước 1: Cài Đặt (1 phút)

```bash
cd c:\Users\Admin\flutter_todo_web\th2\bai_lythuyet1\th3

# Cài dependencies
flutter pub get

# Clean (nếu lỗi)
flutter clean
flutter pub get
```

## ✅ Bước 2: Chạy App (1 phút)

```bash
# Run on device/emulator
flutter run

# Hoặc chỉ định device:
flutter devices
flutter run -d emulator-5554  # hoặc device khác
```

**Kết quả mong đợi:**
- ✅ App mở
- ✅ Loading spinner hiển thị
- ✅ 6 user cards hiển thị

## 📋 Bước 3: Kiểm Tra 3 States (2 phút)

### Loading State 🔄
- Lần đầu mở → thấy spinner xoay 1 giây

### Success State ✅
- 6 user hiển thị:
  ```
  [Avatar] Nguyễn Văn An (Quản trị viên)
  ✉️  nguyen.van.an@gmail.com
  ☎️  0912345678 ✓
  📍 Hà Nội, Việt Nam
  ```

### Error State ❌
1. Tắt WiFi/Mobile
2. Kéo xuống (refresh)
3. Thấy: Error icon + Retry button
4. Bật WiFi → Bấm Retry
5. Thấy: Data load lại

## 🎨 UI Features Đã Có

- ✅ Avatar hình đầu người đấy
- ✅ Role badge (màu teal)
- ✅ Email validation (✓ icon nếu format đúng)
- ✅ Phone validation (✓ icon nếu format Việt Nam)
- ✅ Địa chỉ hiển thị
- ✅ Pull-to-refresh
- ✅ Beautiful gradient background

## 🔥 Tiếp Theo: Enable Firebase (Optional)

Nếu muốn dùng Firebase thay vì local data:

### 5 Bước:

**1. Uncomment Firebase init (lib/main.dart):**
```dart
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // ← Uncomment
  runApp(const MyApp());
}
```

**2. Switch to Firebase (lib/screens/home_screen.dart):**
```dart
// Dòng ~25, sửa:
_futureUsers = UserService.fetchUsersFromFirebase();
```

**3. Tạo Firestore:**
- Vào https://console.firebase.google.com
- Project: lythuyet1-32b54
- Firestore Database → Create Collection "users"

**4. Thêm Data:**
- Copy 6 users từ data mẫu
- Paste vào Firestore

**5. Run:**
```bash
flutter pub get
flutter run
```

**Chi tiết**: Xem file `FIREBASE_SETUP.md`

---

## 📚 Các File Quan Trọng

```
lib/
├── main.dart                    ← Entry point (Firebase commented)
├── models/
│   └── user.dart               ← User model + validation
├── services/
│   └── user_service.dart       ← Dữ liệu 6 user
└── screens/
    └── home_screen.dart        ← UI chính
```

---

## 🎓 Yêu Cầu Tiếp Hành

- ✅ AppBar: "TH3 - Đồng Phúc Quân - 1951060938"
- ✅ Loading State: Spinner
- ✅ Success State: 6 user cards
- ✅ Error State: Icon + Retry button
- ✅ Code: Tách rõ (models, services, screens)
- ✅ Try-catch: Có
- ✅ Text ellipsis: Tên/email/địa chỉ dài cắt gọn
- ✅ Phone validation: Định dạng Việt Nam
- ✅ Firebase ready: Code sẵn (commented)

**Tất cả 100% hoàn thành! ✅**

---

## 🧪 Troubleshooting

### Problem: "Timeout / Cannot connect"
**Solution**: Tắt WiFi là bình thường (kiểm tra Error state)

### Problem: "Image not loading"
**Solution**: Dùng Pravatar API (public), thường OK

### Problem: "0 users loaded"
**Solution**: Data là local, phải thấy 6 users

### Problem: "Icons not showing"
**Solution**: Material icons built-in, sẽ hiển thị

---

## ✨ Features

| Feature | Status |
|---------|--------|
| Loading spinner | ✅ |
| User cards | ✅ |
| Avatar images | ✅ |
| Email display | ✅ |
| Phone display | ✅ |
| Address display | ✅ |
| Role badge | ✅ |
| Email validation | ✅ |
| Phone validation | ✅ |
| Error handling | ✅ |
| Retry button | ✅ |
| Pull-to-refresh | ✅ |
| Firebase ready | ✅ |

---

## 📞 Support

- `FIREBASE_SETUP.md` - Firebase chi tiết
- `DATA_MAUUSER_VIETNAM.md` - Data mẫu
- `FIREBASE_STATUS.md` - Status check
- `THAY_DOI_NEWS_TO_USER.md` - Thay đổi

---

**Chạy app thôi! 🚀**

```
flutter run
```

**Expect: 6 user cards hiển thị đẹp lắm!**

# 🔥 Hướng Dẫn Kết Nối Firebase - TH3 User Manager App

Ứng dụng hiện tại đang dùng **data mẫu (local)**. Blog dưới hướng dẫn kết nối **Firebase Firestore** để lấy dữ liệu từ cloud.

---

## ✅ Kiểm Tra Status Firebase

### Firebase Services Có Sẵn:
- ✅ **google-services.json** - Đã tải (Android)
- ✅ **firebase_core ^2.24.0** - Dependencies có sẵn
- ✅ **cloud_firestore ^4.13.0** - Dependencies có sẵn
- ✅ **Project ID**: `lythuyet1-32b54`
- ✅ **Android Plugin**: com.google.gms.google-services (thêm vào gradle)

### Trạng Thái Hiện Tại:
🔴 **Chưa enable Firebase** (dùng data mẫu local)

---

## 🚀 Bước 1: Vào Firebase Console

1. Truy cập: https://console.firebase.google.com
2. Đăng nhập bằng Google account
3. Chọn project: **lythuyet1-32b54** (nếu thấy nhiều project)

---

## 🔐 Bước 2: Tạo Firestore Database

1. Vào menu **Firestore Database**
2. Click **"Create database"** nếu chưa tạo
3. Chế độ: Chọn **"Start in test mode"** (dễ test, sau này sửa rules)
4. Region: Chọn gần Việt Nam nhất (ví dụ: `asia-southeast1` = Singapore)
5. Click **"Create"** → Đợi ~2 phút

---

## 📝 Bước 3: Tạo Collection "users"

### Cách tạo:
1. Ở Firestore Dashboard, click **"Start collection"**
2. Collection ID: **users** (viết thường)
3. Click **"Next"**
4. Document ID: Để trống (auto-generate)
5. Thêm fields theo bảng dưới

### Fields cho mỗi Document:

| Field | Type | Giá Trị Ví Dụ |
|-------|------|---------------|
| `name` | String | "Nguyễn Văn An" |
| `email` | String | "nguyen.van.an@gmail.com" |
| `phone` | String | "0912345678" |
| `avatarUrl` | String | "https://i.pravatar.cc/150?img=1" |
| `role` | String | "Quản trị viên" |
| `address` | String | "Hà Nội, Việt Nam" |
| `createdAt` | Timestamp | (Chọn current timestamp) |

### Add Documents:
1. Click **"Add document"**
2. Điền fields
3. Click **"Save"**
4. Lặp lại cho 6 user (hoặc nhiều hơn)

---

## 💻 Bước 4: Enable Firebase Trong App

### Cách 1: Uncomment Code (Dễ Nhất)

**File**: `lib/main.dart`

Tìm và bỏ comment 4 dòng:
```dart
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
```

Thành:
```dart
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart'; // Bỏ qua nếu chưa tạo

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}
```

**File**: `lib/screens/home_screen.dart`

Tìm dòng:
```dart
_futureUsers = UserService.fetchUsersFromAPI();
```

Thay thành:
```dart
_futureUsers = UserService.fetchUsersFromFirebase();
```

### Cách 2: Tạo firebase_options.dart (Nếu Cần)

Chạy lệnh:
```bash
flutterfire configure
```

Nó sẽ tạo file `lib/firebase_options.dart` tự động.

---

## 🧪 Bước 5: Test Firebase

### Test 1: Chạy App
```bash
flutter pub get
flutter run
```

**Kết quả mong đợi:**
- ✅ App mở bình thường
- ✅ Danh sách user từ Firebase hiển thị
- ✅ Kéo xuống refresh để tải lại

### Test 2: Kiểm Tra Logs
```
I  [firebase_core:firebase_core] Notifying 0 auth listeners
I  [firebase_core:firebase_core] Successfully initia... [Success!]
```

### Test 3: Test Error (Tắt WiFi)
1. Tắt WiFi/Mobile data
2. Mở app hoặc refresh
3. Kết quả: **Error State** hiện lên + nút Retry

---

## 🔒 Bước 6: Cài Đặt Firestore Security Rules (Quan Trọng!)

### Hiện Tại (Test Mode):
- ✅ Ai cũng có thể read/write
- ⚠️ **Không an toàn cho Production**

### Cài Đặt An Toàn Hơn:

1. Vào **Firestore → Rules**
2. Sửa thành:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Cho phép read tất cả (public), write chỉ admin
    match /users/{document=**} {
      allow read: if true;
      allow write: if request.auth != null && request.auth.token.admin == true;
    }
  }
}
```

3. Click **Publish**

---

## 🐛 Troubleshooting

### Problem 1: "Failed to initialize Firebase"
**Giải pháp**: 
- Check google-services.json tồn tại
- Run: `flutter clean` → `flutter pub get` → `flutter run`

### Problem 2: "Cloud Firestore is not available"
**Giải pháp**:
- Vào Firebase Console → Firestore Database
- Check xem database đã tạo chưa
- Xem Rules có block không

### Problem 3: "Timeout - Mất kết nối"
**Giải pháp**:
- Check WiFi/Mobile data
- Firestore database có bị region lock không
- Try đổi region khác

### Problem 4: Không thấy data từ Firebase
**Giải pháp**:
- Check collection name đúng là "users" không
- Check Fields đúng không (case-sensitive)
- Xem có dữ liệu trong collection không

---

## 📊 Data Mẫu Để Copy-Paste

Có thể import JSON vào Firebase:

```json
[
  {
    "name": "Nguyễn Văn An",
    "email": "nguyen.van.an@gmail.com",
    "phone": "0912345678",
    "avatarUrl": "https://i.pravatar.cc/150?img=1",
    "role": "Quản trị viên",
    "address": "Hà Nội, Việt Nam",
    "createdAt": "2024-01-15T08:30:00Z"
  },
  {
    "name": "Trần Thị Bảo",
    "email": "tran.thi.bao@yahoo.com",
    "phone": "0987654321",
    "avatarUrl": "https://i.pravatar.cc/150?img=5",
    "role": "Nhân viên",
    "address": "TP Hồ Chí Minh, Việt Nam",
    "createdAt": "2024-02-20T10:15:00Z"
  }
]
```

---

## ✅ Checklist Firebase Setup

- [ ] Vào Firebase Console
- [ ] Tạo Firestore Database (test mode)
- [ ] Tạo collection "users"
- [ ] Thêm 3-6 documents
- [ ] Uncomment Firebase code trong main.dart
- [ ] Sửa UserService gọi Firebase
- [ ] Run `flutter pub get`
- [ ] Run `flutter run`
- [ ] Test: Xem danh sách từ Firebase
- [ ] Test: Tắt WiFi → Retry
- [ ] Cài Firestore Security Rules

---

## 🎯 Xong!

Nếu thành công:
- ✅ Danh sách user hiển thị từ **Firestore**
- ✅ Avatar tải từ **Pravatar API** (public)
- ✅ App hoạt động offline sau khi cache
- ✅ Retry button bắt được firebase errors

**Chúc bạn thành công! 🚀**

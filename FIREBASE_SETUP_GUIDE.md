# 🔥 HƯỚNG DẪN SETUP FIREBASE FIRESTORE

## ✅ Trạng Thái Firebase

- ✅ **firebase_core** & **cloud_firestore** cài sẵn
- ✅ **firebase_options.dart** đã tạo
- ✅ **main.dart** - Firebase initialized
- ✅ **user_service.dart** - Code Firebase enabled
- ✅ **home_screen.dart** - Dùng `fetchUsersFromFirebase()`

## 📋 Bước Setup

### 1. Vào Firebase Console
```
https://console.firebase.google.com
```

### 2. Chọn Project
- **Project ID**: `lythuyet1-32b54` (đã tạo sẵn)

### 3. Tạo Firestore Database

1. Click menu bên trái → **Firestore Database**
2. Click **Create Database**
3. Chế độ: **Test Mode** (để develop)
4. Location: **asia-southeast1** (Đông Nam Á)
5. Click **Create**

### 4. Tạo Collection `users`

1. Trong Firestore → Click **Start Collection**
2. Collection ID: `users`
3. Click **Next**

### 5. Thêm Documents

Thêm 6 documents với dữ liệu dưới. Mỗi lần:
- Click **Add Document**
- Auto ID hoặc tự đặt (ví dụ: `user1`, `user2`, ...)
- Thêm fields theo form dưới

#### Document 1
```
id: "1" (string)
name: "Nguyễn Văn An" (string)
email: "nguyen.van.an@gmail.com" (string)
phone: "0912345678" (string)
avatarUrl: "https://i.pravatar.cc/150?img=1" (string)
role: "Quản trị viên" (string)
address: "Hà Nội, Việt Nam" (string)
createdAt: 2024-01-15 08:30:00 (timestamp)
```

#### Document 2
```
id: "2" (string)
name: "Trần Thị Bảo" (string)
email: "tran.thi.bao@yahoo.com" (string)
phone: "0987654321" (string)
avatarUrl: "https://i.pravatar.cc/150?img=5" (string)
role: "Nhân viên" (string)
address: "TP Hồ Chí Minh, Việt Nam" (string)
createdAt: 2024-02-20 10:15:00 (timestamp)
```

#### Document 3
```
id: "3" (string)
name: "Lê Văn Cường" (string)
email: "le.van.cuong@outlook.com" (string)
phone: "0923456789" (string)
avatarUrl: "https://i.pravatar.cc/150?img=10" (string)
role: "Kỹ sư" (string)
address: "Đà Nẵng, Việt Nam" (string)
createdAt: 2024-03-05 14:45:00 (timestamp)
```

#### Document 4
```
id: "4" (string)
name: "Phạm Hồng Liên" (string)
email: "pham.hong.lien@gmail.com" (string)
phone: "0934567890" (string)
avatarUrl: "https://i.pravatar.cc/150?img=15" (string)
role: "Nhà thiết kế" (string)
address: "Cần Thơ, Việt Nam" (string)
createdAt: 2024-01-25 09:20:00 (timestamp)
```

#### Document 5
```
id: "5" (string)
name: "Vũ Minh Tuấn" (string)
email: "vu.minh.tuan@hotmail.com" (string)
phone: "0945678901" (string)
avatarUrl: "https://i.pravatar.cc/150?img=20" (string)
role: "Nhà phát triển" (string)
address: "Hải Phòng, Việt Nam" (string)
createdAt: 2024-02-10 11:30:00 (timestamp)
```

#### Document 6
```
id: "6" (string)
name: "Đỗ Tuấn Anh" (string)
email: "do.tuan.anh@gmail.com" (string)
phone: "0956789012" (string)
avatarUrl: "https://i.pravatar.cc/150?img=25" (string)
role: "Chuyên viên" (string)
address: "Biên Hòa, Việt Nam" (string)
createdAt: 2024-03-12 13:40:00 (timestamp)
```

## 🚀 Chạy App

```powershell
flutter run
```

### Kết Quả
- ✅ App sẽ load 6 users từ Firebase Firestore
- ✅ Hiển thị trong ListView cards
- ✅ Nếu network lỗi → Error state + Retry button
- ✅ Pull down để refresh

## ⚠️ Ghi Chú Quan Trọng

### Nếu Firebase chưa sẵn sàng
- App sẽ dùng **data mẫu local** tự động (fallback)
- Vẫn có thể thấy 6 users nhưng từ local memory

### Firestore Rules (Test Mode)
```
allow read, write: if true;
```
Dùng cho test, **ko dùng production**!

### Timeout
- Nếu internet chậm: timeout 10s
- Hiển thị error state
- Bấm "Thử lại" để reload

## 📸 Screenshot Setup

### Firestore Collection
```
Firestore Database
├── users
│   ├── user1 (Nguyễn Văn An)
│   ├── user2 (Trần Thị Bảo)
│   ├── user3 (Lê Văn Cường)
│   ├── user4 (Phạm Hồng Liên)
│   ├── user5 (Vũ Minh Tuấn)
│   └── user6 (Đỗ Tuấn Anh)
```

---

**Hoàn tất Setup Firebase ✅**

Giờ chạy `flutter run` để xem app load được từ Firebase Firestore!

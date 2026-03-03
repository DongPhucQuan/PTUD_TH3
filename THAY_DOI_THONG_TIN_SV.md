# 📝 Hướng Dẫn Thay Đổi Thông Tin Sinh Viên

## ⚠️ Thay Đổi AppBar: TH3 - [Họ Tên] - [Mã SV]

Hiện tại AppBar đang hiển thị: **TH3 - Nguyễn Văn A - 20211234**

Để thay đổi theo thông tin của bạn, làm theo hướng dẫn dưới đây:

---

## 🔧 Bước 1: Mở File `home_screen.dart`

Đường dẫn: `lib/screens/home_screen.dart`

---

## 🔧 Bước 2: Tìm Dòng AppBar

Tìm đoạn code sau (khoảng dòng 32-36):

```dart
AppBar(
  title: const Text(
    'TH3 - Nguyễn Văn A - 20211234',  // ← DÒNG CẦN THAY ĐỔI
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  ),
  centerTitle: true,
  backgroundColor: Colors.blue.shade700,
  elevation: 4,
),
```

---

## 🔧 Bước 3: Thay Đổi Thông Tin

**Thay:** `'TH3 - Nguyễn Văn A - 20211234'`

**Thành:** `'TH3 - [Họ Tên Của Bạn] - [Mã SV Của Bạn]'`

### ✨ Ví Dụ:

| Bạn là | Thời viết |
|--------|-----------|
| Trần Thị B, MSV: 20210567 | `'TH3 - Trần Thị B - 20210567'` |
| Lê Văn C, MSV: 20219876 | `'TH3 - Lê Văn C - 20219876'` |
| Phạm Hồng D, MSV: 20214321 | `'TH3 - Phạm Hồng D - 20214321'` |

---

## ✅ Xong!

Save file (Ctrl+S) → Hot reload (Ctrl+Shift+R hoặc khởi động lại ứng dụng)

AppBar sẽ cập nhật ngay lập tức! 🎉

---

## 💡 Mẹo Thêm

Nếu muốn thay đổi **tên ứng dụng** trong Material App:

**File:** `lib/main.dart`

**Dòng cần thay:** (khoảng dòng 12)
```dart
title: 'TH3 - Product Store',  // Có thể sửa thành tên khác nếu muốn
```

---

**Đó là tất cả! Chúc bạn thành công! 🚀**

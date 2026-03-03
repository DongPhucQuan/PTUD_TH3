# 🚀 QUICK START - TEST ERROR STATE & DATA SOURCE

## 📍 Chạy App

```powershell
cd c:\Users\Admin\flutter_todo_web\th2\bai_lythuyet1\th3
flutter run
```

---

## 💡 Kiểm Tra Nguồn Dữ Liệu

### AppBar sẽ hiển thị:**
```
┌─────────────────────────────────────┐
│ TH3 - Đồng Phúc Quân - 1951060938   │ ← Dòng 1: Tiêu đề + MSV
│ 🌐 Firebase                          │ ← Dòng 2: Source indicator
└─────────────────────────────────────┘
```

### Các trạng thái của Dòng 2:
| Indicator | Ý Nghĩa |
|-----------|---------|
| ⏳ Đang tải... | App đang load dữ liệu |
| 🌐 Firebase | ✅ Load thành công từ Firebase Firestore |
| 💾 Local (Fallback) | ✅ Load từ local (Firebase timeout/lỗi) |
| ⚠️ Error - ... | ❌ Lỗi kết nối (không có dữ liệu) |

---

## 🎯 Test Scenario 1: Normal Load (Firebase Success)

**Setup:**
- Network: ✅ Bình thường
- Firebase: ✅ Đã setup Firestore + collection `users`

**Bước:**
1. Chạy app
2. Chờ 1-2 giây

**Kết quả mong muốn:**
```
Dòng 2: 🌐 Firebase
Body: ListView với 6 users từ Firebase
```

---

## 🎯 Test Scenario 2: Fallback to Local

**Setup:**
- Network: ✅ Bình thường
- Firebase: ❌ Chưa setup hoặc collection `users` trống

**Bước:**
1. Chạy app
2. Chờ 2-3 giây (Firebase timeout)

**Kết quả mong muốn:**
```
Dòng 2: 💾 Local (Fallback)
Body: ListView với 6 users từ local code
```

---

## 🎯 Test Scenario 3: Network Error + Retry ⭐

**Setup:**
- Internet: ❌ Sắp mất mạng
- Firebase: ❌ Ko available

### Option A: Tắt WiFi Thực

**Bước 1 - Chuẩn bị:**
1. Chạy app: `flutter run`
2. App load bình thường (🌐 Firebase hoặc 💾 Local)

**Bước 2 - Trigger Error:**
1. **Tắt WiFi router**
2. Swipe down AppBar để **Pull Refresh**
3. Hoặc mở lại app

**Bước 3 - Quan sát Error:**
```
Dòng 2: ⚠️ Error - Timeout - Mất kết nối
Body: 
  ❌ Icon error
  📝 "Lỗi tải dữ liệu" + "Timeout - Mất kết nối"
  🔄 Nút "Thử lại"
```

**Bước 4 - Retry:**
1. **Bật lại WiFi**
2. Bấm nút **"Thử lại"**
3. App sẽ reload

**Kết quả:**
```
Dòng 2: 🌐 Firebase (hoặc 💾 Local)
Body: ListView 6 users load lại
```

### Option B: Nếu ko muốn tắt WiFi

Thay vào đó, sửa timeout nhỏ trong `lib/services/user_service.dart`:

```dart
// Thay dòng này:
.timeout(const Duration(seconds: 10),

// Thành:
.timeout(const Duration(milliseconds: 100),  // 0.1s → Timeout ngay
```

Sau đó pull refresh sẽ error ngay.

---

## 🧪 Verification Checklist

Trước khi nộp, verify những điều này:

- [ ] **Loading State**: CircularProgressIndicator + text "Đang tải..."
- [ ] **Success State**: ListView 6 users + avatar + email + phone
- [ ] **Error State**: Error icon + message + "Thử lại" button
- [ ] **Data Source Indicator**: AppBar dòng 2 show đúng (Firebase/Local/Error)
- [ ] **Retry Function**: Bấm "Thử lại" → reload dữ liệu
- [ ] **Pull Refresh**: Swipe down → reload (color teal)
- [ ] **Text Ellipsis**: Tên/email/address dài sẽ cắt gọn (…)
- [ ] **Phone Validation**: ✓ icon nếu phone valid (0XXXXXXXXX)
- [ ] **Avatar Load**: Từ Pravatar API

---

## 📸 Expected UI

### Loading State
```
┌─────────────────────┐
│ TH3 - ... - ...     │
│ ⏳ Đang tải...      │
├─────────────────────┤
│                     │
│       ⟲ (spinner)   │
│       Đang tải      │
│  danh sách người... │
│                     │
└─────────────────────┘
```

### Success State
```
┌─────────────────────┐
│ TH3 - ... - ...     │
│ 🌐 Firebase        │
├─────────────────────┤
│ ┌─────────────────┐ │
│ │ [👤] Nguyễn V.A │ │
│ │        Quản trị │ │
│ │ ✉️ mail@g.... │ │
│ │ ☎️ 0912... ✓   │ │
│ │ 📍 Hà Nội, VN  │ │
│ └─────────────────┘ │
│ ┌─────────────────┐ │
│ │ [👤] Trần T.B   │ │ (scroll)
│ │ ... (5 more)    │ │
│ └─────────────────┘ │
└─────────────────────┘
```

### Error State
```
┌─────────────────────┐
│ TH3 - ... - ...     │
│ ⚠️ Error - Timeout │
├─────────────────────┤
│                     │
│       ❌ (error)    │
│   Lỗi tải dữ liệu   │
│   Timeout - Mất...  │
│                     │
│    [ 🔄 Thử lại ]   │
│                     │
└─────────────────────┘
```

---

## 💬 Demo Script (Cho Giáo Viên)

**Thời gian: ~2 phút**

```
1. "Chào cô! Đây là app User Management của em."
   → Chạy: flutter run

2. "AppBar dòng 1 là TH3 - Họ tên - MSV theo yêu cầu."
   → Chỉ vào: "TH3 - Đồng Phúc Quân - 1951060938"

3. "Dòng 2 show nguồn dữ liệu. Hiện tại đang tải..."
   → Chỉ vào: ⏳ Đang tải...

4. (Chờ 1-2s) "6 users load từ Firebase Firestore!"
   → Chỉ vào: 🌐 Firebase
   → Hiển thị ListView 6 users

5. "Giờ tôi tắt WiFi để demo error state..."
   → Tắt WiFi router / Airplane mode

6. (Pull refresh) "Lỗi kết nối, hiển thị error UI..."
   → Chỉ vào: ⚠️ Error + "Lỗi tải dữ liệu"
   → Nút "Thử lại" sáng sủa

7. "Bấm Thử lại + bật WiFi..."
   → Bật WiFi + Bấm "Thử lại"
   → App reload: 🌐 Firebase hoặc 💾 Local

8. "Em cũng test được khi Firebase chưa setup,
    app tự fallback sang local data không lỗi."
```

---

## 🎓 Kết Luận

✅ **Đủ yêu cầu đề bài:**
- ✓ Load dữ liệu từ Firebase/API
- ✓ 3 trạng thái: Loading, Success, Error
- ✓ Nút Retry hoạt động
- ✓ Indicator nguồn dữ liệu
- ✓ Pull-to-refresh
- ✓ Code tách rõ (models/services/screens)
- ✓ Try-catch bắt lỗi

**Ready để nộp! 🚀**

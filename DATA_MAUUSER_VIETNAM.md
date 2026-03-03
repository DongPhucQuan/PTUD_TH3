# 📋 DATA MẪU USER - Chuẩn Chỉnh Việt Nam

Dữ liệu này có thể copy-paste trực tiếp vào Firestore.

## Data Set 1: Dữ Liệu Hoàn Chỉnh (6 User)

### User 1: Nguyễn Văn An
```
name: Nguyễn Văn An
email: nguyen.van.an@gmail.com
phone: 0912345678
avatarUrl: https://i.pravatar.cc/150?img=1
role: Quản trị viên
address: Hà Nội, Việt Nam
createdAt: 2024-01-15T08:30:00Z
```

### User 2: Trần Thị Bảo
```
name: Trần Thị Bảo
email: tran.thi.bao@yahoo.com
phone: 0987654321
avatarUrl: https://i.pravatar.cc/150?img=5
role: Nhân viên
address: TP Hồ Chí Minh, Việt Nam
createdAt: 2024-02-20T10:15:00Z
```

### User 3: Lê Văn Cường
```
name: Lê Văn Cường
email: le.van.cuong@outlook.com
phone: 0923456789
avatarUrl: https://i.pravatar.cc/150?img=10
role: Kỹ sư
address: Đà Nẵng, Việt Nam
createdAt: 2024-03-05T14:45:00Z
```

### User 4: Phạm Hồng Liên
```
name: Phạm Hồng Liên
email: pham.hong.lien@gmail.com
phone: 0934567890
avatarUrl: https://i.pravatar.cc/150?img=15
role: Nhà thiết kế
address: Cần Thơ, Việt Nam
createdAt: 2024-01-25T09:20:00Z
```

### User 5: Vũ Minh Tuấn
```
name: Vũ Minh Tuấn
email: vu.minh.tuan@hotmail.com
phone: 0945678901
avatarUrl: https://i.pravatar.cc/150?img=20
role: Nhà phát triển
address: Hải Phòng, Việt Nam
createdAt: 2024-02-10T11:30:00Z
```

### User 6: Đỗ Tuấn Anh
```
name: Đỗ Tuấn Anh
email: do.tuan.anh@gmail.com
phone: 0956789012
avatarUrl: https://i.pravatar.cc/150?img=25
role: Chuyên viên
address: Biên Hòa, Việt Nam
createdAt: 2024-03-12T13:40:00Z
```

---

## 📜 Format JSON (Nếu Import Hàng Loạt)

```json
{
  "users": [
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
    },
    {
      "name": "Lê Văn Cường",
      "email": "le.van.cuong@outlook.com",
      "phone": "0923456789",
      "avatarUrl": "https://i.pravatar.cc/150?img=10",
      "role": "Kỹ sư",
      "address": "Đà Nẵng, Việt Nam",
      "createdAt": "2024-03-05T14:45:00Z"
    },
    {
      "name": "Phạm Hồng Liên",
      "email": "pham.hong.lien@gmail.com",
      "phone": "0934567890",
      "avatarUrl": "https://i.pravatar.cc/150?img=15",
      "role": "Nhà thiết kế",
      "address": "Cần Thơ, Việt Nam",
      "createdAt": "2024-01-25T09:20:00Z"
    },
    {
      "name": "Vũ Minh Tuấn",
      "email": "vu.minh.tuan@hotmail.com",
      "phone": "0945678901",
      "avatarUrl": "https://i.pravatar.cc/150?img=20",
      "role": "Nhà phát triển",
      "address": "Hải Phòng, Việt Nam",
      "createdAt": "2024-02-10T11:30:00Z"
    },
    {
      "name": "Đỗ Tuấn Anh",
      "email": "do.tuan.anh@gmail.com",
      "phone": "0956789012",
      "avatarUrl": "https://i.pravatar.cc/150?img=25",
      "role": "Chuyên viên",
      "address": "Biên Hòa, Việt Nam",
      "createdAt": "2024-03-12T13:40:00Z"
    }
  ]
}
```

---

## ℹ️ Ghi Chú

**Định dạng Số Điện Thoại Việt Nam:**
- Bắt đầu bằng `0`
- Diễn viên: `0[XX]XXXXXXX` (10-11 chữ số)
- Ví dụ: `0912345678`, `0987654321`

**Avatar URLs:**
- Dùng `https://i.pravatar.cc/150?img=N` (N = 0-70)
- Không cần API key
- Tự động random avatar khác nhau

**Email Providers Phổ Biến Việt Nam:**
- gmail.com
- yahoo.com
- outlook.com
- hotmail.com

**Roles Gợi Ý:**
- Quản trị viên
- Nhân viên
- Kỹ sư
- Nhà thiết kế
- Nhà phát triển
- Chuyên viên
- Ủy ban

---

## 🔧 Cách Thêm Vào Firestore

### Cách 1: Thêm Thủ Công
1. Vào Firestore Dashboard
2. Click "Add document"
3. Copy-paste từng field từ data trên
4. Click "Save"

### Cách 2: Bulk Import
1. Download dữ liệu JSON
2. Firebase Console → Firestore → (3 dots) → Import Collection
3. Select file JSON → Import

### Cách 3: Dùng Firebase CLI
```bash
# Cài đặt Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Import data
firebase firestore:imports data-export.json
```

---

## ✅ Validation Rules

Ứng dụng sẽ check:

### Email Validation:
```
Regex: ^[^\s@]+@[^\s@]+\.[^\s@]+$
Ví dụ: ✅ user@gmail.com
       ❌ user@gmail
       ❌ user gmail.com
```

### Phone Validation:
```
Regex: ^0[0-9]{9,10}$
Ví dụ: ✅ 0912345678 (10 chữ số)
       ✅ 09123456789 (11 chữ số)
       ❌ 912345678 (không có 0 đầu)
       ❌ 08123 (quá ít chữ số)
```

---

## 🎯 Xong!

Copy data trên → Paste vào Firestore → App sẽ tự load! 🚀

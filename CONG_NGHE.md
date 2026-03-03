# 🔬 Công Nghệ & Architecture Sử Dụng

## 🏗️ Architecture Pattern

### Model-View-Service (MVS)

Dự án sử dụng **MVS pattern** - một simplification của **MVVM** hoặc **MVC**:

```
Model (product.dart)
  ↓ (serialize/deserialize)
Service (product_service.dart)  
  ↓ (async calls)
Screen/View (home_screen.dart)
  ↓ (build UI)
User Interface
```

### Ưu Điểm
✅ **Dễ test**: Model, Service có thể test độc lập  
✅ **Dễ bảo trì**: Code tách rõ ràng theo layer  
✅ **Dễ scale**: Thêm features mà không phá huỷ code cũ  
✅ **Readable**: Ai đọc code cũng hiểu logic  

---

## 🚀 Technologies

### 1️⃣ Flutter Framework
- **Version**: ^3.10.8+
- **Language**: Dart
- **Paradigm**: Reactive UI with StatefulWidget

### 2️⃣ Data Fetching

#### Option A: HTTP Package (Hiện Tại)
```dart
import 'package:http/http.dart' as http;

// Calls JSON API
final response = await http.get(Uri.parse(url));
final jsonData = jsonDecode(response.body);
```

| Pros | Cons |
|------|------|
| Nhẹ, dễ dùng | Phải handle JSON thủ công |
| Không cần setup | Phải quản lý connection |
| Tốc độ nhanh | Không real-time |

#### Option B: Firebase Firestore (Ready)
```dart
import 'package:cloud_firestore/cloud_firestore.dart';

// Calls Firestore
final snapshot = await _firestore.collection('products').get();
```

| Pros | Cons |
|------|------|
| Real-time updates | Phải setup Firebase |
| Auto-sync data | Phí bandwidth |
| Offline support | Learning curve |

---

## 🔄 Async Programming

### FutureBuilder Pattern

```dart
FutureBuilder<List<Product>>(
  future: _futureProducts,  // Future object
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      // Loading state
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      // Error state
      return ErrorWidget();
    }
    if (snapshot.hasData) {
      // Success state
      return ListView(...);
    }
  }
)
```

### Vì Sao Dùng FutureBuilder?
✅ IntuitIve: State được quản lý tự động  
✅ Reactive: UI update khi Future complete  
✅ Built-in: Không cần plugin thêm  
✅ Readable: Code dễ hiểu flow  

### Alternative (Nếu Muốn)
- **Provider**: State management library
- **Riverpod**: Next-gen Provider
- **GetX**: All-in-one solution
- **BLoC**: Event-driven pattern

(Dự án này KHÔNG dùng để keep it simple)

---

## 💾 Data Model

### Product Class

```dart
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int quantity;
}
```

### Serialization (JSON ↔ Dart Object)

```dart
// JSON → Dart (Deserialization)
factory Product.fromJson(Map<String, dynamic> json, String docId) {
  return Product(
    id: docId,
    name: json['name'] ?? 'No name',
    // ...
  );
}

// Dart → JSON (Serialization)
Map<String, dynamic> toJson() {
  return {
    'name': name,
    'description': description,
    // ...
  };
}
```

### Tại Sao Cần Serialization?
- API trả JSON → Phải convert thành Dart object
- Firebase cũng trả Map → Cần convert
- Dễ validate data
- Type-safe

---

## 🎨 UI/Widget Breakdown

### Widget Tree

```
Scaffold
├─ AppBar (title: "TH3 - [Tên] - [MSV]")
└─ FutureBuilder<List<Product>>
   ├─ Loading: Center + CircularProgressIndicator
   ├─ Error: Center + Icon + Text + ElevatedButton
   └─ Success: ListView.builder
      └─ Card (ProductCard widget)
         ├─ ClipRRect (Image)
         ├─ Column
         │  ├─ Text (name)
         │  ├─ Text (description)
         │  └─ Row
         │     ├─ Text (price)
         │     └─ Container (quantity badge)
         └─ ...
```

### Key UI Patterns

#### 1. Overflow Handling
```dart
Text(
  product.name,
  maxLines: 1,
  overflow: TextOverflow.ellipsis,  // "Long text..." instead of wrap
)
```

#### 2. Responsive Layout
```dart
Row(
  children: [
    Image(width: 80, height: 80),
    Expanded(
      child: Column(...),  // Takes remaining space
    )
  ]
)
```

#### 3. Pull-to-Refresh
```dart
RefreshIndicator(
  onRefresh: () async {
    _retryLoadProducts();
    await Future.delayed(Duration(seconds: 1));
  },
  child: ListView(...),
)
```

---

## ⚡ Performance Considerations

### 1. Image Loading
```dart
Image.network(
  product.imageUrl,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.image_not_supported);
  },
)
```
- Network images load asynchronously
- `errorBuilder` prevents crash nếu URL invalid

### 2. ListView Efficiency
```dart
ListView.builder(
  itemBuilder: (context, index) { ... },  // Lazy loading, không build all items
  itemCount: products.length,
)
```
- `ListView.builder` chỉ build visible items
- Tiết kiệm memory vs `ListView(...children: [])`

### 3. Timeout Protection
```dart
.timeout(
  Duration(seconds: 10),
  onTimeout: () => throw Exception('Timeout'),
)
```
- Prevent app hang nếu network chậm
- Throws exception → caught by try-catch

---

## 🔐 Error Handling Strategy

### Layers of Error Handling

```
Level 1: Service Layer
├─ HTTP request timeout
├─ Invalid status code (404, 500)
└─ JSON parse error
    └─ Catch → throw Exception('Lỗi gọi API: $e')

Level 2: FutureBuilder
├─ snapshot.hasError detected
└─ Render ErrorWidget with message
    └─ Retry button calls _loadProducts() again

Level 3: User Recovery
└─ Bấm "Thử lại" → Back to Loading state
    └─ Success hoặc Error again
```

### Error Message Flow

```
API Error → Service catches → Exception thrown
    ↓
FutureBuilder detects error → snapshot.hasError = true
    ↓
Error widget rendered with exception message
    ↓
User bấm "Thử lại"
    ↓
_loadProducts() called → setState() → Rebuild
    ↓
Back to Loading state → Retry call
```

---

## 🔌 API Integration Points

### Current: JSONPlaceholder

```
GET https://jsonplaceholder.typicode.com/posts
Response:
[
  {
    "userId": 1,
    "id": 1,
    "title": "...",
    "body": "..."
  },
  ...
]
```

Map to Product:
- `id` → `product.id`
- `title` → `product.name` (generated)
- `body` → `product.description`
- `price` → Generated (`id * 15000`)
- `imageUrl` → Generated placeholder
- `quantity` → Generated

### Untuk Integrate Real API

Chỉ cần sửa:
1. URL endpoint
2. JSON field names
3. Mapping logic

```dart
static Future<List<Product>> fetchProductsFromRealAPI() async {
  final response = await http.get(Uri.parse('YOUR_API_URL'));
  final List<dynamic> jsonData = jsonDecode(response.body);
  
  return jsonData.map((item) {
    return Product(
      id: item['id_field'].toString(),
      name: item['name_field'],
      // Map other fields...
    );
  }).toList();
}
```

---

## 📦 Dependencies Explained

| Package | Version | Dùng Cho | Size |
|---------|---------|----------|------|
| `http` | ^1.1.0 | API calls | ~50KB |
| `firebase_core` | ^2.24.0 | FirebaseInit | ~2MB |
| `cloud_firestore` | ^4.13.0 | Firestore DB | ~3MB |
| `flutter` | ^3.10.8 | Framework | Baked-in |

### Total App Size
- Release build: ~15-20MB (Android)
- Debug build: ~100MB (with symbols)

---

## 🎯 Best Practices Implemented

✅ **SOLID Principles**:
- **S**ingle Responsibility: Mỗi file có 1 responsibility
- **O**pen/Closed: Dễ thêm feature (open for extension)
- **L**iskov Substitution: Interfaces consistent
- **I**nterface Segregation: Small focused classes
- **D**ependency Inversion: Service abstraction

✅ **Dart/Flutter Best Practices**:
- `const` constructor whereever possible
- Proper null safety dengan `??`, `required`
- Meaningful variable names
- Comments trên non-obvious code
- Async/await instead of callbacks

✅ **UI Best Practices**:
- Material Design 3
- Proper spacing/padding
- Responsive to screen size
- Accessible text colors
- Error states handled

---

## 🔮 Upgrade Paths

### Upgrade 1: Add Search
```dart
TextFormField(
  onChanged: (query) => setState(() => _searchQuery = query),
)
// Filter: products.where((p) => p.name.contains(_searchQuery)).toList()
```

### Upgrade 2: Add Detail Page
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => ProductDetailScreen(product)),
)
```

### Upgrade 3: Add Pagination
```dart
// Use .limit(20).offset((page-1)*20) in Firestore
final snapshot = await _firestore
    .collection('products')
    .limit(20)
    .offset((page - 1) * 20)
    .get();
```

### Upgrade 4: Implement State Management
```dart
// Use Provider pattern
final productsProvider = FutureProvider((ref) {
  return await ProductService.fetchProductsFromAPI();
});
```

---

**Hiểu rõ công nghệ = Viết code tốt hơn! 🚀**

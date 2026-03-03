import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:th3/models/product.dart';

class ProductService {
  /// Gọi dữ liệu sản phẩm từ Public API (JSONPlaceholder)
  /// Đây là phiên bản test trước khi kết nối Firebase
  static Future<List<Product>> fetchProductsFromAPI() async {
    try {
      // Sử dụng JSONPlaceholder API để test
      // Trong thực tế, bạn sẽ thay thế bằng URL API của mình
      final response =
          await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'))
              .timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw Exception('Timeout - Mất kết nối mạng'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        // Map JSON thành danh sách Product
        List<Product> products = jsonData.map((item) {
          return Product(
            id: item['id'].toString(),
            name: 'Sản phẩm ${item['id']}',
            description: item['body'],
            price: (item['id'] * 15000).toDouble(), // Giá giả lập
            imageUrl:
                'https://via.placeholder.com/200?text=Product+${item['id']}',
            quantity: (item['id'] % 10) + 1,
          );
        }).toList();

        return products;
      } else {
        throw Exception('Lỗi kết nối: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi gọi API: $e');
    }
  }

  /// Gọi dữ liệu từ Firebase Firestore
  /// HƯỚNG DẪN SETUP:
  /// 1. Vào Firebase Console (https://console.firebase.google.com)
  /// 2. Tạo project mới hoặc chọn project có sẵn
  /// 3. Vào Firestore Database và tạo collection "products"
  /// 4. Thêm documents với các field: name, description, price, imageUrl, quantity
  /// 5. Setup Firebase cho Flutter theo hướng dẫn chính thức
  static Future<List<Product>> fetchProductsFromFirebase() async {
    try {
      // Import cloud_firestore để sử dụng
      // import 'package:cloud_firestore/cloud_firestore.dart';

      // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      // final QuerySnapshot snapshot = await _firestore
      //     .collection('products')
      //     .get()
      //     .timeout(const Duration(seconds: 10),
      //         onTimeout: () => throw Exception('Timeout'));

      // List<Product> products = snapshot.docs.map((doc) {
      //   return Product.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      // }).toList();

      // return products;

      // Tạm thời trả về danh sách trống để tránh lỗi
      throw Exception(
          'Firebase chưa được cấu hình. Vui lòng follow hướng dẫn setup.');
    } catch (e) {
      throw Exception('Lỗi Firebase: $e');
    }
  }

  /// Thêm sản phẩm mới (cho Firebase)
  // static Future<void> addProduct(Product product) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('products')
  //         .add(product.toJson());
  //   } catch (e) {
  //     throw Exception('Lỗi thêm sản phẩm: $e');
  //   }
  // }
}

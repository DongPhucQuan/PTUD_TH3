import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:th3/models/user.dart';

class UserService {
  /// Data mẫu User Việt Nam chuẩn chỉnh
  static final List<Map<String, dynamic>> sampleUserData = [
    {
      'id': '1',
      'name': 'Nguyễn Văn An',
      'email': 'nguyen.van.an@gmail.com',
      'phone': '0912345678',
      'avatarUrl':
          'https://i.pravatar.cc/150?img=1',
      'role': 'Quản trị viên',
      'address': 'Hà Nội, Việt Nam',
      'createdAt': '2024-01-15T08:30:00Z',
    },
    {
      'id': '2',
      'name': 'Trần Thị Bảo',
      'email': 'tran.thi.bao@yahoo.com',
      'phone': '0987654321',
      'avatarUrl':
          'https://i.pravatar.cc/150?img=5',
      'role': 'Nhân viên',
      'address': 'TP Hồ Chí Minh, Việt Nam',
      'createdAt': '2024-02-20T10:15:00Z',
    },
    {
      'id': '3',
      'name': 'Lê Văn Cường',
      'email': 'le.van.cuong@outlook.com',
      'phone': '0923456789',
      'avatarUrl':
          'https://i.pravatar.cc/150?img=10',
      'role': 'Kỹ sư',
      'address': 'Đà Nẵng, Việt Nam',
      'createdAt': '2024-03-05T14:45:00Z',
    },
    {
      'id': '4',
      'name': 'Phạm Hồng Liên',
      'email': 'pham.hong.lien@gmail.com',
      'phone': '0934567890',
      'avatarUrl':
          'https://i.pravatar.cc/150?img=15',
      'role': 'Nhà thiết kế',
      'address': 'Cần Thơ, Việt Nam',
      'createdAt': '2024-01-25T09:20:00Z',
    },
    {
      'id': '5',
      'name': 'Vũ Minh Tuấn',
      'email': 'vu.minh.tuan@hotmail.com',
      'phone': '0945678901',
      'avatarUrl':
          'https://i.pravatar.cc/150?img=20',
      'role': 'Nhà phát triển',
      'address': 'Hải Phòng, Việt Nam',
      'createdAt': '2024-02-10T11:30:00Z',
    },
    {
      'id': '6',
      'name': 'Đỗ Tuấn Anh',
      'email': 'do.tuan.anh@gmail.com',
      'phone': '0956789012',
      'avatarUrl':
          'https://i.pravatar.cc/150?img=25',
      'role': 'Chuyên viên',
      'address': 'Biên Hòa, Việt Nam',
      'createdAt': '2024-03-12T13:40:00Z',
    },
  ];

  /// Lấy danh sách user từ API (hiện tại dùng data mẫu)
  static Future<List<User>> fetchUsersFromAPI() async {
    try {
      // Mô phỏng delay mạng
      await Future.delayed(const Duration(seconds: 1));

      // Trả về data mẫu
      List<User> userList = sampleUserData.map((item) {
        return User(
          id: item['id'],
          name: item['name'],
          email: item['email'],
          phone: item['phone'],
          avatarUrl: item['avatarUrl'],
          role: item['role'],
          address: item['address'],
          createdAt: DateTime.parse(item['createdAt']),
        );
      }).toList();

      return userList;
    } catch (e) {
      throw Exception('Lỗi gọi API: $e');
    }
  }

  /// Lấy danh sách user từ Firebase Firestore
  /// HƯỚNG DẪN SETUP FIREBASE:
  /// 
  /// 1. Vào https://console.firebase.google.com
  /// 
  /// 2. Chọn project: lythuyet1-32b54 (đã tạo sẵn)
  /// 
  /// 3. Vào Firestore Database → Tạo database chế độ test
  /// 
  /// 4. Tạo collection "users" 
  /// 
  /// 5. Thêm documents với các field:
  ///    - name (string): "Tên người dùng"
  ///    - email (string): "test@gmail.com"
  ///    - phone (string): "0912345678" (định dạng Việt Nam)
  ///    - avatarUrl (string): "https://i.pravatar.cc/..."
  ///    - role (string): "Quản trị viên" / "Nhân viên" / etc
  ///    - address (string): "Địa chỉ tại Việt Nam"
  ///    - createdAt (timestamp): Ngày tạo
  /// 
  /// 6. Uncomment đoạn code dưới để enable Firebase
  /// Tự động thêm sample data vào Firestore nếu trống
  static Future<void> _populateSampleData() async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final batch = _firestore.batch();

      print('⚙️ Populating sample data into Firestore...');

      for (var item in sampleUserData) {
        final docRef = _firestore.collection('users').doc('user${item['id']}');
        batch.set(docRef, {
          'name': item['name'],
          'email': item['email'],
          'phone': item['phone'],
          'avatarUrl': item['avatarUrl'],
          'role': item['role'],
          'address': item['address'],
          'createdAt': DateTime.parse(item['createdAt']),
        });
      }

      await batch.commit();
      print('✅ Sample data added successfully');
    } catch (e) {
      print('⚠️ Error populating data: $e');
      rethrow;
    }
  }

  static Future<List<User>> fetchUsersFromFirebase() async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;

      final QuerySnapshot snapshot = await _firestore
          .collection('users')
          .orderBy('createdAt', descending: true)
          .limit(50)
          .get(const GetOptions(source: Source.server))
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw Exception('Timeout - Mất kết nối'));

      print('📊 Firestore docs count: ${snapshot.docs.length}');

      // Nếu collection trống, tự động thêm sample data
      if (snapshot.docs.isEmpty) {
        print('⚠️ Collection users trống - auto-populating sample data...');
        await _populateSampleData();
        
        // Gọi lại query sau khi thêm dữ liệu
        final newSnapshot = await _firestore
            .collection('users')
            .orderBy('createdAt', descending: true)
            .limit(50)
            .get(const GetOptions(source: Source.server));

        List<User> userList = newSnapshot.docs.map((doc) {
          print('📄 Doc: ${doc.id} - ${doc.data()}');
          return User.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();

        print('✅ Loaded ${userList.length} users from Firebase (auto-populated)');
        return userList;
      }

      List<User> userList = snapshot.docs.map((doc) {
        print('📄 Doc: ${doc.id} - ${doc.data()}');
        return User.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      print('✅ Loaded ${userList.length} users from Firebase');
      return userList;
    } on FirebaseException catch (e) {
      print('❌ FirebaseException: ${e.message}');
      throw Exception('Lỗi Firebase: ${e.message}');
    } catch (e) {
      print('❌ Exception: $e');
      throw Exception('Lỗi Firebase: $e');
    }
  }

  /// Thêm user mới vào Firebase
  // static Future<void> addUser(User user) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .add(user.toJson());
  //   } catch (e) {
  //     throw Exception('Lỗi thêm user: $e');
  //   }
  // }

  /// Cập nhật thông tin user
  // static Future<void> updateUser(String userId, User user) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userId)
  //         .update(user.toJson());
  //   } catch (e) {
  //     throw Exception('Lỗi cập nhật user: $e');
  //   }
  // }
}

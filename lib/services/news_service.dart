import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:th3/models/news.dart';

class NewsService {
  /// Dữ liệu tin tức Iran-Mỹ mẫu với hình ảnh thực tế
  static final List<Map<String, dynamic>> sampleNewsData = [
    {
      'id': '1',
      'title': 'Căng thẳng Iran-Mỹ Gia Tăng Sau Cuộc Tấn Công',
      'description':
          'Iran tuyên bố sẽ trả đũa sau các cuộc tấn công không người lái của Mỹ',
      'content':
          'Bộ Ngoại giao Iran ngày hôm nay công bố tuyên bố mạnh mẽ về việc sẽ trả đũa các hành động của Mỹ. Theo các nhà phân tích quốc tế, tình hình có thể leo thang trong những tuần tới.',
      'imageUrl':
          'https://images.unsplash.com/photo-1569163139394-de4798aa62b2?w=600&fit=crop',
      'source': 'BBC News',
      'publishedAt': '2026-03-02T14:30:00Z',
      'views': 15420,
    },
    {
      'id': '2',
      'title': 'Mỹ Triển Khai Thêm Lực Lượng Chi Viện Ở Vùng Vịnh',
      'description':
          'Tàu sân bay USS Eisenhower được lệnh tiến vào Vùng Vịnh để tăng cường sức mạnh quân sự',
      'content':
          'Pentagon xác nhận đã ra lệnh cho tàu sân bay USS Eisenhower tới Vùng Vịnh để hỗ trợ các đồng minh. Động thái này được xem là phản ứng trực tiếp đối với việc Iran tăng cường hoạt động quân sự.',
      'imageUrl':
          'https://images.unsplash.com/photo-1559233527-3e75b68e1b3d?w=600&fit=crop',
      'source': 'Reuters',
      'publishedAt': '2026-03-01T10:15:00Z',
      'views': 28650,
    },
    {
      'id': '3',
      'title': 'Anh-Mỹ Kêu Gọi Hội Đàm Để Giảm Căng Thẳng',
      'description':
          'Cả Anh và Mỹ đều cho rằng đối thoại là cách tốt nhất để giải quyết khủng hoảng hiện tại',
      'content':
          'Tại cuộc họp báo chung ngày hôm nay, các nhà lãnh đạo Anh và Mỹ khẳng định cam kết thúc đẩy các cuộc thương lượng. Phía Europe cũng tỏ ra quan ngại về tình hình căng thẳng leo thang.',
      'imageUrl':
          'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=600&fit=crop',
      'source': 'AP News',
      'publishedAt': '2026-02-28T16:45:00Z',
      'views': 9876,
    },
    {
      'id': '4',
      'title': 'Liên Hợp Quốc Cảnh Báo Về Nguy Cơ Xung Đột Khu Vực',
      'description':
          'Tổng thư ký LHQ bày tỏ lo ngại sâu sắc về tình hình tại Trung Đông',
      'content':
          'Tại phiên họp của Hội Đồng Bảo An, ông António Guterres cảnh báo rằng nếu không có can thiệp kịp thời, nguy cơ xung đột khu vực là rất cao. Các quốc gia Ả Rập cũng gửi lời kêu gọi khẩn cấp.',
      'imageUrl':
          'https://images.unsplash.com/photo-1552664730-d307ca884978?w=600&fit=crop',
      'source': 'UN News',
      'publishedAt': '2026-02-27T09:30:00Z',
      'views': 12340,
    },
    {
      'id': '5',
      'title': 'Giá Dầu Tăng Vọt Sau Tin Tức Về Căng Thẳng Mỹ-Iran',
      'description':
          'Thị trường dầu thô toàn cầu phản ứng mạnh với những lo ngại về nguồn cung',
      'content':
          'Giá dầu Brent tăng lên 95 USD/thùng - mức cao nhất trong 6 tháng qua. Các chuyên gia dự báo giá sẽ tiếp tục tăng nếu tình hình tiếp tục leo thang. Các quốc gia sản xuất dầu đang theo dõi tình hình chặt chẽ.',
      'imageUrl':
          'https://images.unsplash.com/photo-1560702846-ba378fa921b7?w=600&fit=crop',
      'source': 'Financial Times',
      'publishedAt': '2026-02-26T13:20:00Z',
      'views': 34560,
    },
    {
      'id': '6',
      'title': 'Các Nước Láng Giềng Qatar, UAE Lo Ngại Cuộc Khủng Hoảng',
      'description':
          'Các nước khác trong khu vực bày tỏ quan ngại về tác động của cuộc xung đột tiềm ẩn',
      'content':
          'Qatar và UAE đã bắt đầu tăng cường các biện pháp phòng chống khủng hoảng. Cả hai quốc gia này đều phụ thuộc lớn vào thương mại quốc tế và ổn định khu vực để phát triển kinh tế.',
      'imageUrl':
          'https://images.unsplash.com/photo-1511632765486-a01980e01a18?w=600&fit=crop',
      'source': 'Middle East Eye',
      'publishedAt': '2026-02-25T11:00:00Z',
      'views': 7654,
    },
  ];

  /// Lấy tin tức từ API (hiện tại dùng dữ liệu mẫu)
  static Future<List<News>> fetchNewsFromAPI() async {
    try {
      // Mô phỏng delay mạng
      await Future.delayed(const Duration(seconds: 2));

      // Trả về dữ liệu mẫu Iran-Mỹ
      List<News> newsList = sampleNewsData.map((item) {
        return News(
          id: item['id'],
          title: item['title'],
          description: item['description'],
          content: item['content'],
          imageUrl: item['imageUrl'],
          source: item['source'],
          publishedAt: DateTime.parse(item['publishedAt']),
          views: item['views'],
        );
      }).toList();

      return newsList;
    } catch (e) {
      throw Exception('Lỗi gọi API: $e');
    }
  }

  /// Lấy tin tức từ Firebase Firestore
  /// HƯỚNG DẪN:
  /// 1. Vào Firebase Console: https://console.firebase.google.com
  /// 2. Mở project: lythuyet1-32b54
  /// 3. Vào Firestore Database
  /// 4. Tạo collection "news"
  /// 5. Thêm documents với các field: title, description, content, imageUrl, source, publishedAt, views
  static Future<List<News>> fetchNewsFromFirebase() async {
    try {
      // Bỏ comment 2 dòng dưới để enable Firebase:
      // import 'package:cloud_firestore/cloud_firestore.dart';
      // import 'package:firebase_core/firebase_core.dart';

      // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      // final QuerySnapshot snapshot = await _firestore
      //     .collection('news')
      //     .orderBy('publishedAt', descending: true)
      //     .limit(20)
      //     .get()
      //     .timeout(const Duration(seconds: 10),
      //         onTimeout: () => throw Exception('Timeout'));

      // List<News> newsItems = snapshot.docs.map((doc) {
      //   return News.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      // }).toList();

      // return newsItems;

      throw Exception(
          'Firebase chưa được enable. Follow hướng dẫn trong comment.');
    } catch (e) {
      throw Exception('Lỗi Firebase: $e');
    }
  }

  /// Thêm tin tức mới vào Firebase
  // static Future<void> addNews(News news) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('news')
  //         .add(news.toJson());
  //   } catch (e) {
  //     throw Exception('Lỗi thêm tin tức: $e');
  //   }
  // }
}

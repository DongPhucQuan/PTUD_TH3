import 'package:flutter/material.dart';
import 'package:th3/models/user.dart';
import 'package:th3/services/user_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<User>> _futureUsers;
  String _dataSource = 'Chưa load'; // Tracking source: Firebase / Local / Error

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  /// Hàm gọi dữ liệu user từ Firebase (server-only)
  void _loadUsers() {
    setState(() {
      _dataSource = '⏳ Đang tải...';
      _futureUsers = UserService.fetchUsersFromFirebase().then((users) {
        setState(() {
          _dataSource = '🌐 Firebase';
        });
        return users;
      }).catchError((error) {
        setState(() {
          _dataSource = '⚠️ Error - ${error.toString().split(':').last.trim()}';
        });
        throw error;
      });
    });
  }

  /// Hàm xử lý khi người dùng bấm nút Retry
  void _retryLoadUsers() {
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'TH3 - Đồng Phúc Quân - 1951060938',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              _dataSource,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.teal.shade700,
        elevation: 4,
      ),
      body: FutureBuilder<List<User>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          // ===== TRẠNG THÁI ĐANG TẢI (LOADING) =====
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.teal.shade700),
                    strokeWidth: 4,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Đang tải danh sách người dùng...',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          // ===== TRẠNG THÁI LỖI (ERROR) =====
          if (snapshot.hasError) {
            String errorMsg = snapshot.error.toString();
            if (errorMsg.contains('Exception:')) {
              errorMsg = errorMsg.replaceAll('Exception: ', '');
            }
            
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade700,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const Text(
                          'Lỗi tải dữ liệu',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          errorMsg,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _retryLoadUsers,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Thử lại'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade700,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          // ===== TRẠNG THÁI THÀNH CÔNG (SUCCESS) =====
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final userList = snapshot.data!;
            return RefreshIndicator(
              onRefresh: () async {
                _retryLoadUsers();
                await Future.delayed(const Duration(seconds: 1));
              },
              color: Colors.teal.shade700,
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  final user = userList[index];
                  return _buildUserCard(user);
                },
              ),
            );
          }

          // ===== TRƯỜNG HỢP KHÔNG CÓ DỮ LIỆU =====
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_off,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Không có người dùng',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Widget để hiển thị Card User
  Widget _buildUserCard(User user) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.teal.shade50, Colors.teal.shade100],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar + Thông tin cơ bản
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 70,
                      height: 70,
                      color: Colors.grey.shade200,
                      child: user.avatarUrl.isNotEmpty
                          ? Image.network(
                              user.avatarUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.teal.shade700,
                                );
                              },
                            )
                          : Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.teal.shade700,
                            ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Tên + Role
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade700,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            user.role,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Divider
              Container(
                height: 1,
                color: Colors.teal.shade200,
              ),
              const SizedBox(height: 12),
              // Email
              Row(
                children: [
                  Icon(
                    Icons.email,
                    size: 18,
                    color: Colors.teal.shade700,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      user.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Số điện thoại
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 18,
                    color: Colors.teal.shade700,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      user.phone,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // Status indicator
                  if (user.isValidPhone())
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: Colors.green.shade700,
                    ),
                ],
              ),
              const SizedBox(height: 10),
              // Địa chỉ
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 18,
                    color: Colors.teal.shade700,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      user.address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


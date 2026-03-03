class News {
  final String id;
  final String title;
  final String description;
  final String content;
  final String imageUrl;
  final String source;
  final DateTime publishedAt;
  final int views;

  News({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.imageUrl,
    required this.source,
    required this.publishedAt,
    required this.views,
  });

  /// Chuyển JSON từ Firebase thành object News
  factory News.fromJson(Map<String, dynamic> json, String docId) {
    return News(
      id: docId,
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      content: json['content'] ?? 'No content',
      imageUrl: json['imageUrl'] ?? '',
      source: json['source'] ?? 'Unknown',
      publishedAt: json['publishedAt'] != null
          ? (json['publishedAt'] is String
              ? DateTime.parse(json['publishedAt'])
              : DateTime.fromMillisecondsSinceEpoch(
                  json['publishedAt'].seconds * 1000))
          : DateTime.now(),
      views: json['views'] ?? 0,
    );
  }

  /// Chuyển object News thành JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'content': content,
      'imageUrl': imageUrl,
      'source': source,
      'publishedAt': publishedAt.toIso8601String(),
      'views': views,
    };
  }

  /// Format ngày tháng đẹp mắt
  String getFormattedDate() {
    final now = DateTime.now();
    final difference = now.difference(publishedAt);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ngày trước';
    } else {
      return '${publishedAt.day}/${publishedAt.month}/${publishedAt.year}';
    }
  }
}

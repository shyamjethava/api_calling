class Post {
  final int id;
  final String title;
  final String body;
  bool isRead;
  Duration timerDuration;
  Duration elapsedTime;

  Post({
    required this.id,
    required this.title,
    required this.body,
    this.isRead = false,
    required this.timerDuration,
    this.elapsedTime = Duration.zero,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      timerDuration: Duration(seconds: (10 + (20 * (0.5 - (DateTime.now().millisecondsSinceEpoch % 2)).toInt()))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'isRead': isRead,
      'timerDuration': timerDuration.inSeconds,
      'elapsedTime': elapsedTime.inSeconds,
    };
  }
}

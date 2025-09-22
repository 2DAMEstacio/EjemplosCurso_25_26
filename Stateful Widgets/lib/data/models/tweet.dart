class Tweet {
  final int id;
  final String user;
  final String content;
  final String timestamp;
  final int likes;
  final int retweets;

  Tweet({
    required this.id,
    required this.user,
    required this.content,
    required this.timestamp,
    required this.likes,
    required this.retweets,
  });

  // Crear un Tweet desde un Map (ej: dummyTweets)
  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      id: map["id"] as int,
      user: map["user"] as String,
      content: map["content"] as String,
      timestamp: map["timestamp"] as String,
      likes: map["likes"] as int,
      retweets: map["retweets"] as int,
    );
  }

  // Convertir Tweet a Map (útil para guardar en JSON u otras operaciones)
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "user": user,
      "content": content,
      "timestamp": timestamp,
      "likes": likes,
      "retweets": retweets,
    };
  }

  Tweet copyWith({int? likes, int? retweets}) {
    return Tweet(
      id: id,
      user: user,
      content: content,
      timestamp: timestamp,
      likes: likes ?? this.likes,
      retweets: retweets ?? this.retweets,
    );
  }

  @override
  String toString() {
    return "Tweet(id: $id, user: $user, content: $content, timestamp: $timestamp, likes: $likes, retweets: $retweets)";
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_statefull_widget/data/models/tweet.dart';
import 'package:intl/intl.dart';

class TweetCard extends StatelessWidget {
  final Tweet tweet;
  final VoidCallback onLike;
  final VoidCallback onRetweet;

  const TweetCard({
    super.key,
    required this.tweet,
    required this.onLike,
    required this.onRetweet,
  });

  @override
  Widget build(BuildContext context) {
    DateTime parsed = DateTime.parse(tweet.timestamp.replaceAll(" ", "T"));
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Usuario y timestamp
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tweet.user,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  DateFormat('dd MMM yyyy, HH:mm').format(parsed),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Contenido
            Text(tweet.content, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 10),

            // Likes y retweets
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Botón de like
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: (tweet.likes > 0) ? Colors.red : Colors.grey,
                    size: 18,
                  ),
                  onPressed: onLike, // callback que recibes en TweetCard
                  padding: EdgeInsets.zero, // para que no ocupe demasiado
                  constraints: const BoxConstraints(),
                ),
                Text("${tweet.likes}"),

                const SizedBox(width: 16),

                // Botón de retweet
                IconButton(
                  icon: Icon(
                    Icons.repeat,
                    color: (tweet.retweets > 0) ? Colors.green : Colors.grey,
                    size: 18,
                  ),
                  onPressed: onRetweet, // callback que recibes en TweetCard
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                Text("${tweet.retweets}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

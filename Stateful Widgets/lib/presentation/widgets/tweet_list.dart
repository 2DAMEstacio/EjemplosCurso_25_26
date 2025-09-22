import 'package:flutter/material.dart';
import 'package:flutter_statefull_widget/data/dummy/dummy_tweets.dart';
import 'package:flutter_statefull_widget/data/models/tweet.dart';
import 'package:flutter_statefull_widget/presentation/widgets/tweet_card.dart';

class TweetList extends StatefulWidget {
  const TweetList({super.key});

  @override
  State<TweetList> createState() => _TweetListState();
}

class _TweetListState extends State<TweetList> {
  late List<Map<String, dynamic>> _filteredTweetList;

  @override
  void initState() {
    super.initState();
    _filteredTweetList = dummyTweets;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onLike(Tweet tweet) {
    debugPrint("like");
    setState(() {
      final index = _filteredTweetList.indexWhere((t) => t["id"] == tweet.id);
      if (index != -1) {
        final updated = tweet.copyWith(likes: tweet.likes + 1);
        _filteredTweetList[index] = updated.toMap();
      }
    });
  }

  void _onRetweet(Tweet tweet) {
    debugPrint("retweet");
    setState(() {
      final index = _filteredTweetList.indexWhere((t) => t["id"] == tweet.id);
      if (index != -1) {
        final updated = tweet.copyWith(retweets: tweet.retweets + 1);
        _filteredTweetList[index] = updated.toMap();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _filteredTweetList.length,
            itemBuilder: (context, index) {
              final tweet = Tweet.fromMap(_filteredTweetList[index]);
              return TweetCard(
                tweet: tweet,
                onLike: () => _onLike(tweet),
                onRetweet: () => _onRetweet(tweet),
              );
            },
          ),
        ),
      ],
    );
  }
}

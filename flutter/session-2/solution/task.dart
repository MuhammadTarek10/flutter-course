import 'package:flutter/material.dart';

void main() {
  runApp(const SocialMediaPostApp());
}

class SocialMediaPostApp extends StatelessWidget {
  const SocialMediaPostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Card',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const StaticSocialMediaFeed(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class StaticSocialMediaPost extends StatelessWidget {
  final String userAvatar;
  final String username;
  final String userHandle;
  final String timeAgo;
  final String content;
  final String? postImage;
  final int likes;
  final int comments;
  final int shares;
  final bool isLiked;
  final bool isBookmarked;

  const StaticSocialMediaPost({
    super.key,
    required this.userAvatar,
    required this.username,
    required this.userHandle,
    required this.timeAgo,
    required this.content,
    this.postImage,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.isLiked = false,
    this.isBookmarked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with user info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // User Avatar
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[300],
                  child: userAvatar.startsWith('http')
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.network(
                            userAvatar,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.person,
                                color: Colors.grey[600],
                                size: 30,
                              );
                            },
                          ),
                        )
                      : Icon(
                          Icons.person,
                          color: Colors.grey[600],
                          size: 30,
                        ),
                ),
                const SizedBox(width: 12),
                // User info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            username,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ],
                      ),
                      Text(
                        '$userHandle • $timeAgo',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                // More options
                Icon(
                  Icons.more_horiz,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
          // Post content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                height: 1.4,
              ),
            ),
          ),
          // Post image (if available)
          if (postImage != null) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: postImage!.startsWith('http')
                    ? Image.network(
                        postImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.image,
                              color: Colors.grey[400],
                              size: 50,
                            ),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image,
                          color: Colors.grey[400],
                          size: 50,
                        ),
                      ),
              ),
            ),
          ],
          const SizedBox(height: 12),
          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Like button
                _StaticActionButton(
                  icon: isLiked ? Icons.favorite : Icons.favorite_border,
                  iconColor: isLiked ? Colors.red : Colors.grey[600],
                  count: likes,
                ),
                const SizedBox(width: 24),
                // Comment button
                _StaticActionButton(
                  icon: Icons.chat_bubble_outline,
                  iconColor: Colors.grey[600],
                  count: comments,
                ),
                const SizedBox(width: 24),
                // Share button
                _StaticActionButton(
                  icon: Icons.share_outlined,
                  iconColor: Colors.grey[600],
                  count: shares,
                ),
                const Spacer(),
                // Bookmark button
                Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? Colors.blue : Colors.grey[600],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _StaticActionButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final int count;

  const _StaticActionButton({
    required this.icon,
    this.iconColor,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor ?? Colors.grey[600],
          size: 20,
        ),
        if (count > 0) ...[
          const SizedBox(width: 4),
          Text(
            _formatCount(count),
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}

// Static social media feed
class StaticSocialMediaFeed extends StatelessWidget {
  const StaticSocialMediaFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Social Feed'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView(
        children: const [
          StaticSocialMediaPost(
            userAvatar: 'https://example.com/avatar1.jpg',
            username: 'Sarah Johnson',
            userHandle: '@sarahj',
            timeAgo: '2h',
            content: 'Just finished an amazing Flutter workshop! The community here is incredible and I learned so much about state management. Can\'t wait to implement these new techniques in my next project! 🚀',
            postImage: 'https://example.com/flutter-workshop.jpg',
            likes: 1247,
            comments: 89,
            shares: 23,
            isLiked: true,
            isBookmarked: false,
          ),
          StaticSocialMediaPost(
            userAvatar: 'https://example.com/avatar2.jpg',
            username: 'Alex Chen',
            userHandle: '@alexchen',
            timeAgo: '4h',
            content: 'Beautiful sunset from my office window today. Sometimes you need to pause and appreciate the simple moments in life. Hope everyone is having a great day! ✨',
            likes: 892,
            comments: 45,
            shares: 12,
            isLiked: false,
            isBookmarked: true,
          ),
          StaticSocialMediaPost(
            userAvatar: 'https://example.com/avatar3.jpg',
            username: 'Maria Garcia',
            userHandle: '@mariadev',
            timeAgo: '6h',
            content: 'Excited to announce that our team just launched a new mobile app! It\'s been months of hard work, late nights, and countless cups of coffee. Thank you to everyone who supported us along the way! 🎉',
            postImage: 'https://example.com/app-launch.jpg',
            likes: 2156,
            comments: 234,
            shares: 67,
            isLiked: false,
            isBookmarked: false,
          ),
          StaticSocialMediaPost(
            userAvatar: 'placeholder',
            username: 'John Developer',
            userHandle: '@johndev',
            timeAgo: '8h',
            content: 'Working on some exciting new features for our Flutter app. The widget system never ceases to amaze me with its flexibility and power. Love how clean the code stays even with complex UIs! 💻',
            likes: 543,
            comments: 67,
            shares: 15,
            isLiked: true,
            isBookmarked: true,
          ),
          StaticSocialMediaPost(
            userAvatar: 'placeholder',
            username: 'Emma Wilson',
            userHandle: '@emmaw',
            timeAgo: '12h',
            content: 'Coffee and code - the perfect combination for a productive morning! Currently debugging some tricky animation issues, but making good progress. Anyone else love the satisfaction of fixing a complex bug? ☕',
            postImage: 'https://example.com/coffee-code.jpg',
            likes: 789,
            comments: 92,
            shares: 28,
            isLiked: false,
            isBookmarked: false,
          ),
        ],
      ),
    );
  }
}

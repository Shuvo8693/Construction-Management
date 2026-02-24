import 'package:charteur/assets/assets.gen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelperData {


  static final List<Map<String, dynamic>> onboardingData = [
    {
      "image": Assets.images.onboardingFast.path,
      "title": "Welcome to the Charteur.",
      "subtitle": "Build smarter. Manage faster. Deliver better."
    },
    {
      "image": Assets.images.onboardingSecond.path,
      "title": "All in One Place",
      "subtitle": "Streamline your projects and keep your team connected—all in one place."
    },
    {
      "image": Assets.images.onboardingLast.path,
      "title": "Centralize Your Construction Sites",
      "subtitle": "View all your construction sites on an interactive map and sidebar."
    },
  ];


  /// fake data
  static final List<Map<String, dynamic>> notifications = [
    {'name': 'Annette Black', 'message': 'Match request', 'date': DateTime.now(), 'type': 'request'},
    {'name': 'Annette Black', 'message': 'Commented on your post', 'date': DateTime.now(), 'type': 'comment'},
    {'name': 'Annette Black', 'message': 'Match request', 'date': DateTime.now().subtract(Duration(days: 1)), 'type': 'request'},
  ];




  static List<Map<String, dynamic>> messages = [
    {
      'text': 'Hey, how are you?',
      'isMe': true,
      'time': DateTime.now().subtract(Duration(minutes: 5)),
      'status': 'seen',
    },
    {
      'text': 'I am good, thanks! What about you?',
      'isMe': false,
      'time': DateTime.now().subtract(Duration(minutes: 3)),
      'status': 'seen',
    },
    {
      'text': 'I am doing great, working on a new project.',
      'isMe': true,
      'time': DateTime.now().subtract(Duration(minutes: 1)),
      'status': 'seen',
    },
    {
      'text': 'That sounds interesting!',
      'isMe': false,
      'time': DateTime.now(),
      'status': 'delivered',
    },
  ];

  static final List<SubscriptionPlan> plans = [
    SubscriptionPlan(
      duration: '1\nMonth',
      price: '\$9.99',
      pricePerMonth: '\$9.99/month',
    ),
    SubscriptionPlan(
      duration: '3\nMonths',
      price: '\$24.99',
      pricePerMonth: '\$8.33/month',
    ),
    SubscriptionPlan(
      duration: '1\nYear',
      price: '\$79.99',
      pricePerMonth: '\$6.67/month',
    ),
  ];

  static final List<Map<String, dynamic>> filteredItems = [
    {
      "title": "Assigned Task",
      "items": ["Office Admin", "Collaborator", "All",]
    },
    {
      "title": "My Task",
      "items": []
    },
    {
      "title": "Reassign Task",
      "items": []
    },
  ];




}

// Model Class
class SubscriptionPlan {
  final String duration;
  final String price;
  final String pricePerMonth;

  SubscriptionPlan({
    required this.duration,
    required this.price,
    required this.pricePerMonth,
  });
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MoreItem {
  final String name;
  final bool isActive;
  final IconData icon;

  MoreItem({
    this.name,
    this.isActive = false,
    this.icon,
  });
}

List moreItemData = [
  MoreItem(
    name: "Job History",
    icon: MaterialIcons.history,
    isActive: false,
  ),
  MoreItem(
    name: "Payments",
    icon: MaterialIcons.payment,
    isActive: false,
  ),
  MoreItem(
    name: "Reviews",
    icon: MaterialIcons.rate_review,
    isActive: false,
  ),
  MoreItem(
    name: "Notifications",
    icon: MaterialIcons.notifications,
    isActive: false,
  ),
  MoreItem(
    name: "Recommendations",
    icon: MaterialIcons.link,
    isActive: false,
  ),
  MoreItem(
    name: "Likes",
    icon: MaterialIcons.thumb_up,
    isActive: false,
  ),
  MoreItem(
    name: "Account Preferences",
    icon: MaterialIcons.supervisor_account,
    isActive: false,
  ),
  MoreItem(
    name: "Personal Info",
    icon: MaterialIcons.person_outline,
    isActive: false,
  ),
  MoreItem(
    name: "Support",
    icon: MaterialIcons.call,
    isActive: false,
  ),
];
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/notification_model.dart';

class NotificationNotifier extends StateNotifier<List<AppNotification>> {
  NotificationNotifier() : super([]) {
    _addSampleData();
  }

  void _addSampleData() {
    final now = DateTime.now();
    state = [
      AppNotification(
        id: '1',
        title: 'New Project Assigned',
        message: 'You have been assigned to a new project',
        timestamp: now.subtract(const Duration(minutes: 5)),
      ),
      AppNotification(
        id: '2',
        title: 'Meeting Reminder',
        message: 'Team meeting in 15 minutes',
        timestamp: now.subtract(const Duration(hours: 1)),
      ),
      AppNotification(
        id: '3',
        title: 'Task Completed',
        message: 'Your task has been marked as completed',
        timestamp: now.subtract(const Duration(days: 1)),
        isRead: true,
      ),
    ];
  }

  void addNotification(AppNotification notification) {
    state = [notification, ...state];
  }

  void markAsRead(String id) {
    state = [
      for (final notification in state)
        if (notification.id == id) 
          notification..isRead = true
        else
          notification,
    ];
  }

  void deleteNotification(String id) {
    state = state.where((n) => n.id != id).toList();
  }

  void markAllAsRead() {
    state = [
      for (final notification in state)
        notification..isRead = true,
    ];
  }

  int get unreadCount => state.where((n) => !n.isRead).length;
}

final notificationProvider = StateNotifierProvider<NotificationNotifier, List<AppNotification>>((ref) {
  return NotificationNotifier();
});

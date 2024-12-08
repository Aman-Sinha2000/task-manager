import 'package:task_tracker/util/constants/enums.dart';
import 'package:task_tracker/util/local_storage/storage_utility.dart';

class TaskModel {
  final int userId;
  final int? taskId;
  final String taskName;
  final String taskDescription;
  final TaskStatus taskCurrentState;
  final String taskDueDate;

  TaskModel({
    required this.userId,
    this.taskId,
    required this.taskName,
    required this.taskDescription,
    required this.taskCurrentState,
    required this.taskDueDate,
  });

  TaskModel copyWith({
    int? userId,
    int? taskId,
    String? taskName,
    String? taskDescription,
    String? taskDueDate,
    TaskStatus? taskCurrentState,
  }) {
    return TaskModel(
      userId: userId ?? this.userId,
      taskId: taskId ?? this.taskId,
      taskName: taskName ?? this.taskName,
      taskDescription: taskDescription ?? this.taskDescription,
      taskDueDate: taskDueDate ?? this.taskDueDate,
      taskCurrentState: taskCurrentState ?? this.taskCurrentState,
    );
  }

  Map<String, dynamic> toDoc() {
    return {
      CLocalStorage.USER_ID: userId,
      CLocalStorage.TASK_NAME: taskName,
      CLocalStorage.TASK_DESCRIPTION: taskDescription,
      CLocalStorage.TASK_CURRENT_STATUS: taskCurrentState.name,
      CLocalStorage.TASK_DUE_DATE: taskDueDate,
    };
  }

  factory TaskModel.fromDoc(Map<String, dynamic> doc) {
    return TaskModel(
      userId: doc[CLocalStorage.USER_ID],
      taskId: doc[CLocalStorage.TASK_ID],
      taskName: doc[CLocalStorage.TASK_NAME] as String,
      taskDescription: doc[CLocalStorage.TASK_DESCRIPTION] as String,
      taskCurrentState: TaskStatus.values.firstWhere(
        (e) => e.name == doc[CLocalStorage.TASK_CURRENT_STATUS],
        orElse: () => TaskStatus.pending,
      ),
      taskDueDate: doc[CLocalStorage.TASK_DUE_DATE] as String,
    );
  }
}

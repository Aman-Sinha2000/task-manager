part of 'add_task_bloc.dart';

@immutable
sealed class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String title;
  final String description;
  final String dueDate;

  AddTaskEvent({
    required this.title,
    required this.description,
    required this.dueDate,
  });
}

class UpdateTaskStatusEvent extends TaskEvent {
  final int taskId;
  final TaskStatus newStatus;

  UpdateTaskStatusEvent({
    required this.taskId,
    required this.newStatus,
  });
}

class OnTitleChanged extends TaskEvent {
  final String titleName;
  OnTitleChanged({required this.titleName});
}

class OnTaskDescriptionChanged extends TaskEvent {
  final String taskDescription;
  OnTaskDescriptionChanged({required this.taskDescription});
}

class OnDueDateSelected extends TaskEvent {
  final String? dueDate;
  OnDueDateSelected({required this.dueDate});
}

part of 'update_task_bloc.dart';

@immutable
sealed class UpdateTaskEvent {}

class UpdateTaskStatusEvent extends UpdateTaskEvent {
  final TaskModel updatedTask;

  UpdateTaskStatusEvent({required this.updatedTask});
}

class UpdateTaskStatusUiEvent extends UpdateTaskEvent {
  final TaskStatus newStatus;
  final TaskStatus selectedStatus;
  UpdateTaskStatusUiEvent(
      {required this.selectedStatus, required this.newStatus});
}

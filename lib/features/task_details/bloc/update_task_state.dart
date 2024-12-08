part of 'update_task_bloc.dart';

@immutable
sealed class UpdateTaskState {}

final class UpdateTaskInitial extends UpdateTaskState {}

class UpdateTaskLoading extends UpdateTaskState {}

class UpdateTaskSuccess extends UpdateTaskState {}

class UpdateTaskError extends UpdateTaskState {
  final String errorMessage;

  UpdateTaskError(this.errorMessage);
}

class ChangeStatusUiState extends UpdateTaskState {
  final TaskStatus selectedStatus;
  ChangeStatusUiState({required this.selectedStatus});
}

class ChangeStatusUiError extends UpdateTaskState {
  final String message;
  ChangeStatusUiError({required this.message});
}

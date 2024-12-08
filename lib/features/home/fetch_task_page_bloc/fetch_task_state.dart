part of 'fetch_task_bloc.dart';

@immutable
sealed class FetchTaskState {}

final class FetchTaskInitial extends FetchTaskState {}

class FetchTaskLoading extends FetchTaskState {}

class FetchTaskSuccess extends FetchTaskState {
  final List<TaskModel> pendingTasks;
  final List<TaskModel> inProgressTasks;
  final List<TaskModel> completedTasks;
  final List<TaskModel> expiredTasks;
  final String userName;

  FetchTaskSuccess(
      {required this.pendingTasks,
      required this.inProgressTasks,
      required this.completedTasks,
      required this.expiredTasks,
      required this.userName});
}

class FetchTaskError extends FetchTaskState {
  final String errorMessage;

  FetchTaskError(this.errorMessage);
}

class FetchUserDetailsSuccess extends FetchTaskState {
  final String name;
  FetchUserDetailsSuccess({required this.name});
}

part of 'add_task_bloc.dart';

@immutable
sealed class TaskState {}

final class AddTaskInitial extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskAddedState extends TaskState {}

class TaskUpdatedState extends TaskState {}

class ValidationState extends TaskState {
  final String? taskTitleError;
  final String? taskDescriptionError;
  final String? selectedDateError;

  //final String? pendingStatus;
  ValidationState({
    this.taskTitleError,
    this.taskDescriptionError,
    this.selectedDateError,
  });
}

class SelectedDateState extends TaskState {
  final String? selectedDate;
  SelectedDateState({this.selectedDate});
}

class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState(this.message);
}

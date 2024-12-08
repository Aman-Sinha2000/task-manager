import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_tracker/data/response_models/task_model.dart';
import 'package:task_tracker/util/constants/enums.dart';
import 'package:task_tracker/util/constants/text_strings.dart';
import 'package:task_tracker/util/helpers/helper_functions.dart';
import 'package:task_tracker/util/local_storage/storage_utility.dart';
import 'package:task_tracker/util/logging/logger.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc({required CLocalStorage cLocalStorage}) : super(AddTaskInitial()) {
    on<AddTaskEvent>((event, emit) async {
      emit(TaskLoadingState());
      try {
        ValidationState validationResult = _validateFields(
          title: event.title,
          description: event.description,
          dueDate: event.dueDate,
        );

        if (validationResult.selectedDateError == null &&
            validationResult.taskDescriptionError == null &&
            validationResult.taskTitleError == null) {
          emit(ValidationState(
            selectedDateError: null,
            taskTitleError: null,
            taskDescriptionError: null,
          ));

          String userId = await CHelperFunctions.geUserId();
          final task = TaskModel(
            userId: int.parse(userId),
            taskName: event.title,
            taskDescription: event.description,
            taskDueDate: event.dueDate,
            taskCurrentState: TaskStatus.pending,
          );
          int added = await cLocalStorage.addTask(task);
          CLoggerHelper.debug(added.toString());

          CLoggerHelper.debug("Added Successfully");
          emit(TaskAddedState());
        } else {
          emit(validationResult);
        }
      } catch (e) {
        CLoggerHelper.error(e.toString());
        emit(TaskErrorState("Failed to add task: ${e.toString()}"));
      }
    });

    on<OnTitleChanged>((event, emit) {
      if (isValidText(event.titleName)) {
        emit(ValidationState(
          taskTitleError: null,
          taskDescriptionError: null,
          selectedDateError: null,
        ));
      } else {
        emit(ValidationState(
          taskTitleError: CTextStrings.enterTitleName,
          taskDescriptionError: null,
          selectedDateError: null,
        ));
      }
    });

    on<OnTaskDescriptionChanged>((event, emit) {
      if (isValidText(event.taskDescription)) {
        emit(ValidationState(
          taskTitleError: null,
          taskDescriptionError: null,
          selectedDateError: null,
        ));
      } else {
        emit(ValidationState(
          taskTitleError: null,
          taskDescriptionError: CTextStrings.enterDescription,
          selectedDateError: null,
        ));
      }
    });

    on<OnDueDateSelected>((event, emit) {
      if (isValidText(event.dueDate)) {
        emit(ValidationState(
          taskTitleError: null,
          taskDescriptionError: null,
          selectedDateError: null,
        ));
        emit(SelectedDateState(selectedDate: event.dueDate));
      } else {
        emit(ValidationState(
          taskTitleError: null,
          taskDescriptionError: null,
          selectedDateError: CTextStrings.selectDueDate,
        ));
      }
    });

    // on<UpdateTaskStatusEvent>((event, emit) async {
    //   emit(TaskLoadingState());
    //   try {
    //     String userId = await CHelperFunctions.geUserId();
    //     final tasks = await cLocalStorage.fetchTaskUserId(
    //         int.parse(userId), event.taskId);
    //     final task =
    //         tasks.firstWhere((t) => t[CLocalStorage.TASK_ID] == event.taskId);

    //     TaskStatus currentStatus = TaskStatus.values.firstWhere((status) =>
    //         status.toString().split('.').last ==
    //         task[CLocalStorage.TASK_CURRENT_STATUS]);

    //     if ((currentStatus == TaskStatus.pending && event.newStatus == TaskStatus.inProgress) ||
    //         (currentStatus == TaskStatus.inProgress && event.newStatus == TaskStatus.completed)) {
    //       task[CLocalStorage.TASK_CURRENT_STATUS] = event.newStatus.toString().split('.').last;
    //       await cLocalStorage.updateTask(task);
    //       emit(TaskUpdatedState());
    //     } else {
    //       emit(TaskErrorState("Invalid status transition"));
    //     }
    //   } catch (e) {
    //     emit(TaskErrorState("Failed to update task status: ${e.toString()}"));
    //   }
    // });
  }

  bool isValidText(String? data) {
    return data != null && data.isNotEmpty;
  }

  ValidationState _validateFields({
    required String? title,
    required String? description,
    required String? dueDate,
  }) {
    return ValidationState(
      selectedDateError:
          !isValidText(dueDate) ? CTextStrings.selectDueDate : null,
      taskTitleError: !isValidText(title) ? CTextStrings.enterTitleName : null,
      taskDescriptionError:
          !isValidText(description) ? CTextStrings.enterDescription : null,
    );
  }
}

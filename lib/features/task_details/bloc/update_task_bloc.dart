import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:task_tracker/data/response_models/task_model.dart';
import 'package:task_tracker/util/constants/enums.dart';
import 'package:task_tracker/util/constants/text_strings.dart';
import 'package:task_tracker/util/helpers/helper_functions.dart';
import 'package:task_tracker/util/local_storage/storage_utility.dart';

part 'update_task_event.dart';
part 'update_task_state.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  UpdateTaskBloc({required CLocalStorage cLocalStorage})
      : super(UpdateTaskInitial()) {
    on<UpdateTaskStatusEvent>((event, emit) async {
      emit(UpdateTaskLoading());
      try {
        final userId = await CHelperFunctions.geUserId();
        if (userId == '') {
          emit(UpdateTaskError(CTextStrings.userIdError));
          return;
        }
        // Update the task in the local storage
        int updatedRows =
            await cLocalStorage.updateTaskStatus(event.updatedTask);
        if (updatedRows > 0) {
          emit(UpdateTaskSuccess());
        } else {
          emit(
              UpdateTaskError(CTextStrings.problemOccuredWhileUpdatingTheTask));
        }

        // Fetch the latest tasks
      } catch (e) {
        emit(UpdateTaskError(e.toString()));
      }
    });

    on<UpdateTaskStatusUiEvent>((event, emit) {
      if (_isStatusTransitionValid(event.selectedStatus, event.newStatus)) {
        if (event.selectedStatus != event.newStatus) {
          emit(ChangeStatusUiState(selectedStatus: event.newStatus));
        }
      } else {
        emit(
            ChangeStatusUiError(message: CTextStrings.invalidStatusTransition));
      }
    });
  }

  bool _isStatusTransitionValid(TaskStatus current, TaskStatus newStatus) {
    if (current == TaskStatus.pending && newStatus == TaskStatus.completed) {
      return false;
    }
    if (current.index > newStatus.index) {
      return false;
    }
    return true;
  }
}

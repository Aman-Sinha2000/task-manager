import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_tracker/data/response_models/task_model.dart';
import 'package:task_tracker/util/constants/enums.dart';
import 'package:task_tracker/util/formatters/formatter.dart';
import 'package:task_tracker/util/helpers/helper_functions.dart';
import 'package:task_tracker/util/local_storage/storage_utility.dart';
import 'package:task_tracker/util/logging/logger.dart';

part 'fetch_task_event.dart';
part 'fetch_task_state.dart';

class FetchTaskBloc extends Bloc<FetchTaskEvent, FetchTaskState> {
  FetchTaskBloc({required CLocalStorage cLocalStorage})
      : super(FetchTaskInitial()) {
    on<FetchTaskEvent>((event, emit) async {
      emit(FetchTaskLoading());
      try {
        final userId = await CHelperFunctions.geUserId();
        String userName = await CHelperFunctions.getUserName();
        if (userId == '') {
          emit(FetchTaskError("User ID not found in SharedPreferences."));
          return;
        }

        final List<Map<String, dynamic>> taskDocs =
            await cLocalStorage.fetchTasksByUserId(int.parse(userId));

        final List<TaskModel> tasks =
            taskDocs.map((doc) => TaskModel.fromDoc(doc)).toList();

        final today = normalizeDate(DateTime.now());

        final List<TaskModel> pendingTasks = tasks.where((task) {
          final taskDueDate =
              normalizeDate(CFormatter.parseDate(task.taskDueDate));
          return task.taskCurrentState == TaskStatus.pending &&
              (taskDueDate.isAtSameMomentAs(today) ||
                  taskDueDate.isAfter(today));
        }).toList();

        final List<TaskModel> inProgressTasks = tasks.where((task) {
          final taskDueDate =
              normalizeDate(CFormatter.parseDate(task.taskDueDate));
          return task.taskCurrentState == TaskStatus.inProgress &&
              (taskDueDate.isAtSameMomentAs(today) ||
                  taskDueDate.isAfter(today));
        }).toList();

        final List<TaskModel> completedTasks = tasks.where((task) {
          final taskDueDate =
              normalizeDate(CFormatter.parseDate(task.taskDueDate));
          return task.taskCurrentState == TaskStatus.completed &&
              (taskDueDate.isAtSameMomentAs(today) ||
                  taskDueDate.isAfter(today));
        }).toList();

        final List<TaskModel> expiredTasks = tasks.where((task) {
          final taskDueDate =
              normalizeDate(CFormatter.parseDate(task.taskDueDate));
          return taskDueDate.isBefore(today);
        }).toList();

        CLoggerHelper.info(pendingTasks);
        CLoggerHelper.info(inProgressTasks);
        CLoggerHelper.info(completedTasks);

        emit(FetchTaskSuccess(
            pendingTasks: pendingTasks,
            inProgressTasks: inProgressTasks,
            completedTasks: completedTasks,
            expiredTasks: expiredTasks,
            userName: userName));
      } catch (e) {
        CLoggerHelper.error("Error fetching tasks: $e");
        emit(FetchTaskError("Failed to fetch tasks: ${e.toString()}"));
      }
    });
  }

  DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}

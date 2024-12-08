import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_tracker/features/home/fetch_task_page_bloc/fetch_task_bloc.dart';
import 'package:task_tracker/data/response_models/task_model.dart';
import 'package:task_tracker/features/task_details/bloc/update_task_bloc.dart';
import 'package:task_tracker/util/constants/colors.dart';
import 'package:task_tracker/util/constants/sizes.dart';
import 'package:task_tracker/util/constants/enums.dart';
import 'package:task_tracker/util/constants/text_strings.dart';
import 'package:task_tracker/util/helpers/helper_functions.dart';

class TaskDetailsPage extends StatelessWidget {
  final TaskModel task;
  final bool isExpired;

  const TaskDetailsPage(
      {super.key, required this.task, required this.isExpired});

  @override
  Widget build(BuildContext context) {
    TaskStatus selectedStatus = task.taskCurrentState;
    // TaskStatus selectedStatus = TaskStatus.completed;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details"),
        backgroundColor: CColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<UpdateTaskBloc, UpdateTaskState>(
          listener: (context, state) {
            if (state is UpdateTaskSuccess) {
              CHelperFunctions.showSnackBar(
                  context, "Status Update Successfully");
            } else if (state is UpdateTaskError) {
              CHelperFunctions.showSnackBar(context, state.errorMessage);
            } else if (state is ChangeStatusUiError) {
              _showInvalidStatusTransitionMessage(context, state.message);
            } else if (state is ChangeStatusUiState) {
              CHelperFunctions.showAlert(context, CTextStrings.statusUpdated,
                  CTextStrings.statusUpdatedSuccessfully);
            }
          },
          builder: (context, state) {
            if (state is UpdateTaskLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ChangeStatusUiState) {
              selectedStatus = state.selectedStatus;

              if (selectedStatus == TaskStatus.completed) {
                context.read<UpdateTaskBloc>().add(
                      UpdateTaskStatusEvent(
                        updatedTask: task.copyWith(
                            taskCurrentState: selectedStatus,
                            taskDueDate: DateFormat('dd-MM-yyyy')
                                .format(DateTime.now())
                                .toString()),
                      ),
                    );
              } else {
                context.read<UpdateTaskBloc>().add(
                      UpdateTaskStatusEvent(
                        updatedTask: task.copyWith(
                          taskCurrentState: selectedStatus,
                        ),
                      ),
                    );
              }

              context.read<FetchTaskBloc>().add(FetchTasksEvent());
            }
            return Padding(
              padding: const EdgeInsets.all(CSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDetailSection(
                          CTextStrings.taskTitle, task.taskName, context),
                      const SizedBox(
                        width: CSizes.sm,
                      ),
                      _buildDetailSection(
                          CTextStrings.dueDate, task.taskDueDate, context),
                    ],
                  ),
                  _buildDetailSection(CTextStrings.taskDescription,
                      task.taskDescription, context),
                  _buildStatusSection(context, selectedStatus),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String value, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          task.taskCurrentState == TaskStatus.completed
              ? "Completed"
              : "Due Date",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: CSizes.xs),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: CSizes.spaceBtwItems),
      ],
    );
  }

  Widget _buildStatusSection(BuildContext context, TaskStatus selectedStatus) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          CTextStrings.taskStatus,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: CSizes.xs),
        DropdownButton<TaskStatus>(
          value: selectedStatus,
          focusColor: CColors.accent,
          items: TaskStatus.values.map((status) {
            return DropdownMenuItem(
              value: status,
              child: Text(status.name.toUpperCase()),
            );
          }).toList(),
          onChanged: (newStatus) {
            if (newStatus == null) return;
            if (isExpired) {
              _showInvalidStatusTransitionMessage(
                  context, "Task already expired");
              return;
            }
            context.read<UpdateTaskBloc>().add(
                  UpdateTaskStatusUiEvent(
                      selectedStatus: selectedStatus, newStatus: newStatus),
                );
            // Navigator.pop(context); // Return to the TaskHomePage
          },
        ),
      ],
    );
  }

  // void _showDialogBox(BuildContext parentContext, String title, String message){
  //   showDialog(
  //     context: parentContext,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(message),
  //         actions: [
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: const Text("Cancel")),
  //           TextButton(
  //               onPressed: () {
  //                 //Navigator.pop(context);
  //               },
  //               child: const Text("Ok"))
  //         ],
  //       );
  //     },
  //   );
  // }

  void _showInvalidStatusTransitionMessage(
      BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}

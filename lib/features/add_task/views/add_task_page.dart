import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_tracker/common/styles/spacing_styles.dart';
import 'package:task_tracker/features/add_task/add_task_page_bloc/add_task_bloc.dart';
import 'package:task_tracker/features/navigation/navigation_page_bloc/navigation_bloc.dart';
import 'package:task_tracker/features/navigation/navigation_page_bloc/navigation_event.dart';
import 'package:task_tracker/util/constants/colors.dart';
import 'package:task_tracker/util/constants/enums.dart';
import 'package:task_tracker/util/constants/image_strings.dart';
import 'package:task_tracker/util/constants/sizes.dart';
import 'package:task_tracker/util/constants/text_strings.dart';
import 'package:task_tracker/util/device/device_utils.dart';
import 'package:task_tracker/util/helpers/helper_functions.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? taskCompletionDate;
  TaskStatus? selectedStatus;
  String? titleErrorText;
  String? descriptionErrorText;
  String? taskCompletionDueErrorText;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is TaskAddedState) {
              CHelperFunctions.showAlert(
                  context, "Success", "Task Added Successfully");
              _titleController.text = '';
              _descriptionController.text = '';
              taskCompletionDate = '';
              context.read<NavigationBloc>().add(const NavigationItemTapped(0));
            } else if (state is TaskErrorState) {
              CHelperFunctions.showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is ValidationState) {
              titleErrorText = state.taskTitleError;
              descriptionErrorText = state.taskDescriptionError;
              taskCompletionDueErrorText = state.selectedDateError;
            } else if (state is TaskLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SelectedDateState) {
              taskCompletionDate = state.selectedDate;
            }
            return Container(
              width: CDeviceUtils.getScreenWidth(context),
              padding: CSpacingStyles.paddingWithAppBarHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ? Task Bar Logo,
                  cAddTaskHeader(dark, context),

                  // ? Form Text Field
                  cAddTaskForm(
                    context: context,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget cAddTaskForm({
    required BuildContext context,
  }) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: CSizes.spaceBtwSections),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(CupertinoIcons.pen),
                  labelText: CTextStrings.taskTitle,
                  errorText: titleErrorText),
              onChanged: (value) {
                context
                    .read<TaskBloc>()
                    .add(OnTitleChanged(titleName: _titleController.text));
              },
            ),
            const SizedBox(
              height: CSizes.spaceBtwInputFields,
            ),
            TextFormField(
              maxLines: 9,
              controller: _descriptionController,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.description),
                  labelText: CTextStrings.taskDescription,
                  alignLabelWithHint: true,
                  errorText: descriptionErrorText),
              onChanged: (value) {
                context.read<TaskBloc>().add(OnTaskDescriptionChanged(
                    taskDescription: _descriptionController.text));
              },
            ),
            const SizedBox(
              height: CSizes.spaceBtwInputFields,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        final selectedDate =
                            await showDatePickerWithValidation(context);
                        context
                            .read<TaskBloc>()
                            .add(OnDueDateSelected(dueDate: selectedDate));

                        if (selectedDate != null) {
                          taskCompletionDate = selectedDate;
                          CHelperFunctions.showSnackBar(
                              context, "Selected Date: ${selectedDate}");
                        }
                      },
                      child: Text(taskCompletionDate ?? "Select Date"),
                    ),
                    const SizedBox(
                      height: CSizes.sm,
                    ),
                    Text(
                      taskCompletionDueErrorText ?? '',
                      style: const TextStyle().copyWith(
                          fontStyle: FontStyle.normal, color: CColors.error),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        CHelperFunctions.showSnackBar(context,
                            CTextStrings.caanotEditStatusAtTheTimeOfCreation);
                      },
                      child: const Text(
                        "PENDING",
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: CSizes.sm,
            ),

            // ? Add Task  Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    CDeviceUtils.hideKeyboard(context);
                    context.read<TaskBloc>().add(
                          AddTaskEvent(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            dueDate: taskCompletionDate ?? '',
                          ),
                        );
                  },
                  child: const Text(CTextStrings.addTask)),
            ),
          ],
        ),
      ),
    );
  }

  Widget cAddTaskHeader(bool dark, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Image(
          height: 200,
          image: AssetImage(CImage.addTaskImage),
        ),
        Text(
          CTextStrings.addTask,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: CSizes.sm,
        ),
        Text(
          CTextStrings.taskQuote,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Future<String?> showDatePickerWithValidation(BuildContext context) async {
    final now = DateTime.now();
    DateTime dateSelected;
    try {
      dateSelected = DateFormat('dd-MM-yyyy').parse(taskCompletionDate ?? '');
    } catch (e) {
      dateSelected = DateTime.now();
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateSelected,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate != null) {
      // Format the date to dd-MM-yyyy
      return DateFormat('dd-MM-yyyy').format(pickedDate);
    }

    return taskCompletionDate;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker/common/widgets/appbar/appbar.dart';
import 'package:task_tracker/features/home/fetch_task_page_bloc/fetch_task_bloc.dart';
import 'package:task_tracker/data/response_models/task_model.dart';
import 'package:task_tracker/features/task_details/views/task_details_page.dart';
import 'package:task_tracker/util/constants/colors.dart';
import 'package:task_tracker/util/constants/image_strings.dart';
import 'package:task_tracker/util/constants/sizes.dart';
import 'package:task_tracker/util/constants/text_strings.dart';
import 'package:task_tracker/util/device/device_utils.dart';
import 'package:task_tracker/util/helpers/helper_functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getTaskList();
  }

  String? name;

  void getTaskList() {
    context.read<FetchTaskBloc>().add(FetchTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FetchTaskBloc, FetchTaskState>(
        builder: (context, state) {
          if (state is FetchTaskLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FetchTaskSuccess) {
            name = state.userName;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _homeTopSection(context),
                  _buildTaskSection(
                    context,
                    "Pending Tasks",
                    state.pendingTasks,
                    CColors.warning,
                  ),
                  _buildTaskSection(
                    context,
                    "In Progress Tasks",
                    state.inProgressTasks,
                    CColors.info,
                  ),
                  _buildTaskSection(
                    context,
                    "Completed Tasks",
                    state.completedTasks,
                    CColors.success,
                  ),
                  _buildTaskSection(
                    context,
                    "Expired Tasks",
                    state.expiredTasks,
                    CColors.error,
                  )
                ],
              ),
            );
          } else if (state is FetchTaskError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.red),
              ),
            );
          } else {
            return const Center(
              child: Text(CTextStrings.noTaskAvailable),
            );
          }
        },
      ),
    );
  }

  Widget _homeTopSection(BuildContext context) {
    return Container(
      color: CColors.primaryColor,
      padding: const EdgeInsets.all(CSizes.sm),
      child: SizedBox(
        width: CDeviceUtils.getScreenWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CAppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    CTextStrings.greetings,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .apply(color: CColors.grey),
                  ),
                  Text(
                    name ?? "Guest",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .apply(color: CColors.white),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: CSizes.spaceBtwSections),
              child: Image(
                height: 120,
                image: AssetImage(CImage.taskImage),
              ),
            ),
            const SizedBox(
              height: CSizes.spaceBtwItems,
            ),
            Padding(
              padding: const EdgeInsets.only(left: CSizes.md),
              child: Text(
                CTextStrings.homePageQuote,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white, fontSize: CSizes.md),
              ),
            ),
            const SizedBox(
              height: CSizes.spaceBtwItems,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskSection(
      BuildContext context, String title, List<TaskModel> tasks, Color color) {
    return Padding(
      padding: const EdgeInsets.all(CSizes.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: CSizes.sm),
          tasks.isNotEmpty
              ? Column(
                  children: tasks
                      .map(
                        (task) => Card(
                          margin:
                              const EdgeInsets.symmetric(vertical: CSizes.xs),
                          elevation: 3,
                          child: ListTile(
                            title: Text(
                              task.taskName,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            subtitle: Text(
                              "${title == "Completed Tasks" ? "Completed" : "Due"}: ${task.taskDueDate}",
                              style: Theme.of(context).textTheme.bodyMedium!,
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: CColors.primaryColor,
                              size: CSizes.md,
                            ),
                            onTap: () {
                              CHelperFunctions.push(
                                  context,
                                  TaskDetailsPage(
                                    task: task,
                                    isExpired:
                                        title == "Expired Tasks" ? true : false,
                                  ));
                            },
                          ),
                        ),
                      )
                      .toList(),
                )
              : Padding(
                  padding: const EdgeInsets.all(CSizes.sm),
                  child: Text(
                    CTextStrings.noTaskInThisCategory,
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                ),
        ],
      ),
    );
  }
}

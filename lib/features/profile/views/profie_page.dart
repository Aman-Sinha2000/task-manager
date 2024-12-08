import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker/features/authentication/views/signin.dart';
import 'package:task_tracker/features/profile/profile_page_bloc/profile_bloc.dart';
import 'package:task_tracker/util/constants/colors.dart';
import 'package:task_tracker/util/constants/sizes.dart';
import 'package:task_tracker/util/constants/text_strings.dart';
import 'package:task_tracker/util/device/device_utils.dart';
import 'package:task_tracker/util/helpers/helper_functions.dart';

class ProfiePage extends StatefulWidget {
  const ProfiePage({super.key});

  @override
  State<ProfiePage> createState() => _ProfiePageState();
}

class _ProfiePageState extends State<ProfiePage> {
  String? userName;
  String? userId;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    getUserDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdated) {
              CHelperFunctions.pushAndRemove(context, const Signin());
            } else if (state is ProfileError) {
              CHelperFunctions.showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is ProfileLoaded) {
              userName = state.userName;
              userEmail = state.userEmail;
              userId = state.userId;
            } else if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Container(
                  color: CColors.primaryColor,
                  width: CDeviceUtils.getScreenWidth(context),
                  padding: const EdgeInsets.only(
                      top: CSizes.spaceBtwSections,
                      left: CSizes.sm,
                      right: CSizes.sm,
                      bottom: CSizes.sm),
                  child: ListTile(
                    title: Text(
                      userName ?? "Guest",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: Colors.white),
                    ),
                    subtitle: Text(
                      userEmail ?? "test@gmail.com",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<ProfileBloc>().add(UpdateProfileEvent(
                        userEmail: '',
                        userName: '',
                        userId: '',
                        isLoggedIn: false));
                  },
                  child: Container(
                    width: CDeviceUtils.getScreenWidth(context),
                    padding: const EdgeInsets.symmetric(
                        horizontal: CSizes.spaceBtwSections,
                        vertical: CSizes.spaceBtwItems),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(CTextStrings.logOut,
                            style: Theme.of(context).textTheme.headlineMedium),
                        const Icon(Icons.logout_outlined)
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void getUserDate() async {
    context.read<ProfileBloc>().add(FetchProfileEvent());
  }
}

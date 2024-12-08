import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker/common/styles/spacing_styles.dart';
import 'package:task_tracker/data/request_models/signin_request_model.dart';
import 'package:task_tracker/features/authentication/signin_bloc/login_page_bloc.dart';
import 'package:task_tracker/features/navigation/views/naviagtion_page.dart';
import 'package:task_tracker/util/constants/image_strings.dart';
import 'package:task_tracker/util/constants/sizes.dart';
import 'package:task_tracker/util/constants/text_strings.dart';
import 'package:task_tracker/util/device/device_utils.dart';
import 'package:task_tracker/util/helpers/helper_functions.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordVisible = false;
  String? passwordError;
  String? emailError;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        width: CDeviceUtils.getScreenWidth(context),
        height: CDeviceUtils.getScreenHeight(context),
        padding: CSpacingStyles.paddingWithAppBarHeight,
        child: BlocConsumer<LoginPageBloc, LoginPageState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              CHelperFunctions.showSnackBar(context, CTextStrings.loginSuccess);
              CHelperFunctions.pushAndRemove(context, const NaviagtionPage());
            } else if (state is LoginFailure) {
              CHelperFunctions.showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is LoginValidationState) {
              passwordError = state.passwordError;
              emailError = state.emailError;
            } else if (state is LoginLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PasswordState) {
              isPasswordVisible = state.isPasswordVisible;
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ? App Logo,
                cLoginHeader(dark, context),

                // ? Form Text Field
                cLoginForm(
                    context: context,
                    emailError: emailError,
                    passwordError: passwordError,
                    isPasswordVisible: isPasswordVisible),
              ],
            );
          },
        ),
      )),
    );
  }

  Widget cLoginForm(
      {required BuildContext context,
      String? emailError,
      String? passwordError,
      required bool isPasswordVisible}) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: CSizes.spaceBtwSections),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  labelText: CTextStrings.email,
                  errorText: emailError),
              onChanged: (value) {
                context.read<LoginPageBloc>().add(LoginEmailChanged(value));
              },
            ),
            const SizedBox(
              height: CSizes.spaceBtwInputFields,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(CupertinoIcons.lock),
                  labelText: CTextStrings.password,
                  errorText: passwordError,
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read<LoginPageBloc>().add(
                          TogglePasswordVisibility(
                              isVisible: this.isPasswordVisible));
                    },
                    icon: isPasswordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  )),
              obscureText: isPasswordVisible ? false : true,
              onChanged: (value) {
                context.read<LoginPageBloc>().add(LoginPasswordChanged(value));
              },
            ),
            const SizedBox(
              height: CSizes.spaceBtwInputFields,
            ),

            // ? Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    CDeviceUtils.hideKeyboard(context);
                    context.read<LoginPageBloc>().add(
                          LoginSubmitted(
                            signInRequestModel: SignInRequestModel(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          ),
                        );
                  },
                  child: const Text(CTextStrings.signIn)),
            ),
          ],
        ),
      ),
    );
  }

  Widget cLoginHeader(bool dark, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image:
              AssetImage(dark ? CImage.lightLoginLogo : CImage.darkLoginLogo),
        ),
        Text(
          CTextStrings.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: CSizes.sm,
        ),
        Text(
          CTextStrings.subTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

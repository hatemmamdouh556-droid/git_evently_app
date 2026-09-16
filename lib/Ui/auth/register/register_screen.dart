import 'package:evently_project/Ui/widgets/custom_elevated_botton.dart';
import 'package:evently_project/Ui/widgets/custom_text_field.dart';
import 'package:evently_project/l10n/app_localizations.dart';
import 'package:evently_project/providers/app_theme_provider.dart';
import 'package:evently_project/utils/AppAssets.dart';
import 'package:evently_project/utils/AppColors.dart';
import 'package:evently_project/utils/AppStyles.dart';
import 'package:evently_project/utils/size_utils.dart';
import 'package:evently_project/utils/toast_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var passwordController = TextEditingController(text: '123456');

  var nameController = TextEditingController(text: 'hatem');

  var emailController = TextEditingController(text: 'hatem@gmail.com');

  var rePasswordController = TextEditingController(text: '12345');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    var width = context.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.02,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: height * 0.02,
                children: [
                  Image.asset(
                    themeProvider.isDark ? AppAssets.logoDark : AppAssets.logo,
                  ),
                  Text(
                    AppLocalizations.of(context)!.create_your_account,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  CustomTextField(
                    hintText: AppLocalizations.of(context)!.enter_your_name,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: Icon(
                      Icons.person_2_outlined,
                      color: AppColors.disableColor,
                    ),
                    controller: nameController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter email';
                      }

                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: AppLocalizations.of(context)!.enter_your_email,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AppColors.disableColor,
                    ),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter email';
                      }
                      final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(text);

                      if (!emailValid) {
                        return 'please Enter valid email.';
                      }
                      return null;
                    },
                  ),

                  CustomTextField(
                    style: Theme.of(context).textTheme.bodySmall,
                    hintText: AppLocalizations.of(context)!.enter_your_password,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: Icon(
                      Icons.lock_open_outlined,
                      color: AppColors.disableColor,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility_off_outlined,
                      color: AppColors.disableColor,
                    ),
                    controller: passwordController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter password';
                      }
                      if (text.length < 6) {
                        return 'password should be at least 6 chars';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    style: Theme.of(context).textTheme.bodySmall,
                    hintText: AppLocalizations.of(context)!
                        .enter_your_rePassword,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: Icon(
                      Icons.lock_open_outlined,
                      color: AppColors.disableColor,
                    ),
                    suffixIcon: Icon(
                      Icons.visibility_off_outlined,
                      color: AppColors.disableColor,
                    ),
                    controller: rePasswordController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter password';
                      }
                      if (text != passwordController.text) {
                        return "Re-password doesn't match password.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.02),

                  CustomElevatedBotton(
                    onPressed: register,
                    child: Text(
                      AppLocalizations.of(context)!.sign_up,
                      style: AppStyles.medium20WhiteDarkColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.already_have_an_account,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextButton(
                        onPressed: () {
                          //todo : navigate to login screen
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: Theme.of(context).cardColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Theme.of(context).dividerColor,
                          thickness: 2,
                          indent: width * 0.02,
                          endIndent: width * 0.06,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.or,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Expanded(
                        child: Divider(
                          color: Theme.of(context).dividerColor,
                          thickness: 2,
                          indent: width * 0.06,
                          endIndent: width * 0.02,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  CustomElevatedBotton(
                    onPressed: () {
                      //todo : signup with google
                    },
                    borderColor: Theme.of(context).dividerColor,
                    padding: height * 0.02,
                    backgroundColor: Theme.of(context).highlightColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: width * 0.04,
                      children: [
                        Image.asset(AppAssets.googleLogo),
                        Text(
                          AppLocalizations.of(context)!.sign_up_with_google,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void register() async{
    //todo : register , navigate to home  screen
    if (formKey.currentState?.validate() == true) {
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        ToastUtils.toastMsg(
            msg: 'register successfully.',
            backgroundColor: Theme.of(context).cardColor,
            textColor: AppColors.whiteColor,
            gravity:ToastGravity.BOTTOM);
        print('id : ${credential.user?.uid}');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ToastUtils.toastMsg(
              msg: 'The password provided is too weak.',
              backgroundColor: AppColors.redColor,
              textColor: AppColors.whiteColor,
              gravity:ToastGravity.BOTTOM);
        } else if (e.code == 'email-already-in-use') {
          ToastUtils.toastMsg(
              msg: 'The account already exists for that email.',
              backgroundColor: AppColors.redColor,
              textColor: AppColors.whiteColor,
              gravity:ToastGravity.BOTTOM);
        }else if (e.code == 'network-request-failed') {
          ToastUtils.toastMsg(
              msg: 'No internet connection.',
              backgroundColor: AppColors.redColor,
              textColor: AppColors.whiteColor
          ,gravity:ToastGravity.BOTTOM
          );
        }
      } catch (e) {
        ToastUtils.toastMsg(
            msg: e.toString(),
            backgroundColor: AppColors.redColor,
            textColor: AppColors.whiteColor,
            gravity:ToastGravity.BOTTOM);
      }
    }
  }
}

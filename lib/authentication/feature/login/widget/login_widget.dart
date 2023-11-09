import 'package:authentication_app/authentication/data/model/user_model.dart';
import 'package:authentication_app/authentication/feature/home/widget/home_widget.dart';
import 'package:authentication_app/authentication/feature/login/cubit/cubit/login_cubit.dart';
import 'package:authentication_app/core/data/model/ui_status.dart';
import 'package:authentication_app/core/di/app_injection_container.dart';
import 'package:authentication_app/core/utils/helper.dart';
import 'package:authentication_app/core/widget/button/button.dart';
import 'package:authentication_app/core/widget/textfield/textfield.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final _loginCubit = sl<LoginCubit>();

  @override
  void initState() {
    super.initState();
    subscribeUIStatus();
  }

  void subscribeUIStatus() {
    _loginCubit.uiStatus.listen(
      (uiStatus) {
        if (uiStatus.failedWithoutAlertMessage.isNotEmpty) {
          Helper.showErrorToast(uiStatus.failedWithoutAlertMessage);
        }
        switch (uiStatus.event) {
          case Event.success:
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) =>
                        HomeWidget(uiStatus.data as UserModel)),
                (Route<dynamic> route) => false);
          case Event.failed:
          case Event.none:
          case Event.verified:
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey[300], body: buildBody());
  }

  Widget buildBody() {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildIcons(),
              const SizedBox(
                height: 50,
              ),
              buildTitleText(),
              const SizedBox(
                height: 25,
              ),
              buildUserNameTextField(),
              const SizedBox(height: 10),
              buildPasswordTextField(),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: RaisedRectButton(
                  text: 'Sign in',
                  buttonStatus: _loginCubit.buttonStatus,
                  textColor: Colors.white,
                  onPressed: () {
                    _loginCubit.signInByUserName(
                        usernameController.text, passwordController.text);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIcons() {
    return const Icon(
      Icons.lock,
      size: 100,
    );
  }

  Widget buildTitleText() {
    return Text(
      "Welcome back you\ 've been missed!",
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: 16,
      ),
    );
  }

  Widget buildUserNameTextField() {
    return MyTextField(
      controller: usernameController,
      hintText: 'Username',
      obscureText: false,
    );
  }

  Widget buildPasswordTextField() {
    return MyTextField(
      controller: passwordController,
      hintText: 'Password',
      obscureText: true,
    );
  }
}

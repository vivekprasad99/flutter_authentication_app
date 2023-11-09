import 'dart:convert';

import 'package:authentication_app/authentication/data/model/user_model.dart';
import 'package:authentication_app/core/data/model/button_status.dart';
import 'package:authentication_app/core/data/model/ui_status.dart';
import 'package:authentication_app/core/exception/exception.dart';
import 'package:authentication_app/core/utils/app_log.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/repository/auth_remote_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRemoteRepository _authRemoteRepository;

  final _uiStatus = BehaviorSubject<UIStatus>.seeded(UIStatus());

  Stream<UIStatus> get uiStatus => _uiStatus.stream;

  Function(UIStatus) get changeUIStatus => _uiStatus.sink.add;

  final buttonStatus = BehaviorSubject<ButtonStatus>.seeded(ButtonStatus());

  Function(ButtonStatus) get changeButtonStatus => buttonStatus.sink.add;

  LoginCubit(this._authRemoteRepository) : super(LoginInitial());

  @override
  Future<void> close() {
    _uiStatus.close();
    buttonStatus.close();
    return super.close();
  }

  void signInByUserName(String userName, String password) async {
    try {
      if (checkValidation(userName, password).isNotEmpty) {
        changeUIStatus(UIStatus(
            isDialogLoading: false,
            failedWithoutAlertMessage: checkValidation(userName, password)));
      } else {
        changeButtonStatus(
            ButtonStatus(isLoading: true, message: 'please wait'));
        UserModel userModel =
            await _authRemoteRepository.signInByUserName(userName, password);
        saveDatainLocalDatabase(userModel);
        changeButtonStatus(ButtonStatus(
          isSuccess: true,
        ));
        changeUIStatus(UIStatus(
            isDialogLoading: false, data: userModel, event: Event.success));
      }
    } on ServerException catch (e) {
      changeUIStatus(UIStatus(
          isDialogLoading: false, failedWithoutAlertMessage: e.message!));
      changeButtonStatus(
          ButtonStatus(isLoading: false, isEnable: true, message: e.message!));
    } on FailureException catch (e) {
      changeUIStatus(UIStatus(
          isDialogLoading: false, failedWithoutAlertMessage: e.message!));
      changeButtonStatus(
          ButtonStatus(isLoading: false, isEnable: true, message: e.message!));
    } catch (e, st) {
      AppLog.e('getUserProfile : ${e.toString()} \n${st.toString()}');
      changeUIStatus(
          UIStatus(failedWithoutAlertMessage: 'we regret the technical error'));
      changeButtonStatus(ButtonStatus(isLoading: false, isEnable: true));
    }
  }

  String checkValidation(String userName, String password) {
    if (userName.isEmpty) {
      return "Please Enter UserName";
    } else if (password.isEmpty) {
      return "Please Enter Password";
    } else if (userName.isEmpty || password.isEmpty) {
      return "Please Enter UserName And Password";
    } else {
      return "";
    }
  }

  void saveDatainLocalDatabase(UserModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = jsonEncode(userModel);
    prefs.setString("userData", user);
  }
}

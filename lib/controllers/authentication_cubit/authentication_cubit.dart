import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_states.dart';
import 'package:local_storage/local_storage.dart';

class AuthenticationCubit extends Cubit<AuthenticationStates> {
  AuthenticationCubit() : super(AuthenticationInitialState());

  Future<void> register({
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      emit(RegisterState(stateStatus: StateStatus.loading));
      final bool isSuccess = await sl<IAuthenticationRepository>().register(
        name: name,
        email: email,
        phone: phone,
      );
      if (isSuccess) {
        emit(RegisterState(stateStatus: StateStatus.success));
      } else {
        emit(RegisterState(stateStatus: StateStatus.error));
      }
    } catch (e) {
      emit(RegisterState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> login({
    required String phone,
  }) async {
    try {
      emit(LoginState(stateStatus: StateStatus.loading));
      final Map<String, dynamic> data = await sl<IAuthenticationRepository>().login(
        phone: phone,
      );
      if (data['status'] == 200) {
        emit(LoginState(
          stateStatus: StateStatus.success,
          isRegistered: data['type'] == 'otp',
        ));
      } else {
        emit(LoginState(stateStatus: StateStatus.error));
      }
    } catch (e) {
      emit(LoginState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> otpVerification({
    required String phone,
    required String otp,
  }) async {
    try {
      emit(OTPVerificationState(stateStatus: StateStatus.loading));
      final LoggedUser loggedUser = await sl<IAuthenticationRepository>().otpVerification(
        phone: phone,
        otp: otp,
      );
      emit(OTPVerificationState(stateStatus: StateStatus.success, loggedUser: loggedUser));
    } catch (e) {
      emit(OTPVerificationState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> resendOTP() async {
    try {
      emit(ResendOTPState(stateStatus: StateStatus.loading));

      emit(ResendOTPState(stateStatus: StateStatus.success));
    } catch (e) {
      emit(ResendOTPState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> updateDataLocally({
    required LoggedUser loggedUser,
  }) async {
    await HiveHelper.put(hiveBox: HiveBoxes.user, data: loggedUser.user.toHiveUser);
    await HiveHelper.put(hiveBox: HiveBoxes.accessToken, data: loggedUser.token);
  }
}

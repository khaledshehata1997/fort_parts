import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_states.dart';

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
      final bool isSuccess = await sl<IAuthenticationRepository>().login(
        phone: phone,
      );
      if (isSuccess) {
        emit(LoginState(stateStatus: StateStatus.success));
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
      emit(LoginState(stateStatus: StateStatus.loading));
      await sl<IAuthenticationRepository>().otpVerification(
        phone: phone,
        otp: otp,
      );
      emit(LoginState(stateStatus: StateStatus.success));
    } catch (e) {
      emit(LoginState(stateStatus: StateStatus.error));
      rethrow;
    }
  }
}

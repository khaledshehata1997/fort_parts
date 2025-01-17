import 'package:components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_states.dart';

class AuthenticationCubit extends Cubit<AuthenticationStates> {
  AuthenticationCubit() : super(AuthenticationInitialState());

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      emit(RegisterState(stateStatus: StateStatus.loading));

      emit(RegisterState(stateStatus: StateStatus.success));
    } catch (e) {
      emit(RegisterState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoginState(stateStatus: StateStatus.loading));

      emit(LoginState(stateStatus: StateStatus.success));
    } catch (e) {
      emit(LoginState(stateStatus: StateStatus.error));
      rethrow;
    }
  }
}

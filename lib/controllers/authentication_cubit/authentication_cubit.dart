import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_storage/local_storage.dart';

class AuthenticationCubit extends Cubit<AuthenticationStates> {
  AuthenticationCubit() : super(AuthenticationInitialState());

  Future<void> refresh() async {
    emit(AuthenticationRefreshState());
  }

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

  Future<void> updateProfile({
    required String name,
    required String email,
    required XFile? image,
  }) async {
    try {
      emit(UpdateProfileState(stateStatus: StateStatus.loading));
      final User user = await sl<IAuthenticationRepository>().updateProfile(
        name: name,
        email: email,
        image: image,
      );
      emit(UpdateProfileState(stateStatus: StateStatus.success, user: user));
    } catch (e) {
      emit(UpdateProfileState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> fetchProfile() async {
    try {
      final HiveUser? hiveUser = await HiveHelper.get(hiveBox: HiveBoxes.user);
      if (hiveUser != null) {
        emit(FetchProfileState(stateStatus: StateStatus.loading));
        final User user = await sl<IAuthenticationRepository>().fetchProfile();
        await HiveHelper.put(hiveBox: HiveBoxes.user, data: user.toHiveUser);
        emit(FetchProfileState(stateStatus: StateStatus.success, user: user));
      }
    } catch (e) {
      emit(FetchProfileState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> fetchNotifications({
    required int currentPageIndex,
  }) async {
    try {
      final previousState = state;
      if (previousState is FetchNotificationsState) {
        //in case of pagination
        emit(FetchNotificationsState(
          stateStatus: StateStatus.success,
          notifications: previousState.notifications,
        ));
      } else {
        //in case of first call
        emit(FetchNotificationsState(stateStatus: StateStatus.loading));
      }

      final Notifications notifications = await sl<IAuthenticationRepository>().fetchNotifications(
        currentPageIndex: currentPageIndex,
      );

      final Meta meta = Meta(
        currentPage: notifications.current,
        totalPages: notifications.total,
      );
      final List<Notification> notificationsList = [];

      //in case of pagination
      if (previousState is FetchNotificationsState) {
        notificationsList.addAll(previousState.notifications);
      }

      notificationsList.addAll(notifications.notifications);

      emit(FetchNotificationsState(
        stateStatus: StateStatus.success,
        notifications: notificationsList,
        meta: meta,
      ));
    } catch (e) {
      emit(FetchNotificationsState(stateStatus: StateStatus.error));
      rethrow;
    }
  }
}

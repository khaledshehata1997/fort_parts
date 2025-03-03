import 'package:equatable/equatable.dart';

abstract class LangState extends Equatable{
  const LangState();
}

class SettingsInitial extends LangState {
  @override
  List<Object> get props => [];
}

class SettingsInitialState extends SettingsInitial{}

class SettingsIsLoading extends SettingsInitial{}


class SettingsLoadedWithoutData extends SettingsInitial{


  @override
  List<Object> get props =>[];
}

class SettingsError extends SettingsInitial{
  final String msg;
  SettingsError({required this.msg});

  @override
  List<Object> get props =>[msg];
}
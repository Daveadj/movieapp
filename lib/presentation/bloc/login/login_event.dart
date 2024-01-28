part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LogInInitialEvent extends LoginEvent {
  final String username, password;

  const LogInInitialEvent({required this.username, required this.password});

  @override

  List<Object> get props => [username,password];
}

class LogoutEvent extends LoginEvent{}

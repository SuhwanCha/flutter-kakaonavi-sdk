part of 'navi_bloc.dart';

@immutable
abstract class NaviState {}

class NaviNotInitial extends NaviState {}

class NaviInitial extends NaviState {}

class NaviSuccess extends NaviState {
  final MethodChannel channel;

  NaviSuccess({required this.channel});
}

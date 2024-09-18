part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class LoggedOutState extends ProfileState {}

class GetProfileSuccefully extends ProfileState {
  final UserModel user;
  const GetProfileSuccefully({required this.user});

  @override
  List<Object> get props => [user];
}

class ProfileErrorState extends ProfileState {
  final AppException exception;
  const ProfileErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}

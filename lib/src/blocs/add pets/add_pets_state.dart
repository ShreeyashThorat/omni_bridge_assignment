part of 'add_pets_bloc.dart';

sealed class AddPetsState extends Equatable {
  const AddPetsState();

  @override
  List<Object> get props => [];
}

final class AddPetsInitial extends AddPetsState {}

class AddPetsLoading extends AddPetsState {}

class AddPetsSuccessfully extends AddPetsState {}

class AddPetsError extends AddPetsState {
  final AppException exception;
  const AddPetsError({required this.exception});
}

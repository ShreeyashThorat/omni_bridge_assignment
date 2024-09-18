part of 'add_pets_bloc.dart';

sealed class AddPetsEvent extends Equatable {
  const AddPetsEvent();

  @override
  List<Object> get props => [];
}

class AddPet extends AddPetsEvent {
  final PetsModel pet;
  const AddPet({required this.pet});
}

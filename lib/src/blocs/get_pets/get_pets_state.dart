part of 'get_pets_bloc.dart';

sealed class GetPetsState extends Equatable {
  const GetPetsState();

  @override
  List<Object> get props => [];
}

final class GetPetsInitial extends GetPetsState {}

class PetsLoaded extends GetPetsState {
  final List<PetsModel> pets;
  final bool loadMore;

  const PetsLoaded({
    this.pets = const <PetsModel>[],
    this.loadMore = false,
  });

  PetsLoaded copyWith({List<PetsModel>? newpets, bool? loadMore}) {
    return PetsLoaded(
      pets: newpets ?? pets,
      loadMore: loadMore ?? this.loadMore,
    );
  }

  @override
  List<Object> get props => [pets, loadMore];
}

class ErrorOccuredPets extends GetPetsState {
  final AppException exception;
  const ErrorOccuredPets({required this.exception});

  @override
  List<Object> get props => [exception];
}

part of 'get_pets_bloc.dart';

sealed class GetPetsEvent extends Equatable {
  const GetPetsEvent();

  @override
  List<Object> get props => [];
}

class GetPets extends GetPetsEvent {
  final bool loadmore;
  final String category;
  const GetPets({required this.category, this.loadmore = false});
}

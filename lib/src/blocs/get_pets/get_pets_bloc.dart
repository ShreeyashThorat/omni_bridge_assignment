import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omni_bridge_assignment/src/core/error%20handler/app_exception.dart';
import 'package:omni_bridge_assignment/src/models/pets_model.dart';
import 'package:omni_bridge_assignment/src/repositories/pets_repo.dart';

part 'get_pets_event.dart';
part 'get_pets_state.dart';

class GetPetsBloc extends Bloc<GetPetsEvent, GetPetsState> {
  GetPetsBloc() : super(GetPetsInitial()) {
    List<PetsModel> pets = [];
    String lastId = "";
    on<GetPets>((event, emit) async {
      try {
        if (state is GetPetsInitial || event.loadmore == false) {
          pets = await PetsRepo().getPets(event.category);
          if (pets.isNotEmpty) {
            lastId = pets.last.id!;
          }
          return emit(PetsLoaded(pets: pets));
        } else if (state is PetsLoaded && event.loadmore == true) {
          PetsLoaded currentState = state as PetsLoaded;
          final morePets =
              await PetsRepo().getPets(event.category, lastPetId: lastId);
          if (morePets.isNotEmpty) {
            lastId = morePets.last.id!;
          }
          return morePets.isEmpty
              ? emit(currentState.copyWith(loadMore: true))
              : emit(currentState.copyWith(
                  newpets: currentState.pets + morePets, loadMore: false));
        }
      } on AppException catch (e) {
        emit(ErrorOccuredPets(exception: e));
        e.print;
      } catch (e) {
        emit(ErrorOccuredPets(exception: AppException()));
      }
    });
  }
}

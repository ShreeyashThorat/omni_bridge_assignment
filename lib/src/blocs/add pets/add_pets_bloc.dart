import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omni_bridge_assignment/src/repositories/pets_repo.dart';

import '../../core/error handler/app_exception.dart';
import '../../models/pets_model.dart';

part 'add_pets_event.dart';
part 'add_pets_state.dart';

class AddPetsBloc extends Bloc<AddPetsEvent, AddPetsState> {
  AddPetsBloc() : super(AddPetsInitial()) {
    on<AddPet>((event, emit) async {
      emit(AddPetsLoading());
      try {
        await PetsRepo().addNewPet(event.pet);
        emit(AddPetsSuccessfully());
      } on AppException catch (e) {
        emit(AddPetsError(exception: e));
        e.print;
      } catch (e) {
        emit(AddPetsError(exception: AppException()));
      }
    });
  }
}

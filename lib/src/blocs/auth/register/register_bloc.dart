import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omni_bridge_assignment/src/repositories/authentication_repo.dart';

import '../../../core/error handler/app_exception.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterWithEmailAndPass>((event, emit) async {
      emit(RegisterLoading());
      try {
        await AuthenticationRepo().createUserWithEmailAndPassword(
            event.email, event.pass, event.name, event.contact);
        emit(RegisterSuccessfully());
      } on AppException catch (e) {
        emit(RegisterError(exception: e));
        e.print;
      } catch (e) {
        emit(RegisterError(exception: AppException()));
      }
    });
  }
}

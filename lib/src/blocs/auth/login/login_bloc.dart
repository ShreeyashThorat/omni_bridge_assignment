import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omni_bridge_assignment/src/repositories/authentication_repo.dart';

import '../../../core/error handler/app_exception.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginWithEmailAndPass>((event, emit) async {
      emit(LoginLoading());
      try {
        await AuthenticationRepo()
            .loginWithEmailAndPassword(event.email, event.pass);
        emit(LoginSuccessfully());
      } on AppException catch (e) {
        emit(LoginError(exception: e));
        e.print;
      } catch (e) {
        emit(LoginError(exception: AppException()));
      }
    });
  }
}

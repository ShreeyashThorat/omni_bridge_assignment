import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:omni_bridge_assignment/src/core/error%20handler/app_exception.dart';
import 'package:omni_bridge_assignment/src/models/user_model.dart';
import 'package:omni_bridge_assignment/src/repositories/authentication_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetProfile>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final user = await FirebaseAuth.instance.authStateChanges().first;
        if (user == null) {
          emit(LoggedOutState());
        } else {
          String uid = user.uid;
          final userData = await AuthenticationRepo().getUserData(uid);
          emit(GetProfileSuccefully(user: userData));
        }
      } on AppException catch (e) {
        emit(ProfileErrorState(exception: e));
        e.print;
      } catch (e) {
        emit(ProfileErrorState(exception: AppException()));
      }
    });
  }
}

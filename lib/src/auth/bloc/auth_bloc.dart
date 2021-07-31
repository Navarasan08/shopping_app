import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_app/services/firebase_authentication.dart';
import 'package:shopping_app/services/firestore_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({this.authService, this.firestoreService}) : super(AuthInitial());
  final FirebaseAuthService authService;
  final FirestoreService firestoreService;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is CheckAuthenticated) {
      try {
        yield (LoginInProgress());
        User user = authService.getCurrentUser();

        if (user != null) {
          yield (LoggedIn(user));
        } else {
          yield (UnAuthenticated());
        }
      } catch (e) {
        yield (UnAuthenticated());
      }
    }
    if (event is Login) {
      try {
        yield (LoginInProgress());
        await authService.signInWithEmailAndPassword(
            event.email, event.password);
        User user = authService.getCurrentUser();

        yield (LoggedIn(user));
      } catch (e) {
        if (e is String)
          yield (LoginError(e));
        else
          yield (LoginError("Invalid Email or Password"));
      }
    }
    if (event is SignUp) {
      try {
        yield (SignUpInProgress());
        await authService.registerAccount(
          email: event.email,
          password: event.password,
          displayName: event.name,
        );
        User user = authService.getCurrentUser();

        yield (LoggedIn(user));
      } catch (e) {
        if (e is String)
          yield (SignUpError(e));
        else
          yield (SignUpError("Invalid details"));
      }
    }

    if (event is LogOut) {
      authService.signOut();
      yield (UnAuthenticated());
    }
  }
}

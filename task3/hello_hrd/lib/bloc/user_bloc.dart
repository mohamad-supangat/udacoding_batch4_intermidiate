import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/user.dart';
import '../helpers/helpers.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  UserState get initialState => UserLoaded(null);

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetUser) {
      yield* getUser();
    }
  }

  Stream<UserState> getUser() async* {
    print('state pada block user sekarang');
    print(state);
    try {
      final User user = await Auth().getUser();
      // print(response.data['popular']);
      yield UserLoaded(user);
    } catch (_) {
      yield UserError();
    }
  }
}

// flutter bloc event
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUser extends UserEvent {}

class RefreshUser extends UserEvent {}

// flutter bloc state
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final User user;

  UserLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserError extends UserState {}

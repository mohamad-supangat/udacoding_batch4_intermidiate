import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/employee.dart';
import '../database.dart';

// bloc
class ListEmployeesBloc extends Bloc<ListEmployeesEvent, ListEmployeesState> {
  ListEmployeesBloc() : super(ListEmployeesInitial());

  @override
  Stream<ListEmployeesState> mapEventToState(
    ListEmployeesEvent event,
  ) async* {
    if (event is GetListEmployees) {
      yield* getEmployees();
    }
    if (event is RefreshListEmployees) {
      yield ListEmployeesInitial();
      yield* getEmployees();
    }
  }
}

Stream<ListEmployeesState> getEmployees() async* {
  final DBProvider _db = DBProvider();
  try {
    final List<Employee> _employees = await _db.getEmployees();
    yield ListEmployeesLoaded(_employees);
  } catch (_) {
    yield ListEmployeesError();
  }
}

// state of flutter bloc
abstract class ListEmployeesState extends Equatable {
  const ListEmployeesState();

  @override
  List<Object> get props => [];
}

class ListEmployeesInitial extends ListEmployeesState {}

class ListEmployeesLoaded extends ListEmployeesState {
  final List<Employee> employees;

  ListEmployeesLoaded(this.employees);

  @override
  List<Object> get props => [employees];
}

class ListEmployeesError extends ListEmployeesState {}

// event of flutter bloc
abstract class ListEmployeesEvent extends Equatable {
  const ListEmployeesEvent();

  @override
  List<Object> get props => [];
}

class GetListEmployees extends ListEmployeesEvent {}

class RefreshListEmployees extends ListEmployeesEvent {}

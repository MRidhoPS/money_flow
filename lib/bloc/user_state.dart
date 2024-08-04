import 'package:equatable/equatable.dart';

// import '../models/user_models.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

// state awal
class UsersInitial extends UserState {}

// state loading
class UserLoading extends UserState {}

// state ketika berhasil loading data
class UserLoaded extends UserState {
  final List<dynamic> user;

  UserLoaded(this.user);

  // @override
  // List<Object> get props => [user]; 
}

class UserSuccess extends UserState{
  final String success;

  UserSuccess(this.success);

  @override
  List<Object> get props => [success];
}

class UserError extends UserState{
  final String error;

  UserError(this.error);

  @override
  List<Object> get props => [error];
}

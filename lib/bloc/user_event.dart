import 'package:equatable/equatable.dart';
import 'package:money_flow/models/user_models.dart';

abstract class UserEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchData extends UserEvent{}

class CreateData extends UserEvent{
  final Users user;

  CreateData(this.user);

  @override
  List<Object> get props => [user];
}

class UpdateData extends UserEvent{
  final Users users;

  UpdateData(this.users);


  @override
  List<Object> get props => [users];
}

class DeleteUsers extends UserEvent {
  final Users users;

  DeleteUsers(this.users);

  @override
  List<Object> get props => [Users];
}

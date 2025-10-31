import 'package:equatable/equatable.dart';

class LoggedUser extends Equatable {
  final String name;
  final String? email;

  const LoggedUser({required this.name, this.email});

  @override
  List<Object?> get props => [name, email];
}

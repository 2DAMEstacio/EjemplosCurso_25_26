import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String? token;

  const User({required this.id, required this.email, this.token});

  Map<String, dynamic> toJson() => {'id': id, 'email': email, 'token': token};
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as String,
    email: json['email'] as String,
    token: json['token'] as String,
  );

  @override
  List<Object?> get props => [id, email, token];
}

import 'package:equatable/equatable.dart';

class OwnerEntity extends Equatable {
  final int id;
  final String login;
  final String avatarUrl;

  const OwnerEntity({
    required this.id,
    required this.login,
    required this.avatarUrl,
  });

  @override
  List<Object> get props => [id, login, avatarUrl];
}
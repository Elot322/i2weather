import 'package:equatable/equatable.dart';

class ApiKeyEntity extends Equatable {
  final String apiKey;

  const ApiKeyEntity({required this.apiKey});

  @override
  List<Object?> get props => [apiKey];
}

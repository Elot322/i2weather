import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String status;
  final String description;

  const Weather({
    required this.status,
    required this.description,
  });

  @override
  List<Object?> get props => [
        status,
        description,
      ];
}

import 'package:equatable/equatable.dart';

class PickState extends Equatable {
  const PickState();
  @override
  List<Object?> get props => [];
}

class InitPickState extends PickState {
  const InitPickState();
  @override
  List<Object?> get props => [];
}

class HasDataPickState extends PickState {
  const HasDataPickState();
  @override
  List<Object?> get props => [];
}

class ErrorPickState extends PickState {
  final String message;
  const ErrorPickState({required this.message});
  @override
  List<Object?> get props => [];
}

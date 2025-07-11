import 'package:equatable/equatable.dart';

sealed class GetZikrCubitState implements Equatable {}

class GetZikrCubitInitialState implements GetZikrCubitState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => throw UnimplementedError();
}

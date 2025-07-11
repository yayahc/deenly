abstract class AppError {
  String getError();
}

class GenericAppError implements AppError {
  final String errorMessage;

  GenericAppError({required this.errorMessage});

  @override
  String getError() => errorMessage;
}

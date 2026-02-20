abstract class SystemError {
  final String devErrorMessage;
  final String userFriendlyDevErrorMessage;
  String? stackTrace;

  SystemError({
    required this.devErrorMessage,
    required this.userFriendlyDevErrorMessage,
    required String? stackTrace,
  });

  Map<String, dynamic> toJson() => {
    "devErrorMessage": devErrorMessage,
    "userFriendlydevErrorMessage": userFriendlyDevErrorMessage,
    "stackTrace": stackTrace,
  };
}

class GenericError extends SystemError {
  GenericError({
    required super.devErrorMessage,
    required super.userFriendlyDevErrorMessage,
    super.stackTrace,
  });
}

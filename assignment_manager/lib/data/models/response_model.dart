class ResponseModel {
  final bool isSuccess;
  final int statusCode;
  final dynamic responseBody;
  final String? errorMessage;

  ResponseModel({
    required this.isSuccess,
    required this.statusCode,
    required this.responseBody,
    this.errorMessage = '',
  });
}

class ApiResponse<T> {
  final bool success;
  final String message;
  final T response;

  ApiResponse(this.success, this.message, this.response);
}

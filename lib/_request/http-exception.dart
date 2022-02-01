class ApiHttpException implements Exception {
  final String message;
  /*
   * Pass your message in constructor.
   */
  const ApiHttpException(this.message);

  @override
  String toString() {
    return message;
  }

}
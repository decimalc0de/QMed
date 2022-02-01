class ApiResponse {
  /*
   *
   */
  bool success;

  /*
   *
   */
  var miscellaneousData;

  /*
   *
   */
  String message;

  ApiResponse({
    required this.success,
    this.miscellaneousData,
    required this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
        success: json['success'],
        miscellaneousData: json['miscellaneousData'],
        message: json['message']
    );
  }

}
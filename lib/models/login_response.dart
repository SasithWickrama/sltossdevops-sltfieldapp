class LoginResponse {
  final int result;
  var data;
  final String message;
  final String token;

  LoginResponse({this.result=1, this.data = null, this.message = '',this.token = '',});

  factory LoginResponse.fromJson(Map<String, dynamic> responsejson) {
    final result   = responsejson['result'] as int;
    final message = responsejson['message'] as String;
    final token = responsejson['token'] ?? "";
    final data    = responsejson['data'] ?? "";

    return LoginResponse(result: result, message: message,token:token, data: data);
  }
}

class GeneralResponse {
  final int result;
  final String message;
  var data;

  GeneralResponse({this.result= 1, this.message = '', this.data=null});

  factory GeneralResponse.fromJson(Map<String, dynamic> responsejson) {
    final result   = responsejson['result'] as int;
    final message = responsejson['message'] as String;
    final data    = responsejson['data'] ?? "";

    return GeneralResponse(result: result, message: message, data: data);
  }

}
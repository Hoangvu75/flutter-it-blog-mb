class BaseResponse<T> {
  int? code;
  T? data;
  bool? success;
  String? error;

  BaseResponse({this.code, this.data, this.success, this.error});

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse<T>(
        code: json['code'] as int?,
        data: json['data'],
        success: json['success'] as bool?,
        error: json['error'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': this.code,
        'data': this.data,
        'success': this.success,
        'error': this.error,
      };

  T parse<T>(T Function(Map<String, dynamic> map) jsonConvertor) {
    return jsonConvertor(data as dynamic);
  }

  List<T> parseList<T>(T Function(Map<String, dynamic> map) jsonConvertor) {
    List items = data as dynamic;
    return items.map((element) {
      return jsonConvertor(element);
    }).toList();
  }

  bool isSuccess() {
    if (success == null || code == null) {
      return false;
    }
    return success == true && (code! >= 200 && code! < 300);
  }
}

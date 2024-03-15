import 'package:freezed_annotation/freezed_annotation.dart';

part 'base.response.g.dart';

@JsonSerializable()
class BaseResponse<T> {
  int? code;
  T? data;
  bool? success;
  String? error;

  BaseResponse({this.code, this.data, this.success, this.error});

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);

  T parse(T Function(Map<String, dynamic> map) jsonConvertor) {
    return jsonConvertor(data as dynamic);
  }

  List<T> parseList(T Function(Map<String, dynamic> map) jsonConvertor) {
    List items = data as dynamic;
    return items.map((element) {
      return jsonConvertor(element);
    }).toList();
  }
}

class Status {
  final int code;
  final String message;
  final bool isSuccess;

  Status({required this.code, required this.message, required this.isSuccess});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      code: json['code'] as int,
      message: json['message'] as String,
      isSuccess: json['isSuccess'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'isSuccess': isSuccess,
  };
}

class BaseResponse<T> {
  final Status status;
  final T? data;

  BaseResponse({required this.status, this.data});

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json)? fromJsonT,
  ) {
    return BaseResponse(
      status: Status.fromJson(json['status'] as Map<String, dynamic>),
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {'status': status.toJson(), 'data': data};
}

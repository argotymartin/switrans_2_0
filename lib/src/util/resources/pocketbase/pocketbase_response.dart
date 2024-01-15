class PocketBaseResponse {
  dynamic record;
  dynamic token;

  PocketBaseResponse({
    this.record,
    this.token,
  });

  factory PocketBaseResponse.fromJson(Map<String, dynamic> json) => PocketBaseResponse(
        record: json['record'],
        token: json['token'],
      );
}

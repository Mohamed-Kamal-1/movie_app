/// message : "Profile deleted successfully"
library;

class DeleteAccountDto {
  DeleteAccountDto({
      this.message,});

  DeleteAccountDto.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}
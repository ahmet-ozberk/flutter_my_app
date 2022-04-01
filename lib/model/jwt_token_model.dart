class JwtTokenModel {
  String? email;
  int? iat;
  JwtTokenModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    iat = json['iat'];
  }
}

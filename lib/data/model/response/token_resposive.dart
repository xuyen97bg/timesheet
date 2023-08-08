
import '../body/user.dart';

class TokenResponsive {
  String? accessToken;
  String? tokenType;
  String? refreshToken;
  int? expiresIn;
  String? scope;
  User? user;
  String? jti;

  TokenResponsive(
      {this.accessToken,
        this.tokenType,
        this.refreshToken,
        this.expiresIn,
        this.scope,
        this.user,
        this.jti});

  TokenResponsive.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    refreshToken = json['refresh_token'];
    expiresIn = json['expires_in'];
    scope = json['scope'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    jti = json['jti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['refresh_token'] = this.refreshToken;
    data['expires_in'] = this.expiresIn;
    data['scope'] = this.scope;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['jti'] = this.jti;
    return data;
  }
}
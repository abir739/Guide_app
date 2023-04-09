class User {
  String id;
  String role;
  String username;
  String password;
  String salt;
  String phone;
  String email;
  String gender;
  String firstName;
  String lastName;
  Map<String, dynamic> birthDate;
  String picture;
  String address;
  String zipCode;
  String countryId;
  String stateId;
  String cityId;
  String languageId;
  String secondLanguageId;
  String facebookKey;
  String profile;
  bool enableOauth;
  int sessionTimeout;
  bool multipleSession;
  bool phoneValidated;
  String phoneValidationCode;
  bool emailValidated;
  String emailValidationCode;
  String authenticationMode;
  bool enabled;
  String confirmationToken;
  Map<String, dynamic> passwordRequestedAt;
  bool locked;
  bool expired;
  Map<String, dynamic> expiresAt;
  bool credentialsExpired;
  Map<String, dynamic> credentialsExpireAt;
  Map<String, dynamic> lastLogin;
  Map<String, dynamic> lastFailedLogin;
  int loginCount;
  int failedLoginCount;
  int lastFailedLoginCount;
  Map<String, dynamic> createdAt;
  String creatorUserId;
  Map<String, dynamic> updatedAt;
  String updaterUserId;
  bool isSelected;

  User(
      {required this.id,
      required this.role,
      required this.username,
      required this.password,
      required this.salt,
      required this.phone,
      required this.email,
      required this.gender,
      required this.firstName,
      required this.lastName,
      required this.birthDate,
      required this.picture,
      required this.address,
      required this.zipCode,
      required this.countryId,
      required this.stateId,
      required this.cityId,
      required this.languageId,
      required this.secondLanguageId,
      required this.facebookKey,
      required this.profile,
      required this.enableOauth,
      required this.sessionTimeout,
      required this.multipleSession,
      required this.phoneValidated,
      required this.phoneValidationCode,
      required this.emailValidated,
      required this.emailValidationCode,
      required this.authenticationMode,
      required this.enabled,
      required this.confirmationToken,
      required this.passwordRequestedAt,
      required this.locked,
      required this.expired,
      required this.expiresAt,
      required this.credentialsExpired,
      required this.credentialsExpireAt,
      required this.lastLogin,
      required this.lastFailedLogin,
      required this.loginCount,
      required this.failedLoginCount,
      required this.lastFailedLoginCount,
      required this.createdAt,
      required this.creatorUserId,
      required this.updatedAt,
      required this.updaterUserId,
      this.isSelected = false});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      role: json['role'],
      username: json['username'],
      password: json['password'],
      salt: json['salt'],
      phone: json['phone'],
      email: json['email'],
      gender: json['gender'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthDate: json['birthDate'],
      picture: json['picture'],
      address: json['address'],
      zipCode: json['zipCode'],
      countryId: json['countryId'],
      stateId: json['stateId'],
      cityId: json['cityId'],
      languageId: json['languageId'],
      secondLanguageId: json['secondLanguageId'],
      facebookKey: json['facebookKey'],
      profile: json['profile'],
      enableOauth: json['enableOauth'],
      sessionTimeout: json['sessionTimeout'],
      multipleSession: json['multipleSession'],
      phoneValidated: json['phoneValidated'],
      phoneValidationCode: json['phoneValidationCode'],
      emailValidated: json['emailValidated'],
      emailValidationCode: json['emailValidationCode'],
      authenticationMode: json['authenticationMode'],
      enabled: json['enabled'],
      confirmationToken: json['confirmationToken'],
      passwordRequestedAt: json['passwordRequestedAt'],
      locked: json['locked'],
      expired: json['expired'],
      expiresAt: json['expiresAt'],
      credentialsExpired: json['credentialsExpired'],
      credentialsExpireAt: json['credentialsExpireAt'],
      lastLogin: json['lastLogin'],
      lastFailedLogin: json['lastFailedLogin'],
      loginCount: json['loginCount'],
      failedLoginCount: json['failedLoginCount'],
      lastFailedLoginCount: json['lastFailedLoginCount'],
      createdAt: json['createdAt'],
      creatorUserId: json['creatorUserId'],
      updatedAt: json['updatedAt'],
      updaterUserId: json['updaterUserId'],
      isSelected: json['isSelected'],
    );
  }
}

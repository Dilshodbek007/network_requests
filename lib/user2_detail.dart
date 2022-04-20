

  class User2{
  String OTP;
  String token;
  String phone;
  User2({required this.phone,required this.OTP,required this.token});

  User2.fromJson(Map<String?, dynamic> json)
      :phone = json['phone'],
        OTP = json['OTP'],
        token = json['token'];

  Map<String?, dynamic> toJson() => {
  'phone': phone,
    'OTP':OTP,
    'token':token
  };
  }


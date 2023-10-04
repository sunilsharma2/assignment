class SignedModel
{
  late final String user_email;
  late final String user_uid;


  SignedModel({required this.user_email,required this.user_uid});

  factory SignedModel.fromJson(Map<String, dynamic> parsedJson)
  {
    return SignedModel(
        user_email: parsedJson['user_email'],
        user_uid: parsedJson['user_uid']
    );
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_email'] = user_email;
    data['user_uid'] = user_uid;
    return data;
  }
}
class UserModel{
  final String id;
  final String email;
  final String userName;
  final String passsword;
  UserModel({required this.email,required this.id,required this.userName,required this.passsword});
  factory UserModel.fromJson(Map<String, dynamic> json)=>UserModel(
    id: json["id"],
    email: json["email"],
    userName: json["userName"],
    passsword: json["password"]
  );
  Map<String,dynamic>toJson(){
    return {
      "id":id,
      "email":email,
      "userName":userName,
      "password":passsword
    };
  }
  }


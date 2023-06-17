
import 'package:pandora_flutter_mobile/domain/entities/user_statistics.dart';

class User{

  int id;
  String uid;
  String name;
  String email;
  String accessToken;
  String phone;
  String city;
  String age;
  String gender;
  String photoUrl;
  int roleId;
  String createdAt;
  String updatedAt;
  UserStatistics userStatistics;

  User({
    required this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.accessToken,
    required this.phone,
    required this.city,
    required this.age,
    required this.gender,
    required this.photoUrl,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
    required this.userStatistics,
    /*
    required this.rank,
    required this.level,
    required this.nextLevel,
    required this.levelProgress,
    required this.questionTotal,
    required this.questionPassed,
    required this.questionFailed,
    required this.coinTotal,
    required this.coinExchanged,
    required this.coinCurrent,
    required this.createdAt,
    required this.modifiedAt,
    required this.createdAgo,
    required this.modifiedAgo,
    required this.accessToken

     */
  });



  static User get sample{
    return User(
        id: 0,
        uid: "uid",
        name: "name",
        email: "email",
        accessToken: "accessToken",
        phone: "phone",
        city: "city",
        age: "age",
        gender: "gender",
        photoUrl: "photoUrl",
        roleId: 0,
        createdAt: "createdAt",
        updatedAt: "updatedAt",
        userStatistics: UserStatistics.sample
    );
  }
}
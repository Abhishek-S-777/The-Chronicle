import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  String userID;
  String uemail;
  String uname;
  String upic;
  String uphno;
  String fulladd;
  String landmark;


  UserProfileModel(
      {
        this.userID,
        this.uemail,
        this.uname,
        this.upic,
        this.uphno,
        this.fulladd,
        this.landmark,
      });

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    uemail = json['email'];
    uname = json['name'];
    upic  = json['url'];
    uphno = json['phoneNumber'];
    fulladd = json['fullAddress'];
    landmark = json['landmark'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID']=this.userID;
    data['email'] = this.uemail;
    data['name'] = this.uname;
    data['url'] = this.upic;
    data['phoneNumber'] = this.uphno;
    data['fullAddress'] = this.fulladd;
    data['landmark'] = this.landmark;

    return data;
  }
}


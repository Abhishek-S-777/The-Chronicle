import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String productID;
  String category;
  String title;
  String shortInfo;
  String issue;
  Timestamp publishedDate;
  String thumbnailUrl;
  String longDescription;
  String status;
  String subscriptionStatus;
  int price;

  ItemModel(
      {this.productID,
        this.category,
        this.title,
        this.shortInfo,
        this.issue,
        this.publishedDate,
        this.thumbnailUrl,
        this.longDescription,
        this.subscriptionStatus,
        this.status,
        });

  ItemModel.fromJson(Map<String, dynamic> json) {
    productID=json['productID'];
    category = json['category'];
    title = json['title'];
    shortInfo = json['shortInfo'];
    issue = json['issue'];
    publishedDate = json['publishedDate'];
    thumbnailUrl = json['thumbnailUrl'];
    longDescription = json['longDescription'];
    subscriptionStatus = json['subscriptionStatus'];
    status = json['status'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productID']=this.productID;
    data['category'] = this.category;
    data['title'] = this.title;
    data['shortInfo'] = this.shortInfo;
    data['issue'] = this.issue;
    data['price'] = this.price;
    if (this.publishedDate != null) {
      data['publishedDate'] = this.publishedDate;
    }
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['longDescription'] = this.longDescription;
    data['subscriptionStatus'] = this.subscriptionStatus;
    data['status'] = this.status;
    return data;
  }
}

class PublishedDate {
  String date;

  PublishedDate({this.date});

  PublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}

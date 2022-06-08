
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:sms/sms.dart';

import 'package:thechronicle/src/Address/address.dart';
import 'package:thechronicle/src/InvoicePDF/api/pdf_api.dart';
import 'package:thechronicle/src/InvoicePDF/page/pdf_page.dart';
import 'package:thechronicle/src/constants/config.dart';
import 'package:thechronicle/src/model/addressmodel.dart';
import 'package:thechronicle/src/widgets/loadingWidget.dart';
import 'package:thechronicle/src/widgets/orderCard.dart';
import 'package:thechronicle/src/widgets/qr_code.dart';
import 'package:thechronicle/src/widgets/button_widget.dart';
import 'package:flutter/services.dart';
import 'package:mailer/smtp_server.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';




import 'package:qr_flutter/qr_flutter.dart';

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

String getOrderId="";
class OrderDetails extends StatefulWidget
{
  final String orderID;

  OrderDetails({Key key, this.orderID,}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  List<DocumentSnapshot> orderItems1;
  Map dataMap;


  @override
  Widget build(BuildContext context)
  {
    getOrderId = widget.orderID;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot>(
            future:  FirebaseFirestore.instance
                    .collection(respawn.collectionUser)
                    .doc(respawn.sharedPreferences.getString(respawn.userUID))
                    .collection(respawn.collectionOrders)
                    .doc(widget.orderID)
                    .get(),
            builder: (c, snapshot)
            {
              num totalamt;
              // Map dataMap;
              if(snapshot.hasData)
              {
                dataMap = snapshot.data.data();
                totalamt = dataMap[respawn.totalAmount];
              }

              return snapshot.hasData
                  ? Container(
                      child: Column(
                        children: [
                          StatusBanner(status: dataMap[respawn.isSuccess],),
                          SizedBox(height: 15.0,),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "₹ " + dataMap[respawn.totalAmount].toString(),
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Order ID: " + getOrderId),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Subscription Type: " + dataMap["subscriptionStatus"].toString()),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Ordered On: " + DateFormat("dd MMMM, yyyy - hh:mm aa")
                                  .format(DateTime.fromMillisecondsSinceEpoch(int.parse(dataMap["orderTime"]))),
                              style: TextStyle(color: Colors.grey, fontSize: 16.0),
                            ),
                          ),
                          Divider(height: 2.0,),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("products")
                                .where("shortInfo", whereIn: dataMap[respawn.productID])
                                .snapshots(),
                            builder: (c, dataSnapshot)
                            {
                              if(dataSnapshot.hasData){
                                orderItems1 = dataSnapshot.data.docs;
                                print("Order items inside listt");
                                print(orderItems1);
                              }
                              return dataSnapshot.hasData
                                  ? OrderCard(
                                      itemCount: dataSnapshot.data.docs.length,
                                      data: dataSnapshot.data.docs,
                                    )
                                  : Center(child: circularProgress(),);
                            },
                          ),
                          Divider(height: 2.0,),
                          FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection(respawn.collectionUser)
                                .doc(respawn.sharedPreferences.getString(respawn.userUID))
                                .collection(respawn.subCollectionAddress)
                                .doc(dataMap[respawn.addressID])
                                .get(),

                            builder: (c, snap)
                            {
                              print("orderitems1 again $orderItems1");
                              return snap.hasData && orderItems1!=null
                                  // ? ShippingDetails(model: AddressModel.fromJson(snap.data.data()), orderItems2: orderItems1, totamt: totalamt,orderID1: orderID,)
                                  ? ShippingDetails(orderItems1,model: AddressModel.fromJson(snap.data.data()), totamt: totalamt,orderID1: widget.orderID,dataMap: dataMap,)
                                  : Center(child: circularProgress(),);
                            },
                          ),
                        ],
                      ),
                    )
                  : Center(child: circularProgress(),);
            },
          ),
        ),
      ),
    );
  }
}

class StatusBanner extends StatelessWidget
{
  final bool status;

  StatusBanner({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    String msg;
    IconData iconData;

    status ? iconData = Icons.done : iconData = Icons.cancel;
    status ? msg = "Successfully" : msg = "UnSuccessful";

    return Container(
      decoration: new BoxDecoration(
        gradient: LinearGradient(
          // begin: const FractionalOffset(0.0, 0.0),
          // end: const FractionalOffset(1.0, 0.0),
          // stops: [0.0, 1.0,3.0],
            begin: Alignment.bottomRight,
            colors: [
              Colors.deepOrangeAccent.withOpacity(.7),
              // Colors.deepPurpleAccent.withOpacity(.6),
              Colors.black.withOpacity(.4),
            ]
        ),
      ),
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: ()
            {
              SystemNavigator.pop();
            },
            child: Container(
              child: Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          Text(
            "Order Placed " + msg,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 5.0,),
          CircleAvatar(
            radius: 8.0,
            backgroundColor: Colors.grey,
            child: Center(
              child: Icon(
                iconData,
                color: Colors.white,
                size: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class ShippingDetails  extends StatefulWidget
{
  final AddressModel model;
  final List<DocumentSnapshot> orderItems2;
  final double totamt;
  final String orderID1;
  final Map dataMap;

  // ShippingDetails({Key key, this.model, this.orderItems2, this.totamt,this.orderID1}) : super(key: key);
  ShippingDetails(this.orderItems2,{Key key, this.model, this.totamt,this.orderID1, this.dataMap}) : super(key: key);

  @override
  _ShippingDetailsState createState() => _ShippingDetailsState();
}

class _ShippingDetailsState extends State<ShippingDetails> {
  bool isDelivered=false;
  String _chosenValue;
  String startDate;
  String endDate;
  DateTimeRange dateRange;


  @override
  Widget build(BuildContext context)
  {
    FirebaseFirestore.instance
        .collection(respawn.collectionUser)
        .doc(respawn.sharedPreferences.getString(respawn.userUID))
        .collection(respawn.collectionOrders)
        .doc(getOrderId)
        .get().then((value) {
          setState(() {
            isDelivered = value['isDelivered'];
            print("isDelivered status isnide build: "+isDelivered.toString());
          });

      // setState(() {
      //     });
    });
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0,),
          child: Text(
            "Shipment Details:",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 90.0, vertical: 5.0),
          width: screenWidth,
          child: Table(
            children: [

              TableRow(
                  children: [
                    KeyText(msg: "Name",),
                    Text(widget.model.name),
                  ]
              ),

              TableRow(
                  children: [
                    KeyText(msg: "Phone Number",),
                    Text(widget.model.phoneNumber),
                  ]
              ),

              TableRow(
                  children: [
                    KeyText(msg: "Flat Number",),
                    Text(widget.model.flatNumber),
                  ]
              ),

              TableRow(
                  children: [
                    KeyText(msg: "City",),
                    Text(widget.model.city),
                  ]
              ),

              TableRow(
                  children: [
                    KeyText(msg: "State",),
                    Text(widget.model.state),
                  ]
              ),

              TableRow(
                  children: [
                    KeyText(msg: "Pin Code",),
                    Text(widget.model.pincode),
                  ]
              ),

            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap:  ()
              {
                print("isdelivered is true");
                print(widget.orderItems2);
                if(widget.orderItems2!=null){
                  print("printing order items: "+widget.orderItems2.toString());
                  Fluttertoast.showToast(msg:"orderitems is not null" );
                  print("orderitems is not null");
                  Route route = MaterialPageRoute(builder: (c) => PdfPage(model2: widget.model,orderItems3: widget.orderItems2, totamt1: widget.totamt,orderID: widget.orderID1,));
                  Navigator.pushReplacement(context, route);
                  confirmedUserOrderReceived(context, getOrderId);
                }
                else if(widget.orderItems2!=null){
                  print("Order Items is null, debug");
                  Fluttertoast.showToast(msg:"Order Items is null, debug");
                }
              },
              child: Container(
                decoration: new BoxDecoration(
                  gradient: LinearGradient(
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0,3.0],
                      // begin: Alignment.bottomRight,
                      colors: [
                        Colors.pinkAccent.withOpacity(.5),
                        Colors.orange.withOpacity(.5),
                        Colors.deepOrangeAccent.withOpacity(.4),
                      ]
                  ),
                ),
                width: MediaQuery.of(context).size.width - 40.0,
                height: 50.0,
                child: Center(
                  child: Text(
                    "Download Invoice",
                    style: TextStyle(color: Colors.white, fontSize: 15.0,),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),

        Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap:  ()
              {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState /*You can rename this!*/){
                          return Container(
                            height: 200,
                            color: Colors.amberAccent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text('* Select the Start and End date to pause',style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                                ),
                                ),

                                Row(
                                  children: [
                                    // const SizedBox(width: 18),
                                    Expanded(
                                      child: ButtonWidget(
                                        text: getFrom(),
                                        onClicked: () => pickDateRange(context),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(Icons.arrow_forward, color: Colors.blue),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: ButtonWidget(
                                        text: getUntil(),
                                        onClicked: () => pickDateRange(context),
                                      ),
                                    ),
                                  ],
                                ),
                                // const Text('For more than 15 days you have to cancel the subscription'),
                                // DropdownButton<String>(
                                //   value: _chosenValue,
                                //   elevation: 5,
                                //   style: TextStyle(color: Colors.black),
                                //   items: <String>[
                                //     '1 day',
                                //     '2 days',
                                //     '3 days',
                                //     '4 days',
                                //     '5 days',
                                //     '6 days',
                                //     '7 days',
                                //   ].map<DropdownMenuItem<String>>((String value) {
                                //     return DropdownMenuItem<String>(
                                //       value: value,
                                //       child: Text(value),
                                //     );
                                //   }).toList(),
                                //   hint: Text(
                                //     "Please choose the number of days",
                                //     style: TextStyle(
                                //       color: Colors.black,
                                //       fontSize: 14,
                                //       // fontWeight: FontWeight.w600
                                //     ),
                                //   ),
                                //   onChanged: (String value) {
                                //     setState(() {
                                //       _chosenValue = value;
                                //       // widget.itemmodel.category = value;
                                //     });
                                //   },
                                // ),
                                ElevatedButton(
                                  child: const Text('Pause'),
                                  onPressed: () {
                                    updateOrders();
                                  },
                                )
                              ],
                            ),
                          );
                        }
                    );
                  },
                );
              },
              child: Container(
                decoration: new BoxDecoration(
                  gradient: LinearGradient(
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0,3.0],
                      // begin: Alignment.bottomRight,
                      colors: [
                        Colors.blue.withOpacity(.7),
                        Colors.deepPurpleAccent.withOpacity(.6),
                        Colors.black.withOpacity(.4),
                      ]
                  ),
                ),
                width: MediaQuery.of(context).size.width - 40.0,
                height: 50.0,
                child: Center(
                  child: Text(
                    "Pause Subscription",
                    style: TextStyle(color: Colors.white, fontSize: 15.0,),
                  ),
                ),
              ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap:  ()
              {
                FirebaseFirestore.instance.collection('users').doc(respawn.sharedPreferences.getString(respawn.userUID)).collection('orders').doc(widget.orderID1).delete();
                FirebaseFirestore.instance.collection('orders').doc(widget.orderID1).delete();
                Fluttertoast.showToast(msg: "Subscription Cancelled Successfully!",timeInSecForIos: 3);
                PdfApi.sendMailUser2(widget.dataMap['userEmail'],widget.model,widget.dataMap['subscriptionStatus']);
                Navigator.pushReplacementNamed(context, 'navidrawer');
              },
              child: Container(
                decoration: new BoxDecoration(
                  gradient: LinearGradient(
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0,3.0],
                      // begin: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(.5),
                        Colors.grey.withOpacity(.5),
                        Colors.white.withOpacity(.4),
                      ]
                  ),
                ),
                width: MediaQuery.of(context).size.width - 40.0,
                height: 50.0,
                child: Center(
                  child: Text(
                    "Cancel Subscription",
                    style: TextStyle(color: Colors.white, fontSize: 15.0,),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  //date picker function....
  String getFrom() {
    if (dateRange == null) {
      return 'From';
      // return DateFormat('dd-MM-yyyy').format(DateTime.now());
      // return '15-07-2021';
    } else {
      return DateFormat('dd-MM-yyyy').format(dateRange.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Until';
      // return DateFormat('dd-MM-yyyy').format(DateTime( DateTime.now().day +4) );
      // return '17-07-2021';
    } else {
      return DateFormat('dd-MM-yyyy').format(dateRange.end);
    }
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 24 * 7)),
    );

    final newDateRange = await showDateRangePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              surface: Colors.black,
              onSurface: Colors.yellow,
            ),
            // dialogBackgroundColor:Colors.blue[900],
            dialogBackgroundColor:Colors.grey,
          ),
          child: child,
        );
      },
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,


    );

    if (newDateRange == null) return;
    setState(() => dateRange = newDateRange);

  }

  updateOrders(){
    FirebaseFirestore.instance.collection('users').doc(respawn.sharedPreferences.getString(respawn.userUID)).collection('orders').doc(widget.orderID1).update({
      'pausedFrom' : DateFormat('dd-MM-yyyy').format(dateRange.start),
      'pausedTill' : DateFormat('dd-MM-yyyy').format(dateRange.end),
    });
    FirebaseFirestore.instance.collection('orders').doc(widget.orderID1).update({
      'pausedFrom' : DateFormat('dd-MM-yyyy').format(dateRange.start),
      'pausedTill' : DateFormat('dd-MM-yyyy').format(dateRange.end),
    });
    Fluttertoast.showToast(msg: "Subscription paused successfully");
    Navigator.pop(context);
    PdfApi.sendMailUser(widget.dataMap['userEmail'],widget.model,DateFormat('dd-MM-yyyy').format(dateRange.start).toString(),DateFormat('dd-MM-yyyy').format(dateRange.end).toString(),widget.dataMap['subscriptionStatus']);
    // sendSMS(phNo, msg)
    
  }
  //
  // //send sms
  // sendSMS(String phNo,String msg)
  // {
  //   SmsSender sender = new SmsSender();
  //   // String address = '8217748586';
  //   // String address = '9113588785';
  //   String address = phNo;
  //   sender.sendSms(new SmsMessage(address, msg));
  // }

  confirmedUserOrderReceived(BuildContext context, String mOrderId)
  {
    // FirebaseFirestore.instance
    //     .collection(respawn.collectionUser)
    //     .doc(respawn.sharedPreferences.getString(respawn.userUID))
    //     .collection(respawn.collectionOrders)
    //     .doc(mOrderId)
    //     .delete();

    // getOrderId = "";
    Fluttertoast.showToast(msg: "Order has been Received. Confirmed.");
  }

}




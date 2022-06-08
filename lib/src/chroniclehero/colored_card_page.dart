import 'package:flutter/material.dart';
import 'package:thechronicle/src/PaymentGateway/razorpayPayment.dart';
import 'package:thechronicle/src/chroniclehero/colored_card.dart';
import 'package:thechronicle/src/model/addressmodel.dart';

class ColoredCardPage extends StatefulWidget {

  final AddressModel model1;
  final String addressId;
  final double totalAmount;
  final bool isServiceOpted;

  const ColoredCardPage({Key key, this.model1, this.addressId, this.totalAmount, this.isServiceOpted}) : super(key: key);

  @override
  ColoredCardPageState createState() {
    return new ColoredCardPageState();
  }

}

class ColoredCardPageState extends State<ColoredCardPage> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double finalAmt1=0, finalAmt2=0, finalTot=0;
  String subType;
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    finalAmt1 = widget.totalAmount - (widget.totalAmount * 0.27);
    finalAmt2 = widget.totalAmount - (widget.totalAmount * 0.15);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white38,
        title: Text("Choose your Subscription type"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: _value,
                  onChanged: (value){
                    setState(() {
                      _value = value;
                      finalTot = finalAmt1;
                      subType = "Annually";
                    });
                  },
                ),
                Text(
                  "Annual Subscription",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            )
          ),
          SizedBox(
            height: 20,
          ),
          ColoredCard(
            headerColor: Color(0xffc0b445),
            footerColor: Color(0xFF6078dc),
            cardHeight: 250,
            borderRadius: 30,
            bodyColor: Color(0xFF6c8df6),
            showHeader: true,
            showFooter: false,
            bodyGradient: LinearGradient(
              colors: [
                Color(0xffe1dc82).withOpacity(1),
                Color(0xffcdbf41),
                Color(0xffbdac16),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0, 0.2, 1],
            ),
            headerBar: HeaderBar(
              title: Text(
                "Annual",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  fontSize: 16,
                ),
              ),
              action: IconButton(
                icon: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                ),
                onPressed: () => print("header button 1"),
              ),
            ),
            bodyContent: Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                top: 30,
                right: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Hottest deal in the market",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "Poppins"),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "27% off on the original price ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Poppins"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "* Tax Included",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '\u{20B9} '+ widget.totalAmount.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                                fontSize: 20,
                                color: Colors.white.withOpacity(.8),
                                decoration: TextDecoration.lineThrough
                            ),
                          ),
                          Text(
                            '\u{20B9} '+finalAmt1.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )

                    ],
                  ),


                ],
              ),
            ),
          ),

          //second card....
          SizedBox(
            height: 20,
          ),

          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: _value,
                    onChanged: (value){
                      setState(() {
                        _value = value;
                        finalTot = finalAmt2;
                        subType = "Half-Yearly";
                      });
                    },
                  ),
                  Text(
                    "Half-yearly Subscription",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )

          ),

          //third card
          SizedBox(
            height: 20,
          ),
          ColoredCard(
            headerColor: Color(0xff45c09d),
            footerColor: Color(0xFF6078dc),
            cardHeight: 250,
            borderRadius: 30,
            bodyColor: Color(0xFF6c8df6),
            showHeader: true,
            showFooter: false,
            bodyGradient: LinearGradient(
              colors: [
                Color(0xff82e1c6).withOpacity(1),
                Color(0xff41cd95),
                Color(0xff16bd75),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0, 0.2, 1],
            ),
            headerBar: HeaderBar(
              title: Text(
                "Half-Yearly",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  fontSize: 16,
                ),
              ),
              action: IconButton(
                icon: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                ),
                onPressed: () => print("header button 2"),
              ),
            ),

            bodyContent: Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                top: 30,
                right: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Flexible option",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "Poppins"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "15% off on the original price ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Poppins"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "* Tax Included",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '\u{20B9} '+ widget.totalAmount.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                                fontSize: 20,
                                color: Colors.white.withOpacity(.8),
                                decoration: TextDecoration.lineThrough
                            ),
                          ),
                          Text(
                            '\u{20B9} '+finalAmt2.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Radio(
                    value: 3,
                    groupValue: _value,
                    onChanged: (value){
                      setState(() {
                        _value = value;
                        finalTot = widget.totalAmount;
                        subType = "Monthly";
                      });
                    },
                  ),
                  Text(
                    "Monthly Subscription",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )

          ),
          SizedBox(
            height: 20,
          ),
          ColoredCard(
            headerColor: Color(0xff9545c0),
            footerColor: Color(0xFF6078dc),
            cardHeight: 250,
            borderRadius: 30,
            bodyColor: Color(0xFF6c8df6),
            showHeader: true,
            showFooter: false,
            bodyGradient: LinearGradient(
              colors: [
                Color(0xffd082e1).withOpacity(1),
                Color(0xffb841cd),
                Color(0xffb716bd),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0, 0.2, 1],
            ),
            headerBar: HeaderBar(
              title: Text(
                "Monthly",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  fontSize: 16,
                ),
              ),
              action: IconButton(
                icon: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                ),
                onPressed: () => print("header button 3"),
              ),
            ),
            bodyContent: Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                top: 30,
                right: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "For the regulars",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "Poppins"),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "* Tax Included",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        children: [
                          // Text(
                          //   '\u{20B9} '+ (widget.totalAmount + widget.totalAmount).toString(),
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //     fontFamily: "Poppins",
                          //     fontSize: 20,
                          //     color: Colors.white.withOpacity(.8),
                          //     decoration: TextDecoration.lineThrough
                          //   ),
                          // ),
                          Text(
                            '\u{20B9} '+widget.totalAmount.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 40,
          ),
         Padding(
           padding: const EdgeInsets.only(left: 18,right: 18,bottom: 18),
           child: Container(
             child: MaterialButton(
                 onPressed: () {
                   Route route = MaterialPageRoute(builder: (c) => PayRazor(
                     addressId: widget.addressId,
                     totalAmount: finalTot,
                     model1: widget.model1,
                     isServiceOpted:false,
                     subType: subType,
                   ));
                   Navigator.push(context, route);

                 },
               color: Colors.blue,
               child: Text("Pay Now ₹ "+finalTot.toString(), style: TextStyle(
                   color: Colors.white
               ),),

             ),
           ),
         ),
          // SizedBox(
          //   height: 20,
          // ),

        ],
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.Settings) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          Constants.Settings,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ));
    } else if (choice == Constants.Subscribe) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          Constants.Subscribe,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ));
    } else if (choice == Constants.SignOut) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(milliseconds: 200),
        content: Text(
          Constants.SignOut,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ));
    }
  }
}

class Constants {
  static const String Subscribe = 'Go Home Page';
  static const String Settings = 'Go Another Page';
  static const String SignOut = 'Refresh Page';

  static const List<String> choices = <String>[Subscribe, Settings, SignOut];
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thechronicle/src/Orders/OrderDetailsPage.dart';
import 'package:thechronicle/src/model/item.dart';
import 'package:thechronicle/src/pages/home_page.dart';
import 'package:thechronicle/src/constants/config.dart';


int counter = 0;
class HeroOrderCard extends StatelessWidget
{
  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderID;

  HeroOrderCard({Key key, this.itemCount, this.data, this.orderID,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()
      {
        print("order id card is "+orderID.toString());
        // Route route;
        // if(counter == 0)
        // {
        //   counter = counter + 1;
        // }
        // route = MaterialPageRoute(builder: (c) => OrderDetails(orderID: orderID));
        // Navigator.push(context, route);
      },
      child: Column(
        children: [
          Container(
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                // begin: Alignment.bottomRight,
                begin: const FractionalOffset(0.0, 0.2),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                colors: [
                  // Colors.purpleAccent.withOpacity(.5),
                  Colors.purpleAccent.withOpacity(.3),
                  Colors.black.withOpacity(.4),
                ],
              ),
              // gradient: new LinearGradient(
              //   colors: [Colors.pink, Colors.lightGreenAccent],
              //   begin: const FractionalOffset(0.0, 0.0),
              //   end: const FractionalOffset(1.0, 0.0),
              //   stops: [0.0, 1.0],
              //   tileMode: TileMode.clamp,
              // ),
            ),
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10.0),
            height: itemCount * 190.0,
            child: ListView.builder(
              itemCount: itemCount,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (c, index)
              {
                ItemModel model = ItemModel.fromJson(data[index].data());
                return sourceOrderInfo(model, context);
              },
            ),
          ),

          FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('orders')
                  .doc(orderID)
                  .get(),

            builder: (c, snapshot){
              num totalamt;
              Map dataMap;
              if(snapshot.hasData)
              {
                dataMap = snapshot.data.data();
                totalamt = dataMap[respawn.totalAmount];
              }
              return snapshot.hasData ?
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Paused From: " + dataMap['pausedFrom'].toString(),
                          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,),
                        ),

                        Text(
                          "Paused Till: " + dataMap['pausedTill'].toString(),
                          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,),
                        ),
                      ],
                    ),
                  ) : Container();
            },
          ),

        ],
      )

    );
  }
}

Widget sourceOrderInfo(ItemModel model, BuildContext context,
    {Color background})
{
  width =  MediaQuery.of(context).size.width;

  return  Container(
    color: Colors.grey[100],
    height: 170.0,
    width: width,
    child: Row(
      children: [
        Image.network(model.thumbnailUrl, width: 180.0,),
        SizedBox(width: 10.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.0,),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(model.title, style: TextStyle(color: Colors.black, fontSize: 14.0),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0,),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(model.shortInfo, style: TextStyle(color: Colors.black54, fontSize: 12.0),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0,),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Row(
                          children: [
                            Text(
                              r"Total Price: ",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "₹ ",
                              style: TextStyle(color: Colors.red, fontSize: 16.0),
                            ),
                            Text(
                              (model.price).toString(),
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ],
              ),
              Flexible(
                child: Container(),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thechronicle/src/Address/address.dart';
import 'package:thechronicle/src/Counters/cartitemcounter.dart';
import 'package:thechronicle/src/Counters/totalMoney.dart';
import 'package:thechronicle/src/constants/config.dart';
import 'package:thechronicle/src/model/item.dart';
import 'package:thechronicle/src/pages/mainPage.dart';
import 'package:thechronicle/src/pages/product_detail.dart';
import 'package:thechronicle/src/widgets/loadingWidget.dart';
import 'package:thechronicle/src/widgets/navigation_home_screen.dart';
import 'package:provider/provider.dart';
import 'package:thechronicle/src/pages/home_page.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}



class _CartPageState extends State<CartPage>
{
  double totalAmount,magAmt,paperAmt,finalAmt;
  @override
  void initState() {
    super.initState();

    totalAmount = 0;
    magAmt = 0;
    paperAmt = 0;
    finalAmt = 0;
    Provider.of<TotalAmount>(context, listen: false).display(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()
        {
          if(totalAmount> 500000){
            Fluttertoast.showToast(msg: "A single purchase cannot exceed more than ₹ 5,00,000");
          }
          else if(respawn.sharedPreferences.getStringList(respawn.userCartList).length == 1)
          {
            Fluttertoast.showToast(msg: "your Cart is empty.");
          }
          else
          {
            Route route = MaterialPageRoute(builder: (c) => Address(totalAmount: totalAmount));
            Navigator.push(context, route);
          }
        },
        label: Text("Check Out"),
        backgroundColor: Colors.pinkAccent,
        icon: Icon(Icons.navigate_next),
      ),
      // appBar: MyAppBar(),
      // drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              child: Consumer2<TotalAmount, CartItemCounter>(builder: (context, amountProvider, cartProvider, c)
              {
                return Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: respawn.sharedPreferences.getStringList(respawn.userCartList).length-1 == 0
                        ? Container()
                        : Column(
                      children: [
                        Text (
                          "Total Price: ₹ ${amountProvider.totalAmount}",
                          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),
                        ),
                        Text (
                          "Newspaper (for 30 days) = ₹ "+(paperAmt*30).toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.w100),
                        ),
                        Text (
                          "Magazine = ₹ $magAmt",
                          style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),

                  ),
                );
              },),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("products")
                .where("shortInfo", whereIn: respawn.sharedPreferences.getStringList(respawn.userCartList)).snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
                  : snapshot.data.docs.length == 0
                  ? beginBuildingCart()
                  : SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index)
                  {
                    ItemModel model = ItemModel.fromJson(snapshot.data.docs[index].data());

                    if(index == 0)
                    {
                      totalAmount = 0;
                      model.category == "Magazines" ? magAmt = model.price + magAmt : paperAmt = model.price + paperAmt;
                      // totalAmount = model.price + totalAmount;
                      totalAmount = (paperAmt * 30) + magAmt;
                      print("Magamt0 "+magAmt.toString());
                      print("paperamt0 "+paperAmt.toString());
                    }
                    else
                    {
                      model.category == "Magazines" ? magAmt = model.price + magAmt : paperAmt = model.price + paperAmt;
                      // model.category != "Magazines" ? paperAmt = model.price + paperAmt : null;
                      // totalAmount = model.price + totalAmount;
                      totalAmount = (paperAmt * 30) + magAmt;


                      print("Magamt "+magAmt.toString());
                      print("paperamt "+paperAmt.toString());
                    }

                    if(snapshot.data.docs.length - 1 == index)
                    {
                      WidgetsBinding.instance.addPostFrameCallback((t) {
                        Provider.of<TotalAmount>(context, listen: false).display(totalAmount);
                      });
                    }

                    return sourceInfo(model, context, removeCartFunction: () => removeItemFromUserCart(model.shortInfo));
                  },

                  childCount: snapshot.hasData ? snapshot.data.docs.length : 0,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  //sourceinfo widget for cart....
  //new product card widget....
  Widget sourceInfo(ItemModel model, BuildContext context,
      {Color background, removeCartFunction}) {

    return SafeArea(
      child: InkWell(
        onTap: ()
        {
          Route route = MaterialPageRoute(builder: (c) => ProductDetailPage(itemModel: model));
          // Route route = MaterialPageRoute(builder: (c) => ProductPage(itemModel: model));
          Navigator.push(context, route);
        },
        splashColor: Colors.orangeAccent,
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Container(
            height: 190.0,
            width: width,
            child: Row(
              children: [
                Image.network(model.thumbnailUrl, width: 120.0, height: 120.0,),
                SizedBox(width: 4.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.0,),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(model.title, style: TextStyle(color: Colors.black, fontSize: 17.0),),
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
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.pink,
                            ),
                            alignment: Alignment.topLeft,
                            width: 40.0,
                            height: 43.0,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "50%", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    "OFF", style: TextStyle(fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 0.0),
                                child: Row(
                                  children: [
                                    Text(
                                      r"Origional Price: ₹ ",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(
                                      (model.price + model.price).toString(),
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Row(
                                  children: [
                                    Text(
                                      r"New Price: ",
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
                      //to implement the cart item aad/remove feature
                      Align(
                        alignment: Alignment.centerRight,
                        child: removeCartFunction == null
                            ? IconButton(
                          icon: Icon(Icons.add_shopping_cart, color: Colors.pinkAccent,),
                          onPressed: ()
                          {
                            checkItemInCart(model.shortInfo, context);
                          },
                        )
                            : IconButton(
                          icon: Icon(Icons.delete, color: Colors.pinkAccent,),
                          onPressed: ()
                          {
                            removeCartFunction();
                            Route route = MaterialPageRoute(builder: (c) => NavigationHomeScreen());
                            Navigator.push(context, route);
                          },
                        ),
                      ),

                      Divider(
                        height: 5.0,
                        color: Colors.pink,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkItemInCart(String shortInfoAsID, BuildContext context)
  {

    respawn.sharedPreferences.getStringList(respawn.userCartList).contains(shortInfoAsID)
        ? Fluttertoast.showToast(msg: "Item is already in Cart.")
        : addItemToCart(shortInfoAsID, context);
  }


  addItemToCart(String shortInfoAsID, BuildContext context)
  {
    List tempCartList = respawn.sharedPreferences.getStringList(respawn.userCartList);
    tempCartList.add(shortInfoAsID);
    FirebaseFirestore.instance.collection(respawn.collectionUser)
        .doc(respawn.sharedPreferences.getString(respawn.userUID))
        .update({
      respawn.userCartList: tempCartList,
    }).then((v){
      Fluttertoast.showToast(msg: "Item Added to Cart Successfully.");

      respawn.sharedPreferences.setStringList(respawn.userCartList, tempCartList);

      Provider.of<CartItemCounter>(context, listen: false).displayResult();
    });
  }


  beginBuildingCart()
  {
    return SliverToBoxAdapter(
      child: Card(
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        child: Container(
          height: 100.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.insert_emoticon, color: Colors.white,),
              Text("Cart is empty."),
              Text("Start adding items to your Cart."),
            ],
          ),
        ),
      ),
    );
  }

  removeItemFromUserCart(String shortInfoAsId)
  {
    List tempCartList = respawn.sharedPreferences.getStringList(respawn.userCartList);
    tempCartList.remove(shortInfoAsId);

    FirebaseFirestore.instance.collection(respawn.collectionUser)
        .doc(respawn.sharedPreferences.getString(respawn.userUID))
        .update({
      respawn.userCartList: tempCartList,
    }).then((v){

      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.FLOATING,
        reverseAnimationCurve: Curves.decelerate,
        forwardAnimationCurve: Curves.elasticOut,
        backgroundColor: Colors.deepOrangeAccent.withOpacity(.9),
        boxShadows: [BoxShadow(color: Colors.red[800], offset: Offset(0.0, 2.0), blurRadius: 3.0)],
        // backgroundGradient: LinearGradient(colors: [Colors.blueGrey, Colors.black]),
        isDismissible: true,
        duration: Duration(milliseconds: 1000),
        // animationDuration: Duration(milliseconds: 1200),
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.blueGrey,
        titleText: Text(
          "Success",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white, fontFamily: "ShadowsIntoLightTwo"),
        ),
        messageText: Text(
          "Item Removed Successfully!",
          style: TextStyle(fontSize: 15.0, color: Colors.white, fontFamily: "ShadowsIntoLightTwo"),
        ),
      )..show(context);

      // Fluttertoast.showToast(msg: "Item Removed Successfully.");

      respawn.sharedPreferences.setStringList(respawn.userCartList, tempCartList);

      Provider.of<CartItemCounter>(context, listen: false).displayResult();

      totalAmount = 0;
    });
  }





}

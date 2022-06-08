
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thechronicle/src/Counters/cartitemcounter.dart';
import 'package:thechronicle/src/Counters/wishlisttitemcounter.dart';
import 'package:thechronicle/src/model/item.dart';
import 'package:thechronicle/src/model/userprofilemodel.dart';
import 'package:thechronicle/src/productComments/testme.dart';
import 'package:thechronicle/src/productComments/testmecopy.dart';
import 'package:thechronicle/src/themes/light_color.dart';
import 'package:thechronicle/src/themes/theme.dart';
import 'package:thechronicle/src/widgets/loadingWidget.dart';
import 'package:thechronicle/src/widgets/navigation_home_screen.dart';
import 'package:thechronicle/src/widgets/orderCard.dart';
import 'package:thechronicle/src/widgets/title_text.dart';
import 'package:thechronicle/src/widgets/extentions.dart';
import 'package:thechronicle/src/constants/config.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'hero_orderCard.dart';


class HeroDetailPage extends StatefulWidget {

  final UserProfileModel userProfileModel;
  HeroDetailPage({this.userProfileModel});
  // ProductDetailPage({Key key}) : super(key: key);

  @override
  _HeroDetailPageState createState() => _HeroDetailPageState();
}

class _HeroDetailPageState extends State<HeroDetailPage>
    with TickerProviderStateMixin {

  ScrollController sController;
  bool fabIsVisible = true;

  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    //For hiding the cart button on default and make it visible on scoll forward...
    sController = ScrollController();
    handleScroll();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
  }

  void showFloationButton() {
    setState(() {
      fabIsVisible = true;
    });
  }

  void hideFloationButton() {
    setState(() {
      fabIsVisible = false;
    });
  }

  void handleScroll() async {
    sController.addListener(() {
      if (sController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideFloationButton();
      }
      if (sController.position.userScrollDirection ==
          ScrollDirection.forward) {
        showFloationButton();
      }
    });
  }


  @override
  void dispose() {
    controller.dispose();
    sController.removeListener(() {});
    super.dispose();
  }

  bool isLiked = false;

  bool isSizeSelected1=false;
  bool isSizeSelected2=true;
  bool isSizeSelected3=false;
  bool isSizeSelected4=false;

  bool isColorSelected1=false;
  bool isColorSelected2=false;
  bool isColorSelected3=true;
  bool isColorSelected4=false;
  bool isColorSelected5=false;

  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 15,
            padding: 12,
            isOutLine: true,
            onPressed: () {
              Route route = MaterialPageRoute(builder: (c) => NavigationHomeScreen());
              Navigator.push(context, route);
              // Navigator.of(context).pop();
            },
          ),
          // _icon(isLiked || respawn.sharedPreferences.getStringList(respawn.userWishList).contains(widget.itemModel.shortInfo) ? Icons.favorite : Icons.favorite_border ,
          //     color: isLiked || respawn.sharedPreferences.getStringList(respawn.userWishList).contains(widget.itemModel.shortInfo) ? LightColor.red : LightColor.red,
          //     size: 15,
          //     padding: 12,
          //     isOutLine: true,
          //     onPressed: () {
          //        setState(() {
          //          isLiked = !isLiked;
          //        });
          //        if(isLiked==true){
          //          checkItemInWishlist(widget.itemModel.shortInfo,context);
          //        }
          //        else if(isLiked==false){
          //          removeItemFromUserWishlist(widget.itemModel.shortInfo);
          //        }
          // }),
        ],
      ),
    );
  }

  Widget _icon(
      IconData icon, {
        Color color = LightColor.iconColor,
        // Color color = Colors.red,
        double size = 20,
        double padding = 10,
        bool isOutLine = false,
        Function onPressed,
      }) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      // margin: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
            color: LightColor.iconColor,
            style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color:
        isOutLine ? Colors.transparent : Theme.of(context).backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 5,
              spreadRadius: 10,
              offset: Offset(5, 5)),
        ],
      ),
      child: Icon(icon, color: color, size: size),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _productImage() {
    return AnimatedBuilder(
      builder: (context, child) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: animation.value,
          child: child,
        );
      },
      animation: animation,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         // image:NetworkImage(widget.itemModel.thumbnailUrl),
            //         // fit: BoxFit.cover
            //     )
            // ),
          ),
          // TitleText(
          //   text: "AIR",
          //   fontSize: 160,
          //   color: LightColor.lightGrey,
          // ),
          Center(
            child: Container(
              height: 300,
              width: 300,
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.userProfileModel.upic,),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 115),
          //   child: Image.network(widget.userProfileModel.upic),
          // )
          // Image.asset('assets/show_1.png')
        ],
      ),
    );
  }

  Widget _detailWidget() {
    return SafeArea(
      child: DraggableScrollableSheet(
        maxChildSize: .8,
        initialChildSize: .53,
        minChildSize: .53,
        builder: (context, scrollController) {
          return Container(
            padding: AppTheme.padding.copyWith(bottom: 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                // color: Colors.grey.shade200
                color: Colors.white

            ),
            child: SingleChildScrollView(
              controller: scrollController,
              // controller: sController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(height: 5),
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                          color: LightColor.iconColor,
                          // color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child:Text(widget.userProfileModel.uname, style: TextStyle(color: Colors.green, fontSize: 25.0, fontWeight: FontWeight.bold),),

                        ),

                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: <Widget>[
                        //     Row(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: <Widget>[
                        //         TitleText(
                        //           text: "\₹ ",
                        //           fontSize: 18,
                        //           color: LightColor.red,
                        //         ),
                        //         TitleText(
                        //           text: widget.itemModel.price.toString(),
                        //           fontSize: 25,
                        //         ),
                        //       ],
                        //     ),
                        //     Row(
                        //       children: <Widget>[
                        //         SmoothStarRating(
                        //             allowHalfRating: true,
                        //             onRated: (v) {
                        //               print("Rating is $v");
                        //               Fluttertoast.showToast(msg: "You have rated this $v.",backgroundColor: Colors.cyan,textColor: Colors.white);
                        //               // flushbar(color: Colors.blueAccent,title: "Info", msg:"You have rated this $v.",duration: Duration(seconds: 0),icon: Icon(Icons.info_outline_rounded, color: Colors.white,));
                        //             },
                        //             starCount: 5,
                        //             rating: 2,
                        //             size: 20.0,
                        //             isReadOnly:false,
                        //             filledIconData: Icons.star,
                        //             halfFilledIconData: Icons.star_half_outlined,
                        //             color: Color(0xfffbba01),
                        //             borderColor: Colors.grey,
                        //             spacing:0.0
                        //         )
                        //         // Icon(Icons.star,
                        //         //     color: LightColor.yellowColor, size: 17),
                        //         // Icon(Icons.star,
                        //         //     color: LightColor.yellowColor, size: 17),
                        //         // Icon(Icons.star,
                        //         //     color: LightColor.yellowColor, size: 17),
                        //         // Icon(Icons.star,
                        //         //     color: LightColor.yellowColor, size: 17),
                        //         // Icon(Icons.star_border, size: 17),
                        //       ],
                        //     ),
                        //   ],
                        // ),

                      ],
                    ),
                  ),


                  // SizedBox(
                  //   height: 20,
                  // ),
                  // _availableSize(),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // _availableColor(),
                  SizedBox(
                    height: 20,
                  ),
                  _description(),
                  SizedBox(
                    height: 20,
                  ),

                  // TitleText(
                  //   text: "User Reviews",
                  //   fontSize: 17,
                  // ),
                  // Center(
                  //   child: TitleText(
                  //     text: "User Reviews",
                  //     fontSize: 17,
                  //   ),
                  // ),
                  SizedBox(
                    height: 17,
                  ),

                  ////User comments...
                  // Container(height: MediaQuery.of(context).size.height * 0.36,
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(bottom: 17),
                  //       child: TestMeNew(draggable: scrollController, prodID: widget.itemModel.productID,),
                  //     )
                  // ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Address ::",
          fontSize: 17,
        ),

        SizedBox(height: 20),

        Text(widget.userProfileModel.fulladd),

        SizedBox(height: 20),

        TitleText(
          text: "Landmark ::",
          fontSize: 17,
        ),

        SizedBox(height: 20),

        Text(widget.userProfileModel.landmark),

        SizedBox(height: 20),

        TitleText(
          text: "Mobile No ::",
          fontSize: 17,
        ),

        SizedBox(height: 20),

        Text(widget.userProfileModel.uphno),

        SizedBox(height: 20),

        TitleText(
          text: "Email ::",
          fontSize: 17,
        ),

        SizedBox(height: 20),

        Text(widget.userProfileModel.uemail),

        SizedBox(height: 20),

        // Row(
        //   children: [
        //     TitleText(
        //       text: "Paused From ::",
        //       fontSize: 17,
        //     ),
        //   ],
        // ),

        // SizedBox(height: 20),

        TitleText(
          text: "Delivery ::",
          fontSize: 17,
        ),

        SizedBox(height: 20),

        Container(
          height: 500,
          width: 500,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(respawn.collectionUser)
                .doc(widget.userProfileModel.userID)
                .collection(respawn.collectionOrders)
                .orderBy("orderTime",descending: true)
                .snapshots(),

            builder: (c, snapshot)
            {
              return snapshot.hasData
                  ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (c, index){
                  return FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("products")
                        .where("shortInfo", whereIn: snapshot.data.docs[index].data()[respawn.productID],)
                        .get(),

                    builder: (c, snap)
                    {
                      return snap.hasData
                          ? HeroOrderCard(
                        itemCount: snap.data.docs.length,
                        data: snap.data.docs,
                        orderID: snapshot.data.docs[index].id,
                      )
                          : Center(child: circularProgress(),);
                    },
                  );
                },
              )
                  : Center(child: circularProgress(),);
            },
          ),
        ),

      ],
    );
  }


  FloatingActionButton _flotingButton() {
    return FloatingActionButton(
      onPressed: () {
        print("Oucchhhh");
        // checkItemInCart(widget.itemModel.shortInfo, context);
      },
      // backgroundColor: LightColor.orange,
      backgroundColor: Colors.blueAccent,
      // backgroundColor: Colors.greenAccent.shade400,
      // backgroundColor: Colors.blueAccent,
      child: Icon(
          Icons.navigation,
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: AnimatedOpacity(
      //   child: Padding(
      //     padding: const EdgeInsets.only(bottom: 77),
      //     child: _flotingButton(),
      //   ),
      //   duration: Duration(milliseconds: 100),
      //   opacity: fabIsVisible ? 1: 0,
      // ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xfffbfbfb),
                  Color(0xfff7f7f7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _appBar(),
                  _productImage(),
                  // _categoryWidget(),
                ],
              ),
              _detailWidget(),

            ],
          ),
        ),
      ),
    );
  }

  //For adding items to wishlist..
  void checkItemInWishlist(String shortInfoAsID, BuildContext context)
  {

    if(respawn.sharedPreferences.getStringList(respawn.userWishList).contains(shortInfoAsID)){
      flushbar(color: Colors.blueAccent,title: "Info", msg:"Item already in Cart.",duration: Duration(seconds: 1),icon: Icon(Icons.info_outline_rounded, color: Colors.white,));
      // Fluttertoast.showToast(msg: "Item is already in Cart.");
    }
    else if (respawn.sharedPreferences.getStringList(respawn.userWishList).length-1 > 8){
      flushbar(color: Colors.blueAccent,title: "Info", msg:"Cart cannot have more than 9 items",duration: Duration(seconds: 2),icon: Icon(Icons.info_outline_rounded, color: Colors.white,));
      // Fluttertoast.showToast(msg: "Cart cannot have more than 9 items");
    }
    else{
      addItemToWishlist(shortInfoAsID, context);
    }

  }


  addItemToWishlist(String shortInfoAsID, BuildContext context)
  {
    List tempWishList = respawn.sharedPreferences.getStringList(respawn.userWishList);
    tempWishList.add(shortInfoAsID);
    FirebaseFirestore.instance.collection(respawn.collectionUser)
        .doc(respawn.sharedPreferences.getString(respawn.userUID))
        .update({
      respawn.userWishList: tempWishList,
    }).then((v){
      flushbar(color: Colors.green,title: "Info", msg:"Item Added to Wishlist Successfully",duration: Duration(seconds: 1),icon: Icon(Icons.check_circle_outline, color: Colors.white,));

      respawn.sharedPreferences.setStringList(respawn.userWishList, tempWishList);

      Provider.of<CartItemCounter>(context, listen: false).displayResult();
    });
  }


  flushbar({Color color, String msg, String title, Duration duration, Icon icon}){
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: color,
      // boxShadows: [BoxShadow(color: Colors.redAccent, offset: Offset(0.0, 2.0), blurRadius: 3.0)],
      // backgroundGradient: LinearGradient(colors: [Colors.blueGrey, Colors.black]),
      isDismissible: true,
      duration: duration,
      // animationDuration: Duration(milliseconds: 1200),
      icon: Icon(
        Icons.info_outline_rounded,
        color: Colors.white,
      ),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.blueGrey,
      titleText: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white, fontFamily: "ShadowsIntoLightTwo"),
      ),
      messageText: Text(
        msg,
        style: TextStyle(fontSize: 15.0, color: Colors.white, fontFamily: "ShadowsIntoLightTwo"),
      ),
    )..show(context);
  }

  beginBuildingWishlist()
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
              Text("Your Wishlist is empty."),
              Text("Start adding items to your wishlist."),
            ],
          ),
        ),
      ),
    );
  }



  //remove the item from user wishlist....
  removeItemFromUserWishlist(String shortInfoAsId)
  {
    // setState(() {
    //   isLiked= false;
    // });
    List tempWishList = respawn.sharedPreferences.getStringList(respawn.userWishList);
    tempWishList.remove(shortInfoAsId);

    FirebaseFirestore.instance.collection(respawn.collectionUser)
        .doc(respawn.sharedPreferences.getString(respawn.userUID))
        .update({
      respawn.userWishList: tempWishList,
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
          "Item removed from WishList Successfully!",
          style: TextStyle(fontSize: 15.0, color: Colors.white, fontFamily: "ShadowsIntoLightTwo"),
        ),
      )..show(context);

      respawn.sharedPreferences.setStringList(respawn.userWishList, tempWishList);


      Provider.of<WishlistItemCounter>(context, listen: false).displayResult();
      // Provider.of<CartItemCounter>(context, listen: false).displayResult();

      setState(() {
        isLiked=false;
      });

    });
  }


}


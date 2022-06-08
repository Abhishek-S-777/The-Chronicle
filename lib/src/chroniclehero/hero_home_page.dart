import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thechronicle/src/Counters/cartitemcounter.dart';
import 'package:thechronicle/src/chroniclehero/hero_customer_detail.dart';
import 'package:thechronicle/src/constants/config.dart';
import 'package:thechronicle/src/model/data.dart';
import 'package:thechronicle/src/model/item.dart';
import 'package:thechronicle/src/model/userprofilemodel.dart';
import 'package:thechronicle/src/newnew/product_list.dart';
import 'package:thechronicle/src/newnew/productnew.dart';
import 'package:thechronicle/src/pages/product_detail.dart';
import 'package:thechronicle/src/themes/light_color.dart';
import 'package:thechronicle/src/themes/theme.dart';
import 'package:thechronicle/src/widgets/loadingWidget.dart';
import 'package:thechronicle/src/widgets/product_card.dart';
import 'package:thechronicle/src/widgets/product_icon.dart';
import 'package:thechronicle/src/widgets/extentions.dart';
import 'package:thechronicle/src/widgets/searchBox.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';


double width;
class HeroHomePage extends StatefulWidget {
  HeroHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HeroHomePageState createState() => _HeroHomePageState();
}


List<Productnew> productsnew = [
  Productnew(
      // 'assets/thumbnails/lap1.png',
      'assets/magazine/musk.jpg',
      // 'assets/thumbnails/custompcnew1.png',
      'CEO Magazine',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
      499),
  Productnew(
      'assets/magazine/vogue.jpg',
      'Vogue Magazine',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
      799),
  Productnew(
      'assets/magazine/gq.jpg',
      'GQ Magazine',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
      999),
  Productnew(
      'assets/magazine/vanity.jpg',
      'Vanity Magazine',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
      450),
  Productnew(
      'assets/magazine/wired.jpg',
      'WIRED Magazine',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
      700),
];

class _HeroHomePageState extends State<HeroHomePage> {
  int quantity=1;
  String categoryy='English';
  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  //toast message function...
  void toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        // timeInSecForIosWeb: 2,
        timeInSecForIos: 2,
        fontSize: 16.0
    );
  }
  //backup category widget
  Widget _categoryWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: AppData.categoryList
            .map(
              (category) => ProductIcon(
                model: category,
                onSelected: (model) {
                  setState(() {
                    AppData.categoryList.forEach((item) {
                      item.isSelected = false;
                      categoryy=model.name;
                    });
                    model.isSelected = true;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  //Backup code if anything goes wrong....
  @override
  Widget build(BuildContext context) {
    // print("User email id is "+respawn.sharedPreferences.getString(respawn.userEmail));
    // print("Category selected is"+categoryy);
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned:false,delegate: SearchBoxDelegate()),
          SliverToBoxAdapter(
            child: Container(
              // color: Color.fromRGBO(255, 229, 180, .4),
              // height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                dragStartBehavior: DragStartBehavior.down,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // _search(),
                    // _search1(),
                    // Container(
                    //   // height: 90,
                    //   width: double.infinity,
                    //   // margin: EdgeInsets.all(getProportionateScreenWidth(20)),
                    //   margin: EdgeInsets.all(20),
                    //   padding: EdgeInsets.symmetric(
                    //     // horizontal: getProportionateScreenWidth(20),
                    //     // vertical: getProportionateScreenWidth(15),
                    //     horizontal:20,
                    //     vertical: 15,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: Color(0xFF4B28BA),
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   child: Text.rich(
                    //     TextSpan(
                    //       style: TextStyle(color: Colors.white),
                    //       children: [
                    //         TextSpan(text: "A Summer Surprise ! ! !\n"),
                    //         TextSpan(
                    //           text: "20% off on Magazines",
                    //           style: TextStyle(
                    //             // fontSize: getProportionateScreenWidth(24),
                    //             fontSize: 24,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // ProductList(products: productsnew,),
                    // _categoryWidget(),
                    // _productWidget(),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            // stream: FirebaseFirestore.instance.collection("products").limit(15).orderBy("publishedDate", descending: true).snapshots(),
            stream: FirebaseFirestore.instance.collection("users").limit(15).orderBy("createdDate", descending: true).snapshots(),
            builder: (context, dataSnapshot)
            {
              return !dataSnapshot.hasData
                  ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
                  : SliverStaggeredGrid.countBuilder(
                crossAxisCount: 2,
                staggeredTileBuilder: (c) => StaggeredTile.fit(2),
                itemBuilder: (context, index)
                {
                  // print("product index is: "+index.toString());
                  UserProfileModel model = UserProfileModel.fromJson(dataSnapshot.data.docs[index].data());
                  return sourceInfo(model, context);
                },
                itemCount: dataSnapshot.data.docs.length,
              );
            },
          ),
        ],
      )
    );
  }

  //new product card widget....
  Widget sourceInfo(UserProfileModel model, BuildContext context,
      {Color background, removeCartFunction}) {
    return SafeArea(
      child: InkWell(
        onTap: ()
        {

          print("model is "+model.userID.toString());
          Route route = MaterialPageRoute(builder: (c) => HeroDetailPage(userProfileModel: model,) );
          // Route route = MaterialPageRoute(builder: (c) => ProductPage(itemModel: model));
          Navigator.push(context, route);
        },
        splashColor: Colors.orangeAccent,
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Container(
            // color: Color.fromRGBO(255, 229, 180, .4),
            height: 190.0,
            width: width,
            child: Row(
              children: [
                SizedBox(width: 10.0,),
                Container(
                    height: 100.0,
                    width: 100.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(model.upic,),
                    )
                ),
                // Image.network(model.upic, width: 120.0, height: 120.0,),
                SizedBox(width: 14.0,),
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
                              child: Text(model.uname, style: TextStyle(color: Colors.blueAccent, fontSize: 19.0, fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("Mob: ", style: TextStyle(color: Colors.green, fontSize: 13.0,),),
                            Text(model.uphno, style: TextStyle(color: Colors.black54, fontSize: 13.0),),
                            // Expanded(
                            //   child: Text("Mob: ", style: TextStyle(color: Colors.black54, fontSize: 12.0,fontWeight: FontWeight.bold),),
                            // ),
                            // Expanded(
                            //   child: Text(model.uphno, style: TextStyle(color: Colors.black54, fontSize: 12.0),),
                            // ),

                          ],
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Row(
                        children: [
                          // Container(
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.rectangle,
                          //     // color: Colors.pink,
                          //     color: model.issue=="Morning" ? Colors.green : Colors.orange,
                          //   ),
                          //   alignment: Alignment.topLeft,
                          //   width: 65.0,
                          //   height: 30.0,
                          //   child: Center(
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Text(
                          //           model.issue=="Morning" ? "Morning" : "Evening", style: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.normal),
                          //         ),
                          //         // Text(
                          //         //   "Morning", style: TextStyle(fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.normal),
                          //         // ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(width: 10.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 0.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Email ID: ",
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.green,
                                        // fontWeight: FontWeight.bold
                                        // decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(
                                      (model.uemail).toString(),
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black54,
                                        // decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 15.0,),

                              Padding(
                                padding: EdgeInsets.only(top: 0.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Landmark: ",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.deepOrangeAccent,
                                        fontWeight: FontWeight.bold
                                        // decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(
                                      (model.landmark).toString(),
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black54,
                                        // decoration: TextDecoration.lineThrough,
                                      ),
                                    ),


                                  ],
                                ),
                              ),


                              //
                              // Padding(
                              //   padding: EdgeInsets.only(top: 5.0),
                              //   child: Row(
                              //     children: [
                              //       Text(
                              //         r"New Price: ",
                              //         style: TextStyle(
                              //           fontSize: 14.0,
                              //           color: Colors.grey,
                              //         ),
                              //       ),
                              //       Text(
                              //         "₹ ",
                              //         style: TextStyle(color: Colors.red, fontSize: 16.0),
                              //       ),
                              //       Text(
                              //         (model.price).toString(),
                              //         style: TextStyle(
                              //           fontSize: 15.0,
                              //           color: Colors.grey,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),

                      // SizedBox(height: 10,),
                      Flexible(
                        child: Container(),
                      ),
                      // Expanded(
                      //   child: Align(
                      //     alignment: Alignment.centerRight,
                      //     child: IconButton(
                      //       // iconSize: 40,
                      //       icon: Icon(Icons.navigation_rounded, color: Colors.cyan,),
                      //       onPressed: ()
                      //       {
                      //         print("Navigation pressed");
                      //       },
                      //     ),
                      //   ),
                      // ),
                      //to implement the cart item aad/remove feature
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: removeCartFunction == null
                      //       ? IconButton(
                      //     icon: Icon(Icons.add_shopping_cart, color: Colors.blue,),
                      //     onPressed: ()
                      //     {
                      //       checkItemInCart(model.shortInfo, context);
                      //     },
                      //   )
                      //       : IconButton(
                      //     icon: Icon(Icons.delete, color: Colors.blue,),
                      //     onPressed: ()
                      //     {
                      //       removeCartFunction();
                      //       Route route = MaterialPageRoute(builder: (c) => HeroHomePage());
                      //       Navigator.pushReplacement(context, route);
                      //     },
                      //   ),
                      // ),
                      SizedBox(height: 30,),
                      Divider(
                        height: 5.0,
                        color: Colors.black,
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
    if(respawn.sharedPreferences.getStringList(respawn.userCartList).contains(shortInfoAsID)){
      flushbar(color: Colors.blueAccent,title: "Info", msg:"Item already in Cart.",duration: Duration(seconds: 1));
      // Fluttertoast.showToast(msg: "Item is already in Cart.");
    }
    else if (respawn.sharedPreferences.getStringList(respawn.userCartList).length-1 > 8){
      flushbar(color: Colors.blueAccent,title: "Info", msg:"Cart cannot have more than 9 items",duration: Duration(seconds: 2));
      // Fluttertoast.showToast(msg: "Cart cannot have more than 9 items");
    }
    else{
      addItemToCart(shortInfoAsID, context);
    }
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

      // Fluttertoast.showToast(msg: "Item Added to Cart Successfully.");


      // flushbar(color: Colors.green, title: "Success", msg: "Added to cart successfully!",duration: Duration(milliseconds: 1000));

      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.FLOATING,
        reverseAnimationCurve: Curves.decelerate,
        forwardAnimationCurve: Curves.elasticOut,
        backgroundColor: Colors.green,
        boxShadows: [BoxShadow(color: Colors.green[800], offset: Offset(0.0, 2.0), blurRadius: 3.0)],
        // backgroundGradient: LinearGradient(colors: [Colors.blueGrey, Colors.black]),
        isDismissible: true,
        duration: Duration(milliseconds: 1000),
        // animationDuration: Duration(milliseconds: 1200),
        icon: Icon(
          Icons.check_circle_outline,
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
          "Item added to cart Successfully!",
          style: TextStyle(fontSize: 15.0, color: Colors.white, fontFamily: "ShadowsIntoLightTwo"),
        ),
      )..show(context);


      respawn.sharedPreferences.setStringList(respawn.userCartList, tempCartList);

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

  Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
    return Container(
      height: 150.0,
      width: width * .34,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(offset: Offset(0, 5), blurRadius: 10.0, color: Colors.grey[200]),
          ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: Image.network(
          imgPath,
          height: 150.0,
          width: width * .34,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  //old products card widget...
  Widget _productWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * .7,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 4 / 3,
            mainAxisSpacing: 30,
            crossAxisSpacing: 20),
        padding: EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        children: AppData.productList
            .map(
              (product) => ProductCard(
            product: product,
            onSelected: (model) {
              setState(() {
                AppData.productList.forEach((item) {
                  item.isSelected = false;
                });
                model.isSelected = true;
              });
            },
          ),
        ).toList(),
      ),
    );
  }




}

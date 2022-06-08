import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:thechronicle/src/DatabaseManager/DatabaseManager.dart';
import 'package:thechronicle/src/model/herouser.dart';
import 'package:thechronicle/src/model/user.dart';
import 'package:thechronicle/src/constants/config.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// registration with email and password

  Future createNewUser(String uname, String uemail, String upassword, String uphno, String uImageUrl) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: uemail, password: upassword);
      User user = result.user;

      // //for sending firebase authentication email....
      // User firebaseCurrentUser = FirebaseAuth.instance.currentUser;
      // firebaseCurrentUser.sendEmailVerification();


      await DatabaseManager().createUserData(
          uname, uemail, upassword, uphno, uImageUrl, user.uid
      );
      return _userFromFirebaseUser(user);
      // return user;
    }
    // }on FirebaseAuthException catch(e){
    //   if(e.code == 'email-already-in-use'){
    //     // respawn.message = 'The account already exists for that email.';
    //     return 'The account already exists for that email.';
    //   }
    //   return e.message;
    // }
    catch (e) {
      print(e.toString());
    }
  }
  Future createNewHero(String uname, String uemail, String upassword, String uphno, String uImageUrl) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: uemail, password: upassword);
      User user = result.user;

      // //for sending firebase authentication email....
      // User firebaseCurrentUser = FirebaseAuth.instance.currentUser;
      // firebaseCurrentUser.sendEmailVerification();


      await DatabaseManager().createHeroData(
          uname, uemail, upassword, uphno, uImageUrl, user.uid
      );
      return _heroUserFromFirebaseUser(user);
      // return user;
    }
    // }on FirebaseAuthException catch(e){
    //   if(e.code == 'email-already-in-use'){
    //     // respawn.message = 'The account already exists for that email.';
    //     return 'The account already exists for that email.';
    //   }
    //   return e.message;
    // }
    catch (e) {
      print(e.toString());
    }
  }

  // create user obj based on firebase user
  UserID _userFromFirebaseUser(User user) {
    return user != null ? UserID(uid: user.uid) : null;
  }

  // create user obj based on firebase hero user
  HeroUserID _heroUserFromFirebaseUser(User user) {
    return user != null ? HeroUserID(heroUid: user.uid) : null;
  }

  // auth change user stream
  Stream<UserID> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
    // onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
    // .map(_userFromFirebaseUser);
  }

// sign with email and password

  Future loginUser(String email, String password) async {
    try
    {

      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      readData(user);
      print("User id inside the auth service dart file: "+user.uid);
      return _userFromFirebaseUser(user);

    }
    catch (e)
    {
      print(e.toString());
    }
  }

  //read data from the firebase for the current logged in user from the firestore database..
  Future readData(User fuser) async
  {
    FirebaseFirestore.instance.collection("users").doc(fuser.uid).get().then((dataSnapshot) async {
      print("User id inside the read data is "+fuser.uid);
      // await respawn.sharedPreferences.setString(respawn.fbuserID, fuser.uid.toString());
      await respawn.sharedPreferences.setString(respawn.userUID, fuser.uid);
      await respawn.sharedPreferences.setString(respawn.userName, dataSnapshot.data()["name"]);
      await respawn.sharedPreferences.setString(respawn.userEmail, dataSnapshot.data()["email"]);
      await respawn.sharedPreferences.setString(respawn.userPhno, dataSnapshot.data()["phoneNumber"]);
      await respawn.sharedPreferences.setString(respawn.userAvatarUrl, dataSnapshot.data()["url"]);

      List <String> cartList = dataSnapshot.data()["userCart"].cast<String>();
      await respawn.sharedPreferences.setStringList(respawn.userCartList, cartList);

      List <String> wishList = dataSnapshot.data()["userWishlist"].cast<String>();
      await respawn.sharedPreferences.setStringList(respawn.userWishList, wishList);

      print("user name is "+respawn.sharedPreferences.getString(respawn.userName));
      print("Wishlist is: "+wishList.toString());
      print("Shared preference cart list is: "+respawn.sharedPreferences.getStringList(respawn.userWishList).toString());
      print("Shared preference cart list 2 is: "+respawn.userWishList);

    });
  }

  Future loginHeroUser(String email, String password) async {
    try
    {

      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      readHeroData(user);
      print("hero id inside the auth service dart file: "+user.uid);
      return _heroUserFromFirebaseUser(user);

    }
    catch (e)
    {
      print(e.toString());
    }
  }
  //read data from the firebase for the current logged in user from the firestore database..
  Future readHeroData(User fuser) async
  {
    FirebaseFirestore.instance.collection("hero").doc(fuser.uid).get().then((dataSnapshot) async {
      print("hero id inside the read data is "+fuser.uid);
      // await respawn.sharedPreferences.setString(respawn.fbuserID, fuser.uid.toString());
      await respawn.sharedPreferences.setString(respawn.heroUID, fuser.uid);
      await respawn.sharedPreferences.setString(respawn.heroName, dataSnapshot.data()["name"]);
      await respawn.sharedPreferences.setString(respawn.heroEmail, dataSnapshot.data()["email"]);
      await respawn.sharedPreferences.setString(respawn.heroPhno, dataSnapshot.data()["phoneNumber"]);
      await respawn.sharedPreferences.setString(respawn.heroAvatarUrl, dataSnapshot.data()["url"]);


    });
  }

// signout

  Future signOut() async
  {
    try
    {
      return _auth.signOut();
    }

    catch (error)
    {
      print(error.toString());
      return null;
    }

  }
}

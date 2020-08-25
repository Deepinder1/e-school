import 'package:e_school/models/user.dart';
import 'package:e_school/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //first of all I am going to create an instance of firebade authentication and
  //this instance is  the object that we are going to create will allow us to
  //communicate with firebase_auth on backend

  //so down here a final property is created
  //final means its not going to changein the future
  //the type here is FirebaseAuth object

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //this auth is object, and is also an instance of Firebase.instance class

  //going to create a new function
  //this function is going to create a new object based on FirebaseUser
  //Userobject is returned so User is return type
  User _userFromFirebaseUser(FirebaseUser user) {
    //we are going to take this user and
    //we are going to turn it into new user based on user.dart class
    return user != null ? User(uid: user.uid) : null;
    //User(uid: user.uid) is going to make an object and put it in User object
    //because of which we created the function
    //this function also takes a parameter whose name is also a user
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        // .map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  //create a method to sign in anonimously
  //this sign is going to be an asynchronous task
  Future signInAnon() async {
    try {
      //we make authentication request via _auth object
      //use awit bcoz its goingto take some tome

      //the signInAnonymously is a function of
      //firebase auth package and Firebase auth class

      //_auth.signInAnonymously(); is going to return an AuthResult object
      AuthResult result = await _auth.signInAnonymously();
      //on the result object we have access to a user object
      //it represents that user
      FirebaseUser user = result.user;
      //we can return that user
      return _userFromFirebaseUser(user); //the parameter is the abvoe line user
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //create a method to sign in wih email & pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //create a method to register
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with the uid

      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'Student name', 900);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // create a method to sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

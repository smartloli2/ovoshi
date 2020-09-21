import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ovoshi/domain/exceptions/http_exception.dart';

// User repository
class UserRepository {
  // Entry point firebase SDK
  // final FirebaseAuth _firebaseAuth;

  // Constr-r
  UserRepository(); // : _firebaseAuth = FirebaseAuth.instance;

/*
  // Sign in with credentials
  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Sign up
  Future<void> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Sign out
  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }


  // Is signed in?
  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }


  // Get current user
  Future<FirebaseUser> getUser() async {
    return await _firebaseAuth.currentUser();
  }
*/
  /////////////////////////////////////////////////////
  String _token;
  String _userId;
  DateTime _expiryDate;
  Timer _authTimer;

  String get userId {
    return _userId;
  }

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  // Sign up
  Future<void> signup(String email, String password) async {
    return _authentication(email, password, 'signUp');
  }

  // Sign in
  Future<void> login(String email, String password) async {
    return _authentication(email, password, 'signInWithPassword');
  }

  // Private auth
  Future<void> _authentication(
      String email, String password, String segmentUrl) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$segmentUrl?key=AIzaSyDhi4aQaICpXwIJA1NGJK0Mb_1HHGHx9M4';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      //print(response.body);
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      // Set the auto-logout timer
      _setAutoLogoutTimer();

      /// notifyListeners();

      // Save token on the device
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String(),
      });
      prefs.setString('userData', userData);
      //print('userData was saved!');
    }

    // Throw error (TODO: handling)
    catch (error) {
      throw error;
    }

    // print(json.decode(response.body));
  }

  // Try to login user
  Future<bool> tryAutoLogin() async {
    // print('Try logout');

    // Check if user data exists
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    // Extract user data from the device
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    // If token is expiry
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    // Extract the rest of the saved info from the device
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;

    /// notifyListeners();
    _setAutoLogoutTimer();
    // print(true);
    return true;
  }

  void logout() async {
    _token = null;
    _expiryDate = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    /// notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  void _setAutoLogoutTimer() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    Timer(Duration(seconds: timeToExpiry), logout);
  }
}

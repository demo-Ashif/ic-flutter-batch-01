import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();

    //receive message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage Called');
      print(message.data);
      print(message.notification?.title);
      print(message.notification?.body);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp');
      print(message.data);
      print(message.notification?.title);
      print(message.notification?.body);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    _listenToTokenRefresh();
  }

  static Future<String?> getFCMToken() async {
    return _firebaseMessaging.getToken();
  }

  static Future<void> _listenToTokenRefresh() async{
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      //TODO: update your new token with backend
      //api call
    });
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('handleBackgroundMessage');
  //TODO: Do something
}

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {

  // criar instancia do firebasemessaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initiNotifications() async {
    // requerir permissao de usuario
    await _firebaseMessaging.requestPermission();

    //token do dispositivo
    final fcmToken = await _firebaseMessaging.getToken();

    print('Token: $fcmToken');
  }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  @LazySingleton(scope: 'on_boarding')
  Future<SharedPreferences> get prefs async => SharedPreferences.getInstance();

  @LazySingleton(scope: 'auth')
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @LazySingleton(scope: 'auth')
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

  @LazySingleton(scope: 'auth')
  FirebaseStorage get firebaseStorage => FirebaseStorage.instance;
}

class $RegisterModule extends RegisterModule {}

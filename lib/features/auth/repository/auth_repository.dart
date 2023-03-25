// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reditt_clone/core/constants/firebase_constants.dart';
import 'package:reditt_clone/core/constants/picture_constants.dart';
import 'package:reditt_clone/core/failure.dart';
import 'package:reditt_clone/core/providers/common_providers.dart';
import 'package:reditt_clone/core/type_def.dart';
import 'package:reditt_clone/models/user_model.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firebaseFirestoreProvider),
    auth: ref.read(firebaseAuthProvider),
    googleSignIn: ref.read(
      googleSignInProvider,
    ),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.userCollection);

  FutureEither<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(googleCredential);

      //Storing to USermodel
      late UserModel userModel;
      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          name: userCredential.user!.displayName ?? "No Name",
          profilePic:
              userCredential.user!.photoURL ?? PictureConstants.avatarDefault,
          banner: PictureConstants.bannerDefault,
          uid: userCredential.user!.uid,
          isAuthenticated: true,
          karma: 0,
          awards: [],
        );

        await _users.doc(userModel.uid).set(userModel.toMap());
      }
      print(userCredential.user?.email);
      print(userCredential.user?.photoURL);
      return right(userModel);
    } on FirebaseException catch (error) {
      throw error.message!;
    } catch (error) {
      print(error);
      return left(Failure(error.toString()));
    }
  }
}

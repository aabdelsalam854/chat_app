
import 'package:dartz/dartz.dart';
import 'package:dd/features/login/data/repo/login_and_register_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/fire_base_error.dart';
import '../../../../core/fire_base_auth/fire_base_auth.dart';

class LoginAndRegisterRepoImpl implements LoginAndRegisterRepo {
  final FireAuth fireAuth;

  LoginAndRegisterRepoImpl(this.fireAuth);

  @override
  Future<Either<Fuiler, UserCredential>> register(
      String emailAddress, String password) async {
    try {
      final res =
          await fireAuth.createUserWithEmailAndPassword(emailAddress, password);
      return Right(res);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseError(e.toString()));
    } catch (e) {
      return left(FirebaseError(e.toString()));
    }
  }

  @override
  Future<Either<FirebaseError, UserCredential>> login(
      String emailAddress, String password) async {
    try {
      final res =
          await fireAuth.loginWithEmailAndPassword(emailAddress, password);
      return Right(res);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseError(e.toString()));
    } catch (e) {
      return left(FirebaseError(e.toString()));
    }
  }
}

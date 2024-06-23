
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/login/data/repo/login_and_register_repo_impl.dart';
import '../fire_base_auth/fire_base_auth.dart';

final getit = GetIt.instance;
void setUpServerLocator() {
  getit.registerSingleton<FireAuth>(FireAuth(FirebaseAuth.instance));
  getit.registerSingleton<LoginAndRegisterRepoImpl>(
      LoginAndRegisterRepoImpl(getit.get<FireAuth>()));
}

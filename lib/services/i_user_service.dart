import '../models/login_result.dart';
import '../models/user_data.dart';

abstract class IUserService {
  Future<LoginResult> signIn({required String username, required String password});
  Future<UserData> getUser();
}
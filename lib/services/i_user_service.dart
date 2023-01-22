import '../models/login_result.dart';

abstract class IUserService {
  Future<LoginResult> signIn({required String username, required String password});
}
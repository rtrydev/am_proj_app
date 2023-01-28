import 'package:am_proj_app/api/retrofit_api.dart';
import 'package:am_proj_app/api/retrofit_client.dart';
import 'package:am_proj_app/models/login_data.dart';
import 'package:am_proj_app/models/login_result.dart';
import 'package:am_proj_app/models/user_data.dart';
import 'package:am_proj_app/services/i_user_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: IUserService)
class LoginService implements IUserService {
  @override
  Future<LoginResult> signIn({required String username, required String password}) async {
    final api = RetrofitApi();
    final dio = await api.getApiClient();
    final client = RestClient(dio);

    final loginData = LoginData(username: username, password: password);
    final signInResult = await client.loginUser(loginData);

    final shared = await SharedPreferences.getInstance();
    shared.setString('token', signInResult.auth_token);

    return signInResult;
  }

  @override
  Future<UserData> getUser() async {
    final api = RetrofitApi();
    final dio = await api.getApiClient();
    final client = RestClient(dio);

    final user = await client.getUser();

    return user;
  }
}
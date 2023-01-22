import 'package:am_proj_app/api/retrofit_api.dart';
import 'package:am_proj_app/api/retrofit_client.dart';
import 'package:am_proj_app/models/login_data.dart';
import 'package:am_proj_app/models/login_result.dart';
import 'package:am_proj_app/services/i_user_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IUserService)
class LoginService implements IUserService {
  @override
  Future<LoginResult> signIn({required String username, required String password}) async {
    final api = RetrofitApi();
    final dio = await api.getApiClient();
    final client = RestClient(dio);

    final loginData = LoginData(username: username, password: password);
    final signInResult = await client.loginUser(loginData);

    return signInResult;
  }
}
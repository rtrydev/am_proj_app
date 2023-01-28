// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:am_proj_app/services/i_user_service.dart' as _i3;
import 'package:am_proj_app/services/i_waypoint_event_service.dart' as _i5;
import 'package:am_proj_app/services/i_waypoint_service.dart' as _i7;
import 'package:am_proj_app/services/user_service.dart' as _i4;
import 'package:am_proj_app/services/waypoint_event_service.dart' as _i6;
import 'package:am_proj_app/services/waypoint_service.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.IUserService>(() => _i4.LoginService());
    gh.factory<_i5.IWaypointEventService>(() => _i6.WaypointEventService());
    gh.factory<_i7.IWaypointService>(() => _i8.WaypointService());
    return this;
  }
}

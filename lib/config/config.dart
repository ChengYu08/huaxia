library config;

export 'theme/app_theme.dart';
export 'routers/app_routers.dart';
export 'assets/imgs.dart';
export 'img/img_net.dart';
export 'toast/app_toast.dart';
export 'homeWidget/app_widget.dart';
export 'http/api/api.dart';
export 'http/api/api_url.dart';
export 'http/api_service.dart';
export 'http/async_builder/async_builder.dart';
export 'apps/app_config.dart';

const appPath = AppPath.RELEASE;

enum AppPath{
  RELEASE,
  DEBUG,
  PREVIEW
}
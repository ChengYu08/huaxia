library config;

export 'theme/app_theme.dart';
export 'routers/app_routers.dart';
export 'assets/imgs.dart';
export 'img/img_net.dart';
export 'toast/app_toast.dart';
export 'homeWidget/app_widget.dart';
export 'http/api/api.dart';
const appPath = AppPath.DEBUG;
enum AppPath{
  RELEASE,
  DEBUG,
  PREVIEW
}
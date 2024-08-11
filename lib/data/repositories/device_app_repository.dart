import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

typedef DeviceApps = List<AppInfo>;

class DeviceAppRepository {
  Future<DeviceApps> getInstalledApps() async {
    return InstalledApps.getInstalledApps();
  }
}

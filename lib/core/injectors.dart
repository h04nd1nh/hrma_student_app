import 'package:get_it/get_it.dart';
import 'package:hrm_app/services/network/client/base_client.dart';
import 'package:hrm_app/services/network/dio/dio_config.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton<BaseClient>(BaseClient(DioConfig().dio));
}

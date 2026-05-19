import 'package:chat_app/src/core/di/modules/api_module.dart';
import 'package:chat_app/src/core/di/modules/bloc_module.dart';
import 'package:chat_app/src/core/di/modules/components_module.dart';
import 'package:chat_app/src/core/di/modules/repository_module.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

abstract class DIModule {
  void provides();
}

class Injection {
  static Future<void> inject() async {
    await ComponentsModule().provides();
    await ApiModule().provides();
    await RepositoryModule().provides();
    await BlocModule().provides();
  }
}

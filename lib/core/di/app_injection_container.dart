import 'package:get_it/get_it.dart';
import 'package:authentication_app/core/di/cubit_container/cubit_container.dart'
    as cc;
import 'package:authentication_app/core/di/data_source_container/data_source_container.dart'
    as dsc;
import 'package:authentication_app/core/di/repository_container/repository_container.dart'
    as rc;

final sl = GetIt.instance;

void init() {
  /* Cubits */
  cc.init();

  /* Data Sources */
  dsc.init();

  /* Repositories */
  rc.init();
}

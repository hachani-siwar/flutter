import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:proj/features/classes/data/datasources/classe_local_data_source.dart';
import 'package:proj/features/classes/data/datasources/classe_remote_data_source.dart';
import 'package:proj/features/classes/data/repositories/classe_repository_impl.dart';
import 'package:proj/features/classes/domain/repositories/classes_repository.dart';
import 'package:proj/features/classes/domain/usecases/add_classe.dart';
import 'package:proj/features/classes/domain/usecases/delete_classe.dart';
import 'package:proj/features/classes/domain/usecases/get_all_classes.dart';
import 'package:proj/features/classes/domain/usecases/update_classe.dart';
import 'package:proj/features/classes/presentation/blocs/classe_crud/classe_crud_bloc.dart';
import 'package:proj/features/classes/presentation/blocs/classes/classes_bloc.dart';
import 'package:proj/features/msg/data/datasources/msg_local_data_source.dart';
import 'package:proj/features/msg/data/datasources/msg_remote_data_source.dart';
import 'package:proj/features/msg/data/repositories/msg_repository_impl.dart';
import 'package:proj/features/msg/domain/repositories/msg_repository.dart';
import 'package:proj/features/msg/domain/usecases/add_msg.dart';
import 'package:proj/features/msg/domain/usecases/delete_msg.dart';
import 'package:proj/features/msg/domain/usecases/get_all_msg.dart';
import 'package:proj/features/msg/domain/usecases/update_msg.dart';
import 'package:proj/features/msg/presentation/blocs/msg/msg_bloc.dart';
import 'package:proj/features/msg/presentation/blocs/msg_crud/msg_crud_bloc.dart';
import 'package:proj/global/network/network_pipe.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //!features classes
  //Bloc
  sl.registerFactory(() => ClassesBloc(getAllClasses: sl()));
  sl.registerFactory(() =>
      ClasseCrudBloc(addClasse: sl(), updateClasse: sl(), deleteClasse: sl()));

  //Usecases
  sl.registerLazySingleton(() => GetAllClassesUsecase(sl()));
  sl.registerLazySingleton(() => AddClasseUsecase(sl()));
  sl.registerLazySingleton(() => UpdateClasseUsecase(sl()));
  sl.registerLazySingleton(() => DeleteClasseUsecase(sl()));

  //Repositories
  sl.registerLazySingleton<ClassesRepository>(() => ClassesRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  //Datasources

  sl.registerLazySingleton<ClasseRemoteDataSource>(
      () => ClasseRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ClasseLocalDataSource>(
      () => ClasseLocalDataSourceImpl(sharedPreferences: sl()));
      
  //!features classes
  //Bloc
  sl.registerFactory(() => MsgsBloc(getAllMsgs: sl()));
  sl.registerFactory(() =>
      MsgCrudBloc(addMsg: sl(), updateMsg: sl(), deleteMsg: sl()));

  //Usecases
  sl.registerLazySingleton(() => GetAllMsgsUsecase(sl()));
  sl.registerLazySingleton(() => AddMsgUsecase(sl()));
  sl.registerLazySingleton(() => UpdateMsgUsecase(sl()));
  sl.registerLazySingleton(() => DeleteMsgUsecase(sl()));

  //Repositories
  sl.registerLazySingleton<MsgsRepository>(() => MsgsRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  //Datasources

  sl.registerLazySingleton<MsgRemoteDataSource>(
      () => MsgRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<MsgLocalDataSource>(
      () => MsgLocalDataSourceImpl(sharedPreferences: sl()));
  //!core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //!external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

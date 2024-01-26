import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in/src/data/data_sources/impl/sign_in_remote_data_source_impl.dart';
import 'package:sign_in/src/data/data_sources/sign_in_remote_data_source.dart';
import 'package:sign_in/src/data/repository/sign_in_repository_impl.dart';
import 'package:sign_in/src/domain/repository/sign_in_repository.dart';
import 'package:sign_in/src/domain/usecases/sign_in_usecase.dart';
import 'package:sign_in/src/presentation/bloc/sign_in_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  // bloc
  locator.registerFactory(() => SignInBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => SignInUsecase(locator()));

  // repository
  locator.registerLazySingleton<SignInRepository>(
    () => SignInRepositoryImpl(locator()),
  );

  // data source
  locator.registerLazySingleton<SignInRemoteDataSource>(
    () => SignInRemoteDataSourceImpl(client: locator()),
  );

  locator.registerLazySingleton(() => http.Client());
}

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:search_donor/src/data/data_sources/impl/search_donor_remote_data_source_impl.dart';
import 'package:search_donor/src/data/data_sources/search_donor_remote_data_source.dart';
import 'package:search_donor/src/data/repository/search_donor_repository_impl.dart';
import 'package:search_donor/src/domain/repository/search_donor_repository.dart';
import 'package:search_donor/src/domain/usecases/search_donor_usecase.dart';
import 'package:search_donor/src/presentation/bloc/search_donor_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  // bloc
  locator.registerFactory(() => SearchDonorBloc(searchDonorUsecase: locator()));

  // usecase
  locator.registerLazySingleton(
    () => SearchDonorUsecase(searchDonorRepository: locator()),
  );

  // repository
  locator.registerLazySingleton<SearchDonorRepository>(
    () => SearchDonorRepositoryImpl(searchDonorRemoteDataSource: locator()),
  );

  // data source
  locator.registerLazySingleton<SearchDonorRemoteDataSource>(
    () => SearchDonorRemoteDataSourceImpl(client: locator()),
  );

  locator.registerLazySingleton(() => http.Client());
}

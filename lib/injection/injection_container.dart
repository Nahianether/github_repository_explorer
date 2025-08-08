import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

import '../core/network/network_info.dart';

import '../features/repository_search/domain/repositories/repository_repository.dart';
import '../features/repository_search/domain/usecases/search_repositories.dart';
import '../features/repository_search/domain/usecases/refresh_repositories.dart';

import '../features/repository_search/data/repositories/repository_repository_impl.dart';
import '../features/repository_search/data/datasources/remote/repository_remote_data_source.dart';
import '../features/repository_search/data/datasources/remote/repository_remote_data_source_impl.dart';
import '../features/repository_search/data/datasources/remote/github_api_service.dart';
import '../features/repository_search/data/datasources/local/repository_local_data_source.dart';
import '../features/repository_search/data/datasources/local/repository_local_data_source_impl.dart';
import '../features/repository_search/data/datasources/local/database_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await DatabaseHelper.init();
  final searchResultBox = await DatabaseHelper.getSearchResultBox();

  sl.registerLazySingleton(() => SearchRepositoriesUseCase(sl()));
  sl.registerLazySingleton(() => RefreshRepositoriesUseCase(sl()));

  sl.registerLazySingleton<RepositoryRepository>(
    () => RepositoryRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<RepositoryRemoteDataSource>(
    () => RepositoryRemoteDataSourceImpl(apiService: sl()),
  );

  sl.registerLazySingleton<RepositoryLocalDataSource>(
    () => RepositoryLocalDataSourceImpl(searchResultBox),
  );

  sl.registerLazySingleton(() => GitHubApiService(client: sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}
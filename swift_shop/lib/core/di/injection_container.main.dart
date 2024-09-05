part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(http.Client.new);
  await _cacheInit();
  await _userAuthInit();
  await _categoryInit();
}

Future<void> _cacheInit() async {
  final prefs = await SharedPreferences.getInstance();
  sl
    ..registerLazySingleton(() => CacheHelper(sl()))
    ..registerLazySingleton<SharedPreferences>(() => prefs);
}

Future<void> _userAuthInit() async {
  // Registering AuthRemoteDataSrc if not already registered
  sl.registerLazySingleton<AuthRemoteDataSrc>(() =>
      AuthRemoteDataSrcImpl(sl())); //object initialize and inject dependencies

  // Registering AuthRepo and its implementation
  sl.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(sl<AuthRemoteDataSrc>()));

  // Registering AuthController
  sl.registerLazySingleton<AuthController>(
      () => AuthController(sl<AuthRepo>()));
}

Future<void> _categoryInit() async {
  // Registering AuthRemoteDataSrc if not already registered
  sl.registerLazySingleton<CategoryRemoteDataSrc>(() =>
      CategoryRemoteDataSrcImpl(
          sl())); //object initialize and inject dependencies

  // Registering AuthRepo and its implementation
  sl.registerLazySingleton<CategoryRepo>(
      () => CategoryRepoImpl(sl<CategoryRemoteDataSrc>()));

  // Registering CategoryController
  sl.registerLazySingleton<CategoryController>(
      () => CategoryController(sl<CategoryRepo>()));
}

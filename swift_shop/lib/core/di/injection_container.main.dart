part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(http.Client.new);
  await _cacheInit();
  await _userAuthInit();
  await _categoryInit();
  await _productInit();
  await _cartInit();
  await _profileInit();
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

Future<void> _productInit() async {
  // Registering AuthRemoteDataSrc if not already registered
  sl.registerLazySingleton<ProductRemoteDataSrc>(() => ProductRemoteDataSrcImpl(
      sl())); //object initialize and inject dependencies

  // Registering AuthRepo and its implementation
  sl.registerLazySingleton<ProductRepo>(
      () => ProductRepoImpl(sl<ProductRemoteDataSrc>()));

  // Registering CategoryController
  sl.registerLazySingleton<ProductController>(
      () => ProductController(sl<ProductRepo>()));
}

Future<void> _cartInit() async {
  // Registering AuthRemoteDataSrc if not already registered
  sl.registerLazySingleton<CartRemoteDataSrc>(() =>
      CartRemoteDataSrcImpl(sl())); //object initialize and inject dependencies

  // Registering AuthRepo and its implementation
  sl.registerLazySingleton<CartRepo>(
      () => CartRepoImpl(sl<CartRemoteDataSrc>()));

  // Registering CategoryController
  sl.registerLazySingleton<CartController>(
      () => CartController(sl<CartRepo>()));
}

Future<void> _profileInit() async {
  // Registering AuthRemoteDataSrc if not already registered
  sl.registerLazySingleton<UserRemoteDataSrc>(() =>
      UserRemoteDataSrcImpl(sl())); //object initialize and inject dependencies

  // Registering AuthRepo and its implementation
  sl.registerLazySingleton<UserRepo>(
          () => UserRepoImpl(sl<UserRemoteDataSrc>()));

  // Registering CategoryController
  sl.registerLazySingleton<ProfileController>(
          () => ProfileController(sl<UserRepo>()));
}

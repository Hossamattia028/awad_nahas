part of "injection_container_import.dart";


final sl = GetIt.instance;

Future<void> init() async {

  //controller
  sl.registerFactory(() => RootBloc());

  /// authentication bloc and classes initial
  sl.registerFactory(() => AuthBloc(
      loginUserServiceUseCase: sl(),
      registerUserServiceUseCase: sl(),
      socialUserServiceUseCase: sl(),
    ));

  sl.registerLazySingleton(() => RegisterUserServiceUseCase(authServiceRepository: sl()));
  sl.registerLazySingleton(() => LoginUserServiceUseCase(authServiceRepository: sl()));
  sl.registerLazySingleton(() => SocialUserServiceUseCase(authServiceRepository: sl()));

  sl.registerLazySingleton<AuthServiceRepository>(() => AuthServiceModelRepository(networkInfo: sl(), userServiceRemoteDataSource: sl()));
  sl.registerLazySingleton<AuthServiceRemoteDataSource>(() => AuthServiceRemoteDataSource(client: sl()));


  ///account module
  sl.registerFactory(() => AccountBloc(
    getUserServiceUseCase: sl(),
    updateUserServiceUseCase: sl(),
    changePasswordUseCase: sl(),
    getAllNotificationsUseCase: sl(),
    getAllUsersUseCase: sl()
  ));
  sl.registerLazySingleton(() => GetAllUsersUseCase(userServiceRepository: sl()));
  sl.registerLazySingleton(() => GetUserServiceUseCase(userServiceRepository: sl()));
  sl.registerLazySingleton(() => UpdateUserServiceUseCase(userServiceRepository: sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(userServiceRepository: sl()));
  sl.registerLazySingleton(() => GetAllNotificationsUseCase(settingsRepository: sl()));

  sl.registerLazySingleton<UserServiceRepository>(() => UserServiceModelRepository(networkInfo: sl(), userServiceRemoteDataSource: sl()));
  sl.registerLazySingleton<UserServiceRemoteDataSource>(() => UserServiceRemoteDataSource(client: sl()));



  /// order module
  sl.registerFactory(() => OrderBloc(getAllOrderUseCase: sl(),addOrderUseCase: sl(),updateOrderUseCase: sl()));
  sl.registerLazySingleton(() => GetAllOrderUseCase(orderRepository: sl()));
  sl.registerLazySingleton(() => AddOrderUseCase(orderRepository: sl()));
  sl.registerLazySingleton(() => CancelOrderUseCase(orderRepository: sl()));
  // sl.registerLazySingleton(() => GetAllDriversOrdersUseCase(orderRepository: sl()));
  sl.registerLazySingleton(() => UpdateOrderUseCase(orderRepository: sl()));
  sl.registerLazySingleton<OrderRepository>(() => OrderModelRepository(networkInfo: sl(), orderRemoteDataSource: sl()));
  sl.registerLazySingleton<OrderRemoteDataSourceImpl>(() => OrderRemoteDataSource(client: sl()));


  //
  // /// settings module
  // sl.registerLazySingleton(() => GetAboutUsUseCase(aboutUsRepository: sl()));
  // sl.registerLazySingleton(() => GetTermsUseCase(termsRepository: sl()));
  // sl.registerLazySingleton(() => GetPrivacyUseCase(privacyRepository: sl()));
  sl.registerLazySingleton<SettingsRepository>(() => SettingsModelRepository(networkInfo: sl(), settingsRemoteDataSourceImpl: sl()));
  sl.registerLazySingleton<SettingsRemoteDataSourceImpl>(() => SettingsRemoteDataSource(client: sl()));


  /// locations module
  sl.registerFactory(() => LocationsBloc(
    fetchUserLocationsUseCase: sl(),
    addLocationUseCase: sl(),
    removeLocationUseCase: sl(),
    updateLocationUseCase: sl(),));
  sl.registerLazySingleton(() => FetchUserLocationsUseCase(locationsRepository: sl()));
  sl.registerLazySingleton(() => AddLocationUseCase(locationsRepository: sl()));
  sl.registerLazySingleton(() => UpdateLocationUseCase(locationsRepository: sl()));
  sl.registerLazySingleton(() => RemoveLocationUseCase(locationsRepository: sl()));

  sl.registerLazySingleton<LocationsRepository>(() => LocationsModelRepository(networkInfo: sl(), locationRemoteDataSource: sl()));
  sl.registerLazySingleton<LocationRemoteDataSource>(() => LocationRemoteDataSourceImpl(client: sl()));


  /// categories bloc and classes initial
  sl.registerFactory(() => CategoriesBloc(getAllCategoryUseCase: sl(),getAllSlidersUseCase: sl(),getAllBrandsUseCase: sl()));
  sl.registerLazySingleton(() => GetAllCategoryUseCase(categoryRepository: sl()));
  sl.registerLazySingleton(() => GetAllBrandsUseCase(categoryRepository: sl()));
  sl.registerLazySingleton(() => GetAllSlidersUseCase(categoryRepository: sl()));
  sl.registerLazySingleton<CategoryRepository>(() => CategoryModelRepository(networkInfo: sl(), categoryRemoteDataSource: sl()));
  sl.registerLazySingleton<CategoryRemoteDataSource>(() => CategoryRemoteDataSourceImpl(client: sl()));


  /// products bloc and classes initial
  sl.registerFactory(() => ProductsBloc(getAllProductsUseCase: sl(),getAllProductCommentsUseCase: sl(),addProductCommentUseCase: sl()));
  sl.registerLazySingleton(() => GetAllProductsUseCase(productsRepository: sl()));
  sl.registerLazySingleton(() => GetAllProductCommentsUseCase(productsRepository: sl()));
  sl.registerLazySingleton(() => AddProductCommentUseCase(productsRepository: sl()));

  sl.registerLazySingleton<ProductsRepository>(() => ProductsModelRepository(networkInfo: sl(), productsRemoteDataSource: sl()));
  sl.registerLazySingleton<ProductsRemoteDataSource>(() => ProductsRemoteDataSourceImpl(client: sl()));


  /// favourite module
  sl.registerFactory(() => WishlistBloc(getAllFavouritesUseCase: sl(),addFavouriteItemUseCase: sl(),removeFavouriteItemUseCase: sl()));
  sl.registerLazySingleton(() => GetAllFavouritesUseCase(favouriteRepository: sl()));
  sl.registerLazySingleton(() => AddFavouriteItemUseCase(favouriteRepository: sl()));
  sl.registerLazySingleton(() => RemoveFavouriteItemUseCase(favouriteRepository: sl()));
  sl.registerLazySingleton<FavouriteRepository>(() => FavouriteModelRepository(networkInfo: sl(), favouriteRemoteDataSourceImpl: sl()));
  sl.registerLazySingleton<FavouriteRemoteDataSourceImpl>(() => FavouriteRemoteDataSource(client: sl()));


  /// cart module
  sl.registerFactory(() => CartBloc(getAllCartListUseCase: sl(),addCartItemUseCase: sl(),removeCartItemUseCase: sl(),applyCouponUseCase: sl()));
  sl.registerLazySingleton(() => GetAllCartListUseCase(cartRepository: sl()));
  sl.registerLazySingleton(() => AddCartItemUseCase(cartRepository: sl()));
  sl.registerLazySingleton(() => RemoveCartItemUseCase(cartRepository: sl()));
  sl.registerLazySingleton(() => ApplyCouponUseCase(cartRepository: sl()));
  sl.registerLazySingleton<CartRepository>(() => CartModelRepository(networkInfo: sl(), cartRemoteDataSourceImpl: sl()));
  sl.registerLazySingleton<CartRemoteDataSourceImpl>(() => CartRemoteDataSource(client: sl()));



  /// additional classes initial
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton(() => http.Client());
}



import 'package:awad_nahas/features/account/domain/use_cases/get_all_users_usecase.dart';
import 'package:awad_nahas/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:awad_nahas/features/cart/data/repositories/cart_model_repository.dart';
import 'package:awad_nahas/features/cart/domain/repositories/cart_repository.dart';
import 'package:awad_nahas/features/cart/domain/use_cases/cart_usecase.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/categories/data/data_sources/category_remote_data_source.dart';
import 'package:awad_nahas/features/categories/data/repositories/category_model_repository.dart';
import 'package:awad_nahas/features/categories/domain/repositories/category_repository.dart';
import 'package:awad_nahas/features/categories/domain/use_cases/get_all_categories_usecase.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/locations/data/data_sources/location_remote_data_source.dart';
import 'package:awad_nahas/features/locations/data/repositories/locations_model_repository.dart';
import 'package:awad_nahas/features/locations/domain/repositories/location_repository.dart';
import 'package:awad_nahas/features/locations/domain/use_cases/locations_usecase.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/order/domain/use_cases/update_order_usecase.dart';
import 'package:awad_nahas/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:awad_nahas/features/products/data/repositories/products_model_repository.dart';
import 'package:awad_nahas/features/products/domain/repositories/products_repository.dart';
import 'package:awad_nahas/features/products/domain/use_cases/comment_usecase.dart';
import 'package:awad_nahas/features/products/domain/use_cases/products_usecase.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/setting/data/data_sources/settings_remote_data_source.dart';
import 'package:awad_nahas/features/setting/data/repositories/settings_mode_repository.dart';
import 'package:awad_nahas/features/setting/domain/repositories/settings_repository.dart';
import 'package:awad_nahas/features/setting/domain/use_cases/notifications_usecase.dart';
import 'package:awad_nahas/features/wishlist/data/data_sources/favourite_remote_data_source.dart';
import 'package:awad_nahas/features/wishlist/data/repositories/favourite_model_repository.dart';
import 'package:awad_nahas/features/wishlist/domain/repositories/favourite_repository.dart';
import 'package:awad_nahas/features/wishlist/domain/use_cases/favourite_usecase.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:awad_nahas/core/network/network.dart';
import 'package:awad_nahas/features/account/data/data_sources/account_data_source.dart';
import 'package:awad_nahas/features/account/data/repositeroies/user_service_model_repository.dart';
import 'package:awad_nahas/features/account/domain/repositories/user_service_repository.dart';
import 'package:awad_nahas/features/account/domain/use_cases/change_password_usercase.dart';
import 'package:awad_nahas/features/account/domain/use_cases/get_user_service_usecase.dart';
import 'package:awad_nahas/features/account/domain/use_cases/update_user_usecase.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/authentication/data/data_sources/authentication_data_source.dart';
import 'package:awad_nahas/features/authentication/data/repositories/auth_service_model_repository.dart';
import 'package:awad_nahas/features/authentication/domain/repositories/auth_service_repository.dart';
import 'package:awad_nahas/features/authentication/domain/use_cases/login_user_usecase.dart';
import 'package:awad_nahas/features/authentication/domain/use_cases/register_user_usecase.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:awad_nahas/features/order/data/data_sources/order_remote_data_source.dart';
import 'package:awad_nahas/features/order/data/repositories/order_model_repository.dart';
import 'package:awad_nahas/features/order/domain/repositories/oder_repository.dart';
import 'package:awad_nahas/features/order/domain/use_cases/add_order_usecase.dart';
import 'package:awad_nahas/features/order/domain/use_cases/delete_order_usecase.dart';
import 'package:awad_nahas/features/order/domain/use_cases/get_all_order_usecase.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
final sl = GetIt.instance;

Future<void> init() async {

  //controller
  sl.registerFactory(() => RootBloc());

  /// authentication bloc and classes initial
  sl.registerFactory(() => AuthBloc(
      loginUserServiceUseCase: sl(),
      registerUserServiceUseCase: sl(),
    ));

  sl.registerLazySingleton(() => RegisterUserServiceUseCase(authServiceRepository: sl()));
  sl.registerLazySingleton(() => LoginUserServiceUseCase(authServiceRepository: sl()));

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
  sl.registerLazySingleton<LocationRemoteDataSourceImpl>(() => LocationRemoteDataSource(client: sl()));


  /// categories bloc and classes initial
  sl.registerFactory(() => CategoriesBloc(getAllCategoryUseCase: sl(),getAllSlidersUseCase: sl()));
  sl.registerLazySingleton(() => GetAllCategoryUseCase(categoryRepository: sl()));
  sl.registerLazySingleton(() => GetAllSlidersUseCase(categoryRepository: sl()));
  sl.registerLazySingleton<CategoryRepository>(() => CategoryModelRepository(networkInfo: sl(), categoryRemoteDataSource: sl()));
  sl.registerLazySingleton<CategoryRemoteDataSourceImpl>(() => CategoryRemoteDataSource(client: sl()));


  /// products bloc and classes initial
  sl.registerFactory(() => ProductsBloc(getAllProductsUseCase: sl(),getAllProductCommentsUseCase: sl(),addProductCommentUseCase: sl()));
  sl.registerLazySingleton(() => GetAllProductsUseCase(productsRepository: sl()));
  sl.registerLazySingleton(() => GetAllProductCommentsUseCase(productsRepository: sl()));
  sl.registerLazySingleton(() => AddProductCommentUseCase(productsRepository: sl()));

  sl.registerLazySingleton<ProductsRepository>(() => ProductsModelRepository(networkInfo: sl(), productsRemoteDataSourceImpl: sl()));
  sl.registerLazySingleton<ProductsRemoteDataSourceImpl>(() => ProductsRemoteDataSource(client: sl()));


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


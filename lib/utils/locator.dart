import 'package:get_it/get_it.dart';
import 'package:newapi_app/features/news_list_feature/news_list_cubit/news_list_cubit.dart';
import 'package:newapi_app/features/news_list_feature/news_list_interface/news_list_interface.dart';
import 'package:newapi_app/features/news_list_feature/news_list_repository/news_list_repository.dart';
import 'package:newapi_app/utils/server_util.dart';

final GetIt locator = GetIt.instance;

Future<void> configureDependencies() async {

  //repositories
  locator.registerLazySingleton<NewsListInterface>(
      () => NewsListRepository());

  //cubits
  locator.registerFactory<NewsListCubit>(() => NewsListCubit(locator()));

   //utils
  locator.registerSingleton<ServerUtil>(ServerUtil());
  locator.get<ServerUtil>().init();
}

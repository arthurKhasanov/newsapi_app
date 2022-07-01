import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapi_app/features/news_list_feature/news_list_cubit/news_list_cubit.dart';
import 'package:newapi_app/features/news_list_feature/view/screens/news_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newapi_app/utils/locator.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await ScreenUtil.ensureScreenSize();
  initializeDateFormatting('ru', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 795),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => SystemChannels.textInput.invokeMethod('TextInput.hide'),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            home: child,
          ),
        );
      },
      child: BlocProvider<NewsListCubit>(
        create: (BuildContext context) => NewsListCubit(locator()),
        child: const NewsList(),
      ),
    );
  }
}

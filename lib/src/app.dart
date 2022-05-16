import 'package:citizens/src/bloc/articles/articles_cubit.dart';
import 'package:citizens/src/bloc/featured/featured_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/grid/grid_cubit.dart';
import 'pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ArticlesCubit(),
        ),
        BlocProvider(
          create: (context) => FeaturedCubit(),
        ),
        BlocProvider(
          create: (context) => GridCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'citizens',
        theme: ThemeData(
          primaryColor: const Color(0xff121A23),
          cardColor: const Color(0xff121A23),
          scaffoldBackgroundColor: const Color(0xff121A23),
          textTheme: const TextTheme(
            bodyText2: TextStyle(color: Color(0xffFFFFFF))
          )
          //scaffoldBackgroundColor: const Color(0xff17202A),
        ),
        home: const LoginPage(),
      ),
    );
  }
}
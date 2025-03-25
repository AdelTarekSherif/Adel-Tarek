import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adel_tarek/data/bloc/meals/meal_bloc.dart';
import 'package:adel_tarek/ui/style/app.fonts.dart';
import 'package:adel_tarek/ui/style/theme.dart';
import 'package:adel_tarek/utils/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:adel_tarek/utils/router/route_names.dart';
import 'package:adel_tarek/utils/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Lock device on portrait mode only
  runApp(const Root());
}

class Root extends StatefulWidget {
  const Root({super.key});

  static RouteObserver<ModalRoute<void>> routeObserver =
      RouteObserver<ModalRoute<void>>();
  static late String fontFamily;
  static Locale locale = const Locale('en');
  static late String routeName;
  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    Root.fontFamily = AppFonts.fontSfPro;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealBloc(),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: Constants.appName,
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: AppTheme(Root.fontFamily).lightModeTheme,
            localeResolutionCallback: (locale, supportedLocales) {
              return supportedLocales.firstWhere(
                (supportedLocale) =>
                    supportedLocale.languageCode == locale?.languageCode,
                orElse: () => supportedLocales.first,
              );
            },
            locale: Root.locale,
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: RouteNames.rSplashPage,
            navigatorObservers: [Root.routeObserver],
          );
        },
      ),
    );
  }
}

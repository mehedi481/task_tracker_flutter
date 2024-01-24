import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_tracker_flutter/config/theme.dart';
import 'package:task_tracker_flutter/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: false,
      builder: (context, child) {
        return MaterialApp(
          title: 'Task Tracker',
          theme: AppTheme.lightTheme,
          initialRoute: Routes.splash,
          onGenerateRoute: generatedRoutes,
        );
      },
    );
  }
}

import 'package:colco_poc/config/theme.dart';
import 'package:colco_poc/core/utils/constants.dart';
import 'package:colco_poc/injector.dart';
import 'package:colco_poc/presentation/providers/posts_provider.dart';
import 'package:colco_poc/presentation/providers/user_provider.dart';
import 'package:colco_poc/presentation/ui/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  runApp(const ColcoPOC());
}

class ColcoPOC extends StatelessWidget {
  const ColcoPOC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => getIt()),
        ChangeNotifierProvider<PostsProvider>(create: (_) => getIt())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.defaultTheme,
        title: AppStrings.kTitle,
        home: const OnboardingPage(),
      ),
    );
  }
}

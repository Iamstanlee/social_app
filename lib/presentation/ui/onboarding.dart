import 'package:colco_poc/config/theme.dart';
import 'package:colco_poc/core/utils/constants.dart';
import 'package:colco_poc/core/utils/extensions.dart';
import 'package:colco_poc/presentation/providers/user_provider.dart';
import 'package:colco_poc/presentation/ui/foryou/foryou.dart';
import 'package:colco_poc/presentation/widgets/button.dart';
import 'package:colco_poc/presentation/widgets/gap.dart';
import 'package:colco_poc/presentation/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewstate = context.watch<UserProvider>().userData;
    return Scaffold(
      body: _viewstate.when(
        loading: (_) => const LoadingIndicator(),
        done: (data) => Padding(
          padding: const EdgeInsets.all(Insets.lg),
          child: Column(
            children: [
              const Gap(70),
              Info(
                'Welcome to ColcoTok',
                'A random user account has been created for you, your username is @${data.username}',
                PhosphorIcons.applePodcastsLogo,
              ),
              Gap.lg,
              const Info(
                'Unimplemented Features',
                'Due to time constraints on the task, These features were not implemented\n- Authentication\n- TDD\n- Create posts',
                PhosphorIcons.code,
              ),
              Gap.lg,
              const Info(
                'Implemented Features',
                'You can\n- View posts\n- Like/Dislike\n- Comment\n- Share post',
                PhosphorIcons.code,
              ),
              const Spacer(),
              Button(
                "GET RIGHT IN",
                onTap: () => context.push(const ForYouPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Info extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  const Info(this.title, this.subtitle, this.icon, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: IconSizes.lg,
        ),
        Gap.md,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textTheme.subtitle1,
              ),
              Gap.sm,
              Text(
                subtitle,
                style: context.textTheme.subtitle1!
                    .copyWith(color: AppColors.kGrey),
              ),
            ],
          ),
        )
      ],
    );
  }
}

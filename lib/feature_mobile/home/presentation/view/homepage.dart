import 'package:ams_mobile/feature_mobile/home/presentation/widget/home_content.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_event.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_provider.dart';
import 'package:ams_mobile/feature_mobile/profile/presentation/provider/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CondoHomePage extends ConsumerWidget {
  const CondoHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);

    // Trigger fetch once when initial
    if (profileState is ProfileInitial) {
      Future.microtask(() {
        ref
            .read(profileNotifierProvider.notifier)
            .handleEvent(const FetchProfileEvent());
      });
    }

    if (profileState is ProfileLoading || profileState is ProfileInitial) {
      return const Center(child: CircularProgressIndicator());
    }

    if (profileState is! ProfileLoaded) {
      return const SizedBox.shrink();
    }

    final profile = profileState.userProfile;

    return HomeContent(
      name: profile.fullName,
      unitInfo: profile.unitInfo,
      imageUrl: profile.imageUrl,
    );
  }
}

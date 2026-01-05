import 'package:ams_mobile/core/providers/theme_provider.dart';
import 'package:ams_mobile/core/utils/app_colors.dart';
import 'package:ams_mobile/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Theme switcher widget
/// Allows users to toggle between light, dark, and system themes
class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme Settings',
              style: AppTextStyles.titleMedium(
                fontWeight: AppTextStyles.semiBold,
              ),
            ),
            const SizedBox(height: 16),
            _ThemeOption(
              title: 'Light Mode',
              subtitle: 'Always use light theme',
              icon: Icons.light_mode,
              isSelected: themeMode == ThemeMode.light,
              onTap: () => ref.read(themeModeProvider.notifier).setLightMode(),
            ),
            const SizedBox(height: 8),
            _ThemeOption(
              title: 'Dark Mode',
              subtitle: 'Always use dark theme',
              icon: Icons.dark_mode,
              isSelected: themeMode == ThemeMode.dark,
              onTap: () => ref.read(themeModeProvider.notifier).setDarkMode(),
            ),
            const SizedBox(height: 8),
            _ThemeOption(
              title: 'System Default',
              subtitle: 'Follow device settings',
              icon: Icons.brightness_auto,
              isSelected: themeMode == ThemeMode.system,
              onTap: () => ref.read(themeModeProvider.notifier).setSystemMode(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.border(context).withValues(alpha: 0.5),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.icon(context),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyLarge(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary(context),
                      fontWeight: isSelected
                          ? AppTextStyles.semiBold
                          : AppTextStyles.medium,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall(
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.primary,
              ),
          ],
        ),
      ),
    );
  }
}

/// Simple theme toggle button
/// Toggles between light and dark mode only
class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return IconButton(
      icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
      tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      onPressed: () {
        ref.read(themeModeProvider.notifier).toggleTheme();
      },
    );
  }
}

/// Theme toggle switch
/// A switch widget to toggle between light and dark themes
class ThemeToggleSwitch extends ConsumerWidget {
  const ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.light_mode,
          color: !isDark ? AppColors.primary : AppColors.icon(context),
        ),
        const SizedBox(width: 8),
        Switch(
          value: isDark,
          onChanged: (_) {
            ref.read(themeModeProvider.notifier).toggleTheme();
          },
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.dark_mode,
          color: isDark ? AppColors.primary : AppColors.icon(context),
        ),
      ],
    );
  }
}

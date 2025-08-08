import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/theme_provider.dart';

class ThemeSelectorWidget extends ConsumerWidget {
  const ThemeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    final colorScheme = ref.watch(colorSchemeProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.palette,
                color: colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Choose Theme',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemCount: AppTheme.availableThemes.length,
            itemBuilder: (context, index) {
              final theme = AppTheme.availableThemes[index];
              final isSelected = currentTheme == theme.type;
              final themeColorScheme = AppTheme.getColorScheme(theme.type);

              return GestureDetector(
                onTap: () {
                  ref.read(themeProvider.notifier).setTheme(theme.type);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: themeColorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? themeColorScheme.primary
                          : colorScheme.outline.withValues(alpha: 0.3),
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: themeColorScheme.primary.withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: themeColorScheme.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          theme.icon,
                          color: themeColorScheme.onPrimaryContainer,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        theme.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: themeColorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (isSelected) ...[
                        const SizedBox(height: 4),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: themeColorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: colorScheme.onSurfaceVariant,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Theme changes are saved automatically and will persist across app restarts.',
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ThemePreviewCard extends StatelessWidget {
  final ThemeType themeType;
  final bool isSelected;
  final VoidCallback onTap;

  const ThemePreviewCard({
    super.key,
    required this.themeType,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = AppTheme.getColorScheme(themeType);
    final themeOption = AppTheme.availableThemes
        .firstWhere((theme) => theme.type == themeType);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outline.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withValues(alpha: 0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                themeOption.icon,
                color: colorScheme.onPrimaryContainer,
                size: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              themeOption.name,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 2),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/repository_entity.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/theme/app_theme.dart';

class RepositoryDetailPage extends ConsumerWidget {
  final RepositoryEntity repository;

  const RepositoryDetailPage({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = ref.watch(colorSchemeProvider);
    final currentTheme = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Details',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Dark mode',
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: currentTheme == ThemeType.dark,
                  onChanged: (value) {
                    ref.read(themeProvider.notifier).setTheme(
                      value ? ThemeType.dark : ThemeType.light
                    );
                  },
                  activeColor: colorScheme.primary,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      backgroundColor: colorScheme.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    repository.name,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                      fontSize: 20,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: colorScheme.secondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatNumber(repository.stargazersCount),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.fork_right,
                      size: 16,
                      color: colorScheme.secondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Fork: ${_formatNumber(repository.forksCount)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: CachedNetworkImage(
                      imageUrl: repository.owner.avatarUrl,
                      width: 70,
                      height: 70,
                      placeholder: (context, url) => Container(
                        width: 70,
                        height: 70,
                        color: Colors.grey[300],
                        child: const Icon(Icons.person, size: 35),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 70,
                        height: 70,
                        color: Colors.grey[300],
                        child: const Icon(Icons.person, size: 35),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    repository.owner.login,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _launchUrl(repository.htmlUrl),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.code,
                          size: 16,
                          color: colorScheme.onSurface,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'github.com/user',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface,
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            Text(
              repository.description != null && repository.description!.isNotEmpty
                  ? repository.description!
                  : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
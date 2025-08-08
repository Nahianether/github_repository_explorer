import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/repository_card.dart';
import '../widgets/shimmer_loading.dart';
import '../providers/repository_provider.dart' hide themeProvider;
import '../state/repository_state.dart';
import 'repository_detail_page.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/theme/app_theme.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _lastErrorMessage;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      ref.read(repositoryProvider.notifier).loadMoreRepositories();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = ref.watch(colorSchemeProvider);
    final currentTheme = ref.watch(themeProvider);
    final repositoryState = ref.watch(repositoryProvider);

    ref.listen<RepositoryState>(repositoryProvider, (previous, next) {
      String? errorMessage;

      if (next is RepositoryError) {
        errorMessage = next.message;
      } else if (next is RepositoryLoaded && next.error != null) {
        errorMessage = next.error!;
      }

      if (errorMessage != null && errorMessage != _lastErrorMessage) {
        _lastErrorMessage = errorMessage;

        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 8),
            action: errorMessage.contains('rate limit') || errorMessage.contains('API')
                ? SnackBarAction(
                    label: 'Show Cached',
                    textColor: Colors.white,
                    onPressed: () {
                      _lastErrorMessage = null;
                      ref.read(repositoryProvider.notifier).loadCachedRepositories();
                    },
                  )
                : SnackBarAction(
                    label: 'Retry',
                    textColor: Colors.white,
                    onPressed: () {
                      _lastErrorMessage = null;
                      ref.read(repositoryProvider.notifier).refreshRepositories();
                    },
                  ),
          ),
        );
      }

      if (next is RepositoryLoaded && next.error == null) {
        _lastErrorMessage = null;
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Repositories',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
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
                    ref.read(themeProvider.notifier).setTheme(value ? ThemeType.dark : ThemeType.light);
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: colorScheme.surface,
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _searchController,
              builder: (context, value, child) {
                return TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      final query = value.contains('in:name') ? value : '$value in:name';
                      ref.read(repositoryProvider.notifier).searchRepositories(query);
                    } else {
                      ref.read(repositoryProvider.notifier).searchRepositories('flutter in:name');
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(
                      Icons.search,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    suffixIcon: value.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.close,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              ref.read(repositoryProvider.notifier).searchRepositories('flutter in:name');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: colorScheme.surfaceVariant,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  style: TextStyle(
                    color: colorScheme.onSurface,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: _buildBody(repositoryState, theme, colorScheme),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(RepositoryState state, ThemeData theme, AppColorScheme colorScheme) {
    return switch (state) {
      RepositoryInitial() => const ShimmerLoading(),
      RepositoryLoading() => const ShimmerLoading(),
      RepositoryLoaded() => Column(
          children: [
            if (state.isFromCache)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: colorScheme.primaryContainer,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.offline_bolt,
                      size: 16,
                      color: colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Showing cached data',
                      style: TextStyle(
                        color: colorScheme.onPrimaryContainer,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  ref.read(repositoryProvider.notifier).refreshRepositories();
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.hasReachedMax ? state.repositories.length : state.repositories.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= state.repositories.length) {
                      return state.isLoadingMore
                          ? const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : const SizedBox.shrink();
                    }

                    final repository = state.repositories[index];
                    return RepositoryCard(
                      repository: repository,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RepositoryDetailPage(
                              repository: repository,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      RepositoryError() => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[400],
              ),
              const SizedBox(height: 16),
              Text(
                'Error',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                state.message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ref.read(repositoryProvider.notifier).refreshRepositories();
                    },
                    child: const Text('Retry'),
                  ),
                  if (state.message.contains('rate limit') || state.message.contains('API')) ...{
                    const SizedBox(width: 16),
                    OutlinedButton(
                      onPressed: () {
                        ref.read(repositoryProvider.notifier).loadCachedRepositories();
                      },
                      child: const Text('Show Cached Data'),
                    ),
                  },
                ],
              ),
            ],
          ),
        ),
    };
  }
}

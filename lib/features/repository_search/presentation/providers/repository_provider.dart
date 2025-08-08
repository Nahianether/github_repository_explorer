import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/repository_entity.dart';
import '../../domain/usecases/search_repositories.dart';
import '../../domain/usecases/refresh_repositories.dart';
import '../../domain/usecases/get_cached_repositories.dart';
import '../../../../core/utils/usecase.dart';
import '../../../../injection/injection_container.dart';
import '../state/repository_state.dart';

class RepositoryNotifier extends StateNotifier<RepositoryState> {
  final SearchRepositoriesUseCase _searchRepositoriesUseCase;
  final RefreshRepositoriesUseCase _refreshRepositoriesUseCase;
  final GetCachedRepositoriesUseCase _getCachedRepositoriesUseCase;

  RepositoryNotifier({
    required SearchRepositoriesUseCase searchRepositoriesUseCase,
    required RefreshRepositoriesUseCase refreshRepositoriesUseCase,
    required GetCachedRepositoriesUseCase getCachedRepositoriesUseCase,
  })  : _searchRepositoriesUseCase = searchRepositoriesUseCase,
        _refreshRepositoriesUseCase = refreshRepositoriesUseCase,
        _getCachedRepositoriesUseCase = getCachedRepositoriesUseCase,
        super(const RepositoryInitial()) {
    searchRepositories('flutter in:name');
  }

  Timer? _debounceTimer;
  String _currentQuery = 'flutter in:name';
  int _currentPage = 1;
  List<RepositoryEntity> _allRepositories = [];
  bool _isRateLimited = false;

  Future<void> searchRepositories(String query) async {
    debugPrint('Search triggered with query: $query');

    _debounceTimer?.cancel();

    if (_isRateLimited && query == _currentQuery) {
      debugPrint('Rate limited - skipping API call');
      return;
    }

    if (query != _currentQuery) {
      _currentQuery = query;
      _currentPage = 1;
      _allRepositories.clear();
      _isRateLimited = false;
      state = const RepositoryLoading();
      debugPrint('Emitted RepositoryLoading state');
    } else if (_allRepositories.isEmpty && !_isRateLimited) {
      state = const RepositoryLoading();
      debugPrint('Emitted RepositoryLoading state (empty repositories)');
    }

    try {
      debugPrint('Making API call with query: $_currentQuery, page: $_currentPage');
      final params = SearchRepositoriesParams(
        query: _currentQuery,
        page: _currentPage,
        perPage: 20,
      );

      final failureOrRepositories = await _searchRepositoriesUseCase(params);

      debugPrint('API call completed');

      failureOrRepositories.fold(
        (failure) {
          debugPrint('API call failed: ${_mapFailureToMessage(failure)}');

          if (_mapFailureToMessage(failure).contains('rate limit')) {
            _isRateLimited = true;
            debugPrint('Rate limit detected - blocking further API calls');
          }

          state = RepositoryError(_mapFailureToMessage(failure));
        },
        (searchResult) {
          debugPrint('API call successful: Found ${searchResult.items.length} items');
          _isRateLimited = false;

          if (_currentPage == 1) {
            _allRepositories = searchResult.items;
          } else {
            _allRepositories.addAll(searchResult.items);
          }

          state = RepositoryLoaded(
            repositories: _allRepositories,
            hasReachedMax: searchResult.items.length < 20,
            isFromCache: false,
          );
          debugPrint('Emitted RepositoryLoaded with ${_allRepositories.length} total repositories');
        },
      );
    } catch (e) {
      debugPrint('Unexpected error: $e');
      state = RepositoryError('Unexpected error: $e');
    }
  }

  Future<void> loadMoreRepositories() async {
    final currentState = state;
    if (currentState is RepositoryLoaded && !currentState.hasReachedMax && !_isRateLimited) {
      _currentPage++;
      state = currentState.copyWith(isLoadingMore: true);

      final params = SearchRepositoriesParams(
        query: _currentQuery,
        page: _currentPage,
        perPage: 20,
      );

      final failureOrRepositories = await _searchRepositoriesUseCase(params);

      failureOrRepositories.fold(
        (failure) {
          _currentPage--;
          state = currentState.copyWith(
            isLoadingMore: false,
            error: _mapFailureToMessage(failure),
          );
        },
        (searchResult) {
          _allRepositories.addAll(searchResult.items);
          state = RepositoryLoaded(
            repositories: _allRepositories,
            hasReachedMax: searchResult.items.length < 20,
            isFromCache: false,
          );
        },
      );
    }
  }

  Future<void> refreshRepositories() async {
    debugPrint('Refresh triggered - fetching fresh data');
    _currentPage = 1;
    _allRepositories.clear();
    state = const RepositoryLoading();

    try {
      final params = RefreshRepositoriesParams(
        query: _currentQuery,
        page: _currentPage,
        perPage: 20,
      );

      final failureOrRepositories = await _refreshRepositoriesUseCase(params);

      failureOrRepositories.fold(
        (failure) {
          debugPrint('Refresh failed: ${_mapFailureToMessage(failure)}');

          if (_mapFailureToMessage(failure).contains('rate limit')) {
            _isRateLimited = true;
            debugPrint('Rate limit detected during refresh');
          }

          state = RepositoryError(_mapFailureToMessage(failure));
        },
        (searchResult) {
          debugPrint('Refresh successful: Got ${searchResult.items.length} fresh items');
          _isRateLimited = false;
          _allRepositories = searchResult.items;
          state = RepositoryLoaded(
            repositories: _allRepositories,
            hasReachedMax: searchResult.items.length < 20,
            isFromCache: false,
          );
        },
      );
    } catch (e) {
      debugPrint('Refresh error: $e');
      state = RepositoryError('Refresh failed: $e');
    }
  }

  Future<void> loadCachedRepositories() async {
    debugPrint('Loading all cached repositories');
    state = const RepositoryLoading();

    try {
      final failureOrRepositories = await _getCachedRepositoriesUseCase(const NoParams());

      failureOrRepositories.fold(
        (failure) {
          debugPrint('Failed to load cached repositories: ${_mapFailureToMessage(failure)}');
          state = RepositoryError(_mapFailureToMessage(failure));
        },
        (searchResult) {
          debugPrint('Loaded ${searchResult.items.length} cached repositories');
          _allRepositories = searchResult.items;
          state = RepositoryLoaded(
            repositories: _allRepositories,
            hasReachedMax: true,
            isFromCache: true,
          );
        },
      );
    } catch (e) {
      debugPrint('Error loading cached repositories: $e');
      state = RepositoryError('Failed to load cached data: $e');
    }
  }

  String _mapFailureToMessage(Failure failure) {
    return switch (failure) {
      ServerFailure() => failure.message,
      CacheFailure() => failure.message,
      NetworkFailure() => failure.message,
      _ => 'Unexpected error',
    };
  }
}

final repositoryProvider = StateNotifierProvider<RepositoryNotifier, RepositoryState>(
  (ref) => RepositoryNotifier(
    searchRepositoriesUseCase: sl<SearchRepositoriesUseCase>(),
    refreshRepositoriesUseCase: sl<RefreshRepositoriesUseCase>(),
    getCachedRepositoriesUseCase: sl<GetCachedRepositoriesUseCase>(),
  ),
);

final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

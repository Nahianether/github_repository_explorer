import '../../domain/entities/repository_entity.dart';

sealed class RepositoryState {
  const RepositoryState();
}

class RepositoryInitial extends RepositoryState {
  const RepositoryInitial();
}

class RepositoryLoading extends RepositoryState {
  const RepositoryLoading();
}

class RepositoryLoaded extends RepositoryState {
  final List<RepositoryEntity> repositories;
  final bool hasReachedMax;
  final bool isFromCache;
  final bool isLoadingMore;
  final String? error;

  const RepositoryLoaded({
    required this.repositories,
    this.hasReachedMax = false,
    this.isFromCache = false,
    this.isLoadingMore = false,
    this.error,
  });

  RepositoryLoaded copyWith({
    List<RepositoryEntity>? repositories,
    bool? hasReachedMax,
    bool? isFromCache,
    bool? isLoadingMore,
    String? error,
  }) {
    return RepositoryLoaded(
      repositories: repositories ?? this.repositories,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isFromCache: isFromCache ?? this.isFromCache,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
    );
  }
}

class RepositoryError extends RepositoryState {
  final String message;

  const RepositoryError(this.message);
}
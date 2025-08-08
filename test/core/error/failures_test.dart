import 'package:flutter_test/flutter_test.dart';
import 'package:github_repository_explorer/core/error/failures.dart';

void main() {
  group('ServerFailure', () {
    const tServerFailure = ServerFailure('Server error message');

    test('should be a subclass of Failure', () {
      expect(tServerFailure, isA<Failure>());
    });

    test('should have correct props for equality comparison', () {
      expect(tServerFailure.props, ['Server error message']);
    });

    test('should be equal when messages are the same', () {
      const tServerFailure1 = ServerFailure('Same message');
      const tServerFailure2 = ServerFailure('Same message');
      
      expect(tServerFailure1, equals(tServerFailure2));
    });

    test('should not be equal when messages are different', () {
      const tServerFailure1 = ServerFailure('Message 1');
      const tServerFailure2 = ServerFailure('Message 2');
      
      expect(tServerFailure1, isNot(equals(tServerFailure2)));
    });
  });

  group('CacheFailure', () {
    const tCacheFailure = CacheFailure('Cache error message');

    test('should be a subclass of Failure', () {
      expect(tCacheFailure, isA<Failure>());
    });

    test('should have correct props for equality comparison', () {
      expect(tCacheFailure.props, ['Cache error message']);
    });

    test('should be equal when messages are the same', () {
      const tCacheFailure1 = CacheFailure('Same cache message');
      const tCacheFailure2 = CacheFailure('Same cache message');
      
      expect(tCacheFailure1, equals(tCacheFailure2));
    });
  });

  group('NetworkFailure', () {
    const tNetworkFailure = NetworkFailure('Network error message');

    test('should be a subclass of Failure', () {
      expect(tNetworkFailure, isA<Failure>());
    });

    test('should have correct props for equality comparison', () {
      expect(tNetworkFailure.props, ['Network error message']);
    });

    test('should be equal when messages are the same', () {
      const tNetworkFailure1 = NetworkFailure('Same network message');
      const tNetworkFailure2 = NetworkFailure('Same network message');
      
      expect(tNetworkFailure1, equals(tNetworkFailure2));
    });
  });

  group('Different Failure Types', () {
    test('should not be equal even with same message', () {
      const tServerFailure = ServerFailure('Same message');
      const tCacheFailure = CacheFailure('Same message');
      const tNetworkFailure = NetworkFailure('Same message');
      
      expect(tServerFailure, isNot(equals(tCacheFailure)));
      expect(tServerFailure, isNot(equals(tNetworkFailure)));
      expect(tCacheFailure, isNot(equals(tNetworkFailure)));
    });
  });
}
// ✅ GOOD — demonstrates what the rule does and does NOT check.
//
// Only the FIRST PUBLIC class in a file is checked:
//   * Private classes (names starting with `_`) are skipped entirely, so
//     `_TokenCache` below does not need to match the file name.
//   * Public classes declared AFTER the first one are not checked either,
//     so `AuthException` is allowed.
//
// The first public class here is `AuthRepository`, which matches
// `auth_repository.dart`, so the file passes.
class _TokenCache {
  const _TokenCache(this.token);

  final String token;
}

class AuthRepository {
  _TokenCache? _cached;

  String? get token => _cached?.token;
}

class AuthException implements Exception {}

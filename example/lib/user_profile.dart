// ✅ GOOD
//
// The file is named `user_profile.dart` and its first public class is
// `UserProfile`. Matching is case-insensitive and ignores underscores
// (`user_profile` -> `userprofile` == `UserProfile`.toLowerCase()), so this
// file passes the lint with no warnings.
class UserProfile {
  const UserProfile(this.name);

  final String name;
}

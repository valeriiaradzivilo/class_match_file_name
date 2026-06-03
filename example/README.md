# class_match_file_name — example

This example demonstrates how the `class_match_file_name` lint rule behaves.

The rule looks at the **first public class** in each Dart file and reports an
error when its name doesn't match the file name. Matching is case-insensitive
and underscores in the file name are ignored, so `user_profile.dart` matches a
`UserProfile` class.

## Files

| File | Result | Why |
| --- | --- | --- |
| [`lib/user_profile.dart`](lib/user_profile.dart) | ✅ passes | `UserProfile` matches `user_profile.dart` |
| [`lib/order_service.dart`](lib/order_service.dart) | ❌ error | first public class is `PaymentProcessor`, not `OrderService` |
| [`lib/auth_repository.dart`](lib/auth_repository.dart) | ✅ passes | private and non-first classes are ignored; `AuthRepository` matches |

## Try it

From this `example/` directory:

```sh
dart pub get
dart run custom_lint
```

`lib/order_service.dart` is intentionally mismatched and annotated with a
`// expect_lint: class_match_file_name` comment, so `custom_lint` verifies the
rule fires exactly there and the run **passes** with no issues. Remove that
comment to see the raw error surface instead:

```
lib/order_service.dart:12:7 • Class name should match file name • class_match_file_name • ERROR
```

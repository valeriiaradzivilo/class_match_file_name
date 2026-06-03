/// A [custom_lint](https://pub.dev/packages/custom_lint) plugin that enforces
/// that the first public class in a Dart file shares its name with the file.
///
/// For example, a file named `my_class.dart` is expected to declare a public
/// class named `MyClass`. Matching is case-insensitive and underscores in the
/// file name are ignored, so `user_profile.dart` matches `UserProfile`.
///
/// To use it, add this package as a `dev_dependency`, enable the
/// `custom_lint` analyzer plugin, and run `dart run custom_lint`. See the
/// `example/` directory for a runnable demonstration of passing and failing
/// files.
library;

import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'src/class_match_file_name.dart';

/// Entry point invoked automatically by `custom_lint` to register this
/// package's lint rules.
///
/// Returns the [PluginBase] that exposes the `class_match_file_name` rule.
PluginBase createPlugin() => _MyCustomLint();

class _MyCustomLint extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    return <LintRule>[
      const ClassMatchFileName(),
    ];
  }
}

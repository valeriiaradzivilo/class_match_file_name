import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'src/class_match_file_name.dart';

/// Custom lint plugin that checks if the class name matches the file name
PluginBase createPlugin() => _MyCustomLint();

class _MyCustomLint extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    return <LintRule>[
      const ClassMatchFileName(),
    ];
  }
}

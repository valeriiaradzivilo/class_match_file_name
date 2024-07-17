import 'package:class_match_file_name/lint/class_match_file_name.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

// Entrypoint of plugin
PluginBase createPlugin() => _Lint();

// The class listing all the [LintRule]s and [Assist]s defined by our plugin
class _Lint extends PluginBase {
  // Lint rules
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [const ClassMatchFileName()];

  // Assists
  @override
  List<Assist> getAssists() => [];
}

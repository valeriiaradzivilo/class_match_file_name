import 'dart:io';

import 'package:class_match_file_name/class_match_file_name.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:test/test.dart';

void main() {
  late DartLintRule rule;

  setUp(() {
    final plugin = createPlugin();
    // ignore: invalid_use_of_internal_member
    final rules = plugin.getLintRules(CustomLintConfigs.empty);
    rule = rules.whereType<DartLintRule>().single;
  });

  /// Runs the rule against a fixture file and returns the number of lints.
  Future<int> lintCount(String fixture) async {
    final file = File('test/fixtures/$fixture').absolute;
    final errors = await rule.testAnalyzeAndRun(file);
    return errors.length;
  }

  group('class_match_file_name', () {
    test('exposes a single rule with the expected code', () {
      expect(rule.code.name, 'class_match_file_name');
    });

    test('no lint when the file name matches the first public class', () async {
      expect(await lintCount('correct_name.dart'), 0);
    });

    test('reports a lint when the first public class does not match', () async {
      expect(await lintCount('wrong_name.dart'), 1);
    });

    test('skips leading private classes', () async {
      expect(await lintCount('skips_private_classes.dart'), 0);
    });

    test('checks only the first public class', () async {
      expect(await lintCount('only_first_public.dart'), 0);
    });
  });
}

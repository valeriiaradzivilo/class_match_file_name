// import 'dart:io';

// import 'package:class_match_file_name/class_match_file_name.dart';
// import 'package:custom_lint_builder/custom_lint_builder.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   final files = getFiles();

//   group('ClassMatchFileLint', () {
//     test('Check ClassMatchFileLint', () async {
//       final plugin = createPlugin();
//       final lints = plugin.getLintRules(CustomLintConfigs.empty);
//       for (final lint in lints) {
//         if (!(lint is DartLintRule)) return;
//         for (final f in files) {
//           final errors = await lint.testAnalyzeAndRun(File.fromUri(f.uri));
//           final expected = getExpectedErrorsCount(File.fromUri(f.uri), lint.code.name);
//           expect(errors.length, expected, reason: 'Expected $expected errors for ${f}');
//         }
//       }
//     });
//   });
// }

// List<File> getFiles() {
//   final currentDir = Directory.current.uri;
//   final libDir = Directory.fromUri(Uri.parse('${currentDir}example/lib'));
//   final testDir = Directory.fromUri(Uri.parse('${currentDir}example/test'));

//   final libFiles = libDir
//       .listSync(recursive: true)
//       .where((element) => element is File && element.path.endsWith('.dart'))
//       .cast<File>();

//   final testFiles = testDir
//       .listSync(recursive: true)
//       .where((element) => element is File && element.path.endsWith('.dart'))
//       .cast<File>();

//   return [...libFiles, ...testFiles];
// }

// int getExpectedErrorsCount(File file, String code) {
//   final content = file.readAsStringSync();
//   final lines = content.split('\n');
//   final errors = lines.where(
//     (element) => element.contains('// expect_lint: $code'),
//   );
//   return errors.length;
// }

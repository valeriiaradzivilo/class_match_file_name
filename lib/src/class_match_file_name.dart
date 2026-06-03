import 'dart:io';

// ignore: undefined_hidden_name
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer/src/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Lint rule that reports when the first public class in a file does not match
/// the file name.
///
/// Only the **first public class** in a file is checked:
///   * Private classes (names starting with `_`) are skipped entirely.
///   * Public classes declared after the first one are not checked.
///
/// The comparison is case-insensitive and ignores underscores in the file
/// name, so `user_profile.dart` matches a `UserProfile` class while
/// `order_service.dart` declaring `PaymentProcessor` is reported as an error.
class ClassMatchFileName extends DartLintRule {
  // Lint rule metadata
  static const LintCode _code = LintCode(
    name: 'class_match_file_name',
    problemMessage: 'Class name should match file name',
    errorSeverity: ErrorSeverity.ERROR,
  );

  const ClassMatchFileName() : super(code: _code);

  // Possible fixes for the lint error go here
  @override
  List<Fix> getFixes() => <Fix>[
        // _ReplaceFileName()
      ];

  // `run` is where you analyze a file and report lint errors
  // Invoked on a file automatically
  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    bool firstPublicClassChecked = false;
    // A callback that runs on every class declaration in a file
    context.registry.addClassDeclaration((ClassDeclaration node) {
      if (firstPublicClassChecked) return;

      // Get the class name
      final String className = node.name.lexeme;

      // Private classes are skipped; only the first public class is checked.
      if (className.startsWith('_')) return;

      firstPublicClassChecked = true;

      // Get the file name
      final String fileName = _fileName(resolver.source.shortName);
      // Check if the class name matches the file name
      if (fileName.replaceAll('_', '') != className.toLowerCase()) {
        // Report a lint error on the class name token
        reporter.atToken(node.name, _code);
      }
    });
  }
}

/// Fix that replaces class name with file string
// Removed until the fix is implemented
// ignore: unused_element
class _ReplaceFileName extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    // final String fileName = _fileName(resolver.source.shortName);

    // Create a `ChangeBuilder` instance to do file operations with an action
    final ChangeBuilder changeBuilder =
        reporter.createChangeBuilder(message: 'Change file name', priority: 1);

    // Use the `changeBuilder` to make Dart file edits

    changeBuilder.addDartFileEdit((DartFileEditBuilder builder) {
      context.registry.addClassDeclaration((ClassDeclaration node) {
        // `return` if the current class declaration is not where the lint
        // error has appeared
        if (!analysisError.sourceRange.intersects(node.sourceRange)) return;

        final String newFileName = _camelCaseToSnakeCase(node.name.lexeme);

        builder.addReplacement(SourceRange(0, 1), (_) {
          // final filePath = resolver.source.fullName;
          // print('Replacing file name: ${filePath} with $newFileName');
          _renameFile(resolver.source.fullName, newFileName);
        });
      });
    });
  }
}

String _camelCaseToSnakeCase(String text) {
  return text
      .split('')
      .map((String char) => char == char.toUpperCase() ? '_$char' : char)
      .join('')
      .toLowerCase()
      .substring(1);
}

String _fileName(String path) => path.replaceAll('.dart', '');

Future<void> _renameFile(String oldPath, String newFileName) async {
  File file = File(oldPath);
  try {
    final folder =
        oldPath.split('/').sublist(0, oldPath.split('/').length - 1).join('/') +
            '/';
    await file.rename(folder + newFileName + '.dart');
    // print('File renamed successfully from $oldPath to $newFileName');
  } catch (e) {
    // print('Failed to rename file: $e');
  }
}

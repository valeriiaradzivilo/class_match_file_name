// Lint rule to have class name match file name
import 'dart:io';

import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:flutter/widgets.dart';

class ClassMatchFileNameRule extends DartLintRule with TestableDartRule {
  const ClassMatchFileNameRule() : super(code: _code);

  // Lint rule metadata
  static const _code = LintCode(
    name: 'class_match_file_name_rule',
    problemMessage: 'Class name should match file name',
  );

  // `run` is where you analyze a file and report lint errors
  // Invoked on a file automatically
  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // A call back fn that runs on all variable declarations in a file
    context.registry.addClassDeclaration((node) {
      // Get the file name
      final fileName = resolver.source.shortName;
      // Get the class name
      final className = node.name.stringValue;

      final element = node.declaredElement;

      if (element == null) return;

      print('Checking class: $className against file: $fileName');
      // Check if the class name matches the file name
      if (fileName != className) {
        // Report a lint error
        reporter.reportErrorForElement(_code, element);
      }
    });
  }

  // Possible fixes for the lint error go here
  @override
  List<Fix> getFixes() => [_ReplaceClassName()];

  @visibleForTesting
  @override
  Future<List<AnalysisError>> testFile(File file) {
    // expose this method for testing
    // ignore: invalid_use_of_visible_for_testing_member
    return super.testAnalyzeAndRun(file);
  }
}

// Fix that replaces class name with file string
class _ReplaceClassName extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    // Callback fn that runs on every variable declaration in a file
    context.registry.addClassDeclaration((node) {
      final element = node.declaredElement;

      final fileName = resolver.source.shortName;

      // `return` if the current class declaration is not where the lint
      // error has appeared
      if (element == null || !analysisError.sourceRange.intersects(node.sourceRange)) return;

      // Create a `ChangeBuilder` instance to do file operations with an action
      final changeBuilder = reporter.createChangeBuilder(
        message: 'Change class name',
        priority: 1,
      );
      // Use the `changeBuilder` to make Dart file edits
      changeBuilder.addDartFileEdit((builder) {
        // Use the `builder` to replace the variable name
        builder.addSimpleReplacement(
          SourceRange(element.nameOffset, element.nameLength),
          // the string to be replaced instead of class name
          element.name.replaceFirst(
            element.displayName,
            fileName,
          ),
        );
      });
    });
  }
}

/// an interface to allow testing of [DartLintRule]
@visibleForTesting
mixin TestableDartRule on DartLintRule {
  /// run the lint rule on a file
  @visibleForTesting
  Future<List<AnalysisError>> testFile(File file);
}

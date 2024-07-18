import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer/src/dart/ast/ast.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class ClassMatchFileName extends DartLintRule  {
  const ClassMatchFileName() : super(code: _code);

  // Lint rule metadata
  static const LintCode _code = LintCode(
    name: 'class_match_file_name',
    problemMessage: 'Class name should match file name',
    errorSeverity: ErrorSeverity.ERROR,
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
    context.registry.addClassDeclaration((ClassDeclaration node) {
      // Get the file name
      final String fileName = _fileName(resolver.source.shortName);
      // Get the class name
      final String? className = node.name.lexeme;

      final ClassElement? element = node.declaredElement;

      if (element == null || className == null) return;

      print('Checking class: $className against file: $fileName');
      // Check if the class name matches the file name
      if (fileName.replaceAll('_', '') != className.toLowerCase()) {
        // Report a lint error
        // ignore: deprecated_member_use
        reporter.reportErrorForElement(_code, element);
      }
    });
  }

  // Possible fixes for the lint error go here
  @override
  List<Fix> getFixes() => <Fix>[_ReplaceClassName()];

  
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
    context.registry.addClassDeclaration((ClassDeclaration node) {
      final ClassElement? element = node.declaredElement;

      final String fileName =_fileName(resolver.source.shortName);

      // `return` if the current class declaration is not where the lint
      // error has appeared
      if (element == null || !analysisError.sourceRange.intersects(node.sourceRange)) return;

      // Create a `ChangeBuilder` instance to do file operations with an action
      final ChangeBuilder changeBuilder = reporter.createChangeBuilder(
        message: 'Change class name',
        priority: 1,
      );
      // Use the `changeBuilder` to make Dart file edits
      changeBuilder.addDartFileEdit((DartFileEditBuilder builder) {
        // Use the `builder` to replace the variable name
        builder.addSimpleReplacement(
          SourceRange(element.nameOffset, element.nameLength),
          // the string to be replaced instead of class name
          element.name.replaceFirst(
            element.displayName,
            _snakeCaseToCamelCase(fileName),
          ),
        );
      });
    });
  }
}


String _snakeCaseToCamelCase(String text) {
  return text.split('_').asMap().map((int index, String word) {
    if (index == 0) return MapEntry<int, String>(index, word.toLowerCase());
    return MapEntry<int, String>(index, word[0].toUpperCase() + word.substring(1).toLowerCase());
  }).values.join('');
}

String _fileName(String path)=> path.replaceAll('.dart', '');


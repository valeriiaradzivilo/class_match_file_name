# Class Match File Name Linter

## What for?

This package provides a custom linter rule to ensure that the file name and the class name within it are consistent. This can be particularly useful during refactoring, as it helps maintain a clear and organized codebase by enforcing naming conventions. By automatically checking and suggesting fixes for mismatched names, this linter aids in reducing errors and improving code readability.

## How to Use

To use the Class Match File Name Linter in your project, follow these steps:

1. **Add the Dependency**: Add the linter package to your `pubspec.yaml` file.
    ```yaml
    dev_dependencies:
      flutter_lints:
      class_match_file_name:
    ```

2. **Create a Custom Lint Configuration**: Create a `custom_lint.yaml` file in the root of your project and add the linter rule.
    ```yaml
    include: package:flutter_lints/flutter.yaml

    analyzer:
    exclude:
        - generated/**
    plugins:
        - custom_lint

    custom_lint:
    class_match_file_name: true
    ```

3. **Run the Linter**: Use the following command to run the linter on your project.
    ```sh
    dart run custom_lint
    ```

### Example

Suppose you have a Dart file named `example_class.dart` with the following content:
```dart
class ExampleClass {
  // Class implementation
}
```

If the file name does not match the class name, the linter will report an error and suggest renaming the file to example_class.dart to match the class name ExampleClass.

For instance, if the file is named example.dart instead of example_class.dart, the linter will produce an error indicating that the class name should match the file name.

## Fixing the issue

To fix the issue, you can rename the file to example_class.dart to match the class name. Or you can rename the class.

## Contribution
Contributions are welcome! If you have any suggestions, bug reports, or feature requests, please open an issue or submit a pull request on GitHub. I appreciate your help in improving this project.

## Made by a Ukrainian
This project is proudly made by a Ukrainian developer. Your support and feedback are greatly appreciated.
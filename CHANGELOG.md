## 1.0.0

* Migrated to `analyzer` 8 and `custom_lint_builder` 0.8; widened dependency constraints to track the latest supported versions
* Updated the rule to the non-deprecated `Diagnostic` / `DiagnosticReporter` / `DiagnosticSeverity` analyzer API
* Removed the `custom_lint` plugin activation from the package's own `analysis_options.yaml` so `dart analyze` / pub.dev can resolve and analyze the package
* Stopped publishing checked-in `build/` artifacts


## 0.2.3

* Migrated to `analyzer` 7 and `custom_lint_builder` 0.7 for compatibility with current Dart SDKs
* Updated the rule to use the non-deprecated analyzer reporting API
* Removed the Flutter dependency — the package is now pure Dart (tests use `package:test`)
* Reworked the `example/` with clear passing and failing cases
* Added unit tests and dartdoc comments for the public API


## 0.2.2

* Remove logs


## 0.2.1

* Fixed error in logs
* Removed prints from code


## 0.2.0

* Updated code and packages


## 0.1.4

* Fixed LintCode issue


## 0.1.3

* Removed Quick fix until it is fixed


## 0.1.2

* Fixed first class check


## 0.1.1

* Added check for the first class in file (the linter should only apply to the first class)


## 0.1.0

* Linter is working
* Quick fix is in progress


## 0.0.1

* Initial release without anything just to check publishing
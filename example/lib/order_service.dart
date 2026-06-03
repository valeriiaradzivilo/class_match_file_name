// ❌ BAD
//
// The file is named `order_service.dart` but its first public class is
// `PaymentProcessor`. The linter reports an error on the class:
//
//     Class name should match file name
//
// Fix it either by renaming the class to `OrderService`, or by renaming the
// file to `payment_processor.dart`.

// expect_lint: class_match_file_name
class PaymentProcessor {
  void process() {}
}

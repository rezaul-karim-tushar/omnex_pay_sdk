import 'package:omnex_pay_sdk/omnex_pay_sdk.dart';
import 'package:test/test.dart';

void main() {
  group('OmnexPaySDK Tests', () {
    setUp(() {
      // Reset SDK instance for each test
      OmnexPaySDK.instance.initialize(
        apiKey: 'test_api_key',
        environment: 'sandbox',
      );
    });

    test('SDK should be initialized after calling initialize()', () {
      expect(OmnexPaySDK.instance.isInitialized, isTrue);
      expect(OmnexPaySDK.instance.isConnected, isTrue);
    });

    test('SDK should return correct environment', () {
      expect(OmnexPaySDK.instance.environment, equals('sandbox'));
    });

    test('SDK should mask API key for security', () {
      expect(OmnexPaySDK.instance.apiKey, equals('***'));
    });
  });
}

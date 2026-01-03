// Core SDK classes and utilities for Omnex Pay SDK.

/// Main SDK class for Omnex Pay SDK initialization and configuration.
class OmnexPaySDK {
  static OmnexPaySDK? _instance;
  bool _isInitialized = false;
  String? _apiKey;
  String? _environment;

  /// Private constructor for singleton pattern.
  OmnexPaySDK._();

  /// Get the singleton instance of OmnexPaySDK.
  static OmnexPaySDK get instance {
    _instance ??= OmnexPaySDK._();
    return _instance!;
  }

  /// Initialize the SDK with API key and environment.
  /// 
  /// [apiKey] - Your Omnex Pay API key
  /// [environment] - Environment: 'sandbox' or 'production'
  void initialize({
    required String apiKey,
    String environment = 'sandbox',
  }) {
    _apiKey = apiKey;
    _environment = environment;
    _isInitialized = true;
  }

  /// Check if the SDK is initialized.
  bool get isInitialized => _isInitialized;

  /// Check if the SDK is connected and ready to use.
  bool get isConnected => _isInitialized && _apiKey != null;

  /// Get the current environment.
  String? get environment => _environment;

  /// Get the API key (returns null for security).
  String? get apiKey => _apiKey != null ? '***' : null;
}

/// Legacy class for backward compatibility.
/// 
/// @deprecated Use [OmnexPaySDK] instead.
@Deprecated('Use OmnexPaySDK.instance instead')
class Awesome {
  bool get isAwesome => OmnexPaySDK.instance.isConnected;
}

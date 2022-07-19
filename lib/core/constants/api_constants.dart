class ApiEndpoints {
  static bool isDebugging = true;

  static const String _apiBaseUrl = 'https://shopicruit.myshopify.com/';

  //! Endpoints
  static const String _shopifyProductsEndpoint =
      'admin/products.json?access_token=c32313df0d0ef512ca64d5b336a0d7c6';

  //! Full Endpoint Url
  static const String shopifyProductsEndpointUrl =
      _apiBaseUrl + _shopifyProductsEndpoint;
}

import 'package:http/http.dart' as http;

class WebServiceResponse {
  final String body;

  final Map<String, String> headers;

  final int statusCode;

  bool get hasError => statusCode > 399;

  WebServiceResponse({this.body, this.headers, this.statusCode});

  WebServiceResponse.emptySuccess()
      : body = '{}',
        headers = {},
        statusCode = 200;

  WebServiceResponse.fromHttpResponse(http.Response response)
      : body = response.body,
        headers = response.headers,
        statusCode = response.statusCode;
}

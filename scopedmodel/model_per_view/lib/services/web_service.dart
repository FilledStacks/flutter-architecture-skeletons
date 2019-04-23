import 'dart:io';
import 'dart:async';
import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:model_per_view/models/webservice_response.dart';
import 'package:model_per_view/models/list_item.dart';

enum HttpRequest { Get, Post, Head, Update }

const int DefaultTimeoutInSeconds = 30;

/// This class is a wrapper for the http service that specifically points to your
/// service. It has the following basic functionality
///
///   -  Calls to your endpoints, serializes into a response object containing your body
///   -  Has a timeout functionality that will cancel a request after a while (until support in http package arrives)
///
class WebService {
  static WebService _instance;

  static WebService getInstance() {
    if (_instance == null) {
      _instance = WebService();
    }

    return _instance;
  }

  /// Add headers here that you would like to be added to all your
  /// requests.
  Map<String, String> _defaultHeaders = {};

  // NOTE: Replace endpoint with your api endpoint
  String apiEndpoint = "https://www.google.com";

  // NOTE: Add or remove endpoints required
  String loginEndpoint = "/login";
  String signupEndpoint = "/signup";

  Future<WebServiceResponse> login(
      {@required String username, @required String password}) async {
    /*    
    // Example of how to use the getUri and the performHttpRequest function
    // use this to build up your own service that talks directly to your api.
    var uri = _getUri(loginEndpoint,
        parameters: {'username': username, 'password': password}).toString();

    var response = await _performHttpRequest(
      verb: HttpRequest.Get,
      uri: uri);

    return WebServiceResponse.fromHttpResponse(response);
      */

    // Delayed function to emulate a real api request.
    await Future.delayed(Duration(seconds: 2));

    return WebServiceResponse.emptySuccess();
  }

  Future<WebServiceResponse> signup(
      {@required String username, @required String password}) async {
    /*    
    // Example of how to use the getUri and the performHttpRequest function
    // use this to build up your own service that talks directly to your api.
    var uri = _getUri(loginEndpoint,
        parameters: {'username': username, 'password': password}).toString();

    var response = await _performHttpRequest(
      verb: HttpRequest.Get,
      uri: uri);

    return WebServiceResponse.fromHttpResponse(response);
      */

    // Delayed function to emulate a real api request.
    await Future.delayed(Duration(seconds: 2));

    return WebServiceResponse.emptySuccess();
  }

  Future<List<ListItem>> fetchData() async {
    // Delayed function to emulate a real api request.
    await Future.delayed(Duration(seconds: 2));

    return List<ListItem>.generate(
        10,
        (index) => ListItem(
            title: 'List Item $index',
            description:
                '$index This is a list  description')); // Return fake data to show listing ui
    // return null; // Return null to get built in error display and UI to retry
    // return List<ListItem>(); // Return empty list to get built in error list message
  }

  Future<http.Response> _performHttpRequest(
      {@required HttpRequest verb,
      @required String uri,
      String body,
      int timeOutInSeconds = DefaultTimeoutInSeconds}) async {
    var requestHeaders = Map<String, String>.from(_defaultHeaders);

    // NOTE: Adding additional headers dynamically
    // here you can check the conditions that needs to be true
    // and add the headers you want to add
    /*
    // EXAMPLE
    if (requiresBearerToken) {
      requestHeaders.addAll({'Authorization': 'Bearer ${_bearerToken}'});
    }
    */

    http.Response response;
    try {
      bool cancelled = false;
      var request = CancelableOperation.fromFuture(_getHttpRequestForVerb(
          verb: verb, uri: uri, body: body, requestHeaders: requestHeaders));

      // The Http library I like to use doesn't have timeOut in it yet. So until it's build in I'll use my timeout logic below. 
      // You can replace it with the dart httpClient if you'd like.
      var cancelTimer = Timer(Duration(seconds: timeOutInSeconds), () {
        _logRequestData(
            title: 'Cancel Request after $timeOutInSeconds s',
            verb: verb,
            uri: uri,
            body: body,
            requestHeaders: requestHeaders);

        cancelled = true;
        request.cancel();
      });
      response = await request.valueOrCancellation();
      cancelTimer.cancel();

      if (cancelled == true) {
        print('Request cancelled');
        throw new TimeoutException('Request cancelled');
      }
    } on TimeoutException catch (e) {
      response = http.Response('Timeout occurred: ${e.message}', 602);
    } on SocketException catch (e) {
      response =
          http.Response('No network or network failure: ${e.message}', 602);
    } catch (e) {
      response = http.Response('General exception: ${e.message}', 602);
    }

    if (response != null && response.statusCode == 401) {
      return http.Response('Authorization required', 601);
    }

    return response;
  }

  Future<http.Response> _getHttpRequestForVerb(
      {HttpRequest verb,
      String uri,
      String body,
      Map<String, String> requestHeaders}) {
    _logRequestData(
        title: 'Start Request',
        verb: verb,
        uri: uri,
        body: body,
        requestHeaders: requestHeaders);

    if (verb == HttpRequest.Post) {
      return http.post(uri, body: body, headers: requestHeaders);
    }
    if (verb == HttpRequest.Get) {
      return http.get(uri, headers: requestHeaders);
    }
    if (verb == HttpRequest.Head) {
      return http.head(uri, headers: requestHeaders);
    }

    return Future.error('No verb defined for $verb');
  }

  Uri _getUri(String apiPath, {Map<String, String> parameters}) {
    if (parameters == null) {
      parameters = Map<String, String>();
    }

    return Uri.https(apiEndpoint, apiPath, parameters);
  }

  void _logRequestData(
      {String title,
      HttpRequest verb,
      String uri,
      String body,
      Map<String, String> requestHeaders}) {
    print(
        '======= $title ======= \nVerb: ${verb.toString()}\nUrl: $uri,\nBody: $body\nHeaders: $requestHeaders \n===================\n');
  }
}

part of neo4dart;

/**
 * A Rest HttpRequest definition
 */
class RestRequest {
  String _method;
  String _url;
  Object _body;
  
  RestRequest(this._url, this._method, [this._body]);
  
  String get method => _method;
  String get url => _url;
  Object get body => _body;
}

/**
 * A Rest call error
 */
class RestException {
  static RestException NO_RESPONSE = new RestException._internal(0, {'message' : 'No server response'});
  
  int _statusCode;
  Map<String, Object> _context;
  
  int get statusCode => _statusCode;
  String get message => _context['message'];
  String get stackTrace => _context['stacktrace'];
  
  factory RestException.noResponse() => NO_RESPONSE;
  
  RestException.fromContext(this._statusCode, String context) {
    _context = (context != null && context.isNotEmpty) ? JSON.decode(context) : new Map() ;
  }
  
  RestException._internal(this._statusCode, this._context);
}
  
/**
 * A function which send a Http request
 */
const String ACCEPT_JSON = "application/json; charset=UTF-8";
const String CONTENT_TYPE_JSON = "application/json";

final _SEND_LOGGER = LoggerFactory.getLogger("http");
int requestNum = 0;

Future _send(String url, [String method = "get", Object body]) {
  int r = requestNum++;
  DateTime start = new DateTime.now();
  Completer<String> completer = new Completer();
  HttpClient client = new HttpClient();
  String bodyStr = body != null ? JSON.encode(body) : "";
  _SEND_LOGGER.debug("R${r}: ${method} data on ${url} with body ${bodyStr}");
  client.openUrl(method, Uri.parse(url)).then((HttpClientRequest request) {
    request.headers.set(HttpHeaders.ACCEPT, ACCEPT_JSON);
    if (body != null && method != "get") {
      request.headers.set(HttpHeaders.CONTENT_TYPE, CONTENT_TYPE_JSON);
      //request.contentLength = body.length;
      request.write(bodyStr); 
    }
    return request.close();
  }, onError: (error) {
    completer.completeError(error);
  }).then((HttpClientResponse response) {
    if (response != null) {
      response.transform(UTF8.decoder).toList().then((data) {
        _SEND_LOGGER.debug("R${r}: Received data in ${new DateTime.now().difference(start).inMilliseconds}ms with status ${response.statusCode}: ${data}");
        client.close();
        if (response.statusCode > 300) {
          completer.completeError(new RestException.fromContext(response.statusCode, data.join('')));
        }
        else {
          completer.complete(data != null && data.isNotEmpty ? JSON.decode(data.join('')) : null);
        }
      });
    }
  }, onError: (error) {
    completer.completeError(error);
  });
  return completer.future;
}

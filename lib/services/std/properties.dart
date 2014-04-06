part of neo4dart;

class Properties extends Object with RestRunnable {
  
  String _url;
  
  Properties._fromURL(this._url);
  
  /**
   * Returns the list of all used and deleted properties
   */
  Future<List<String>> getAll({ServiceExecutor executor : null}) {
    Completer<Node> completer = new Completer();
    RestRequest request = new RestRequest(_url, 'GET');
    run(request, executor : executor).then((result) {
      completer.complete(result);
    }, onError: (e) {
      completer.completeError(e);
    });
    return completer.future;
  }
  
}
  
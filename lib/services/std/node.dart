part of neo4dart;


class Labels extends Object with RestRunnable {
  
  String _url;
  
  Labels._fromURL(this._url);
  
  /**
   * Add a new label to this node. Previous labels are kept
   * 
   * Returns nothing
   */
  Future add(String label, {ServiceExecutor executor : null}) {
    return _addLabels(label, 'POST', executor: executor);
  }
  
  /**
   * Add a list of labels. Previous labels are kept
   */
  Future adds(List<String> labels, {ServiceExecutor executor : null}) {
    return _addLabels(labels, 'POST', executor: executor);
  }
  
  /**
   * Set labels. All previous labels are removed
   */
  Future set(List<String> labels, {ServiceExecutor executor : null}) {
    return _addLabels(labels, 'PUT', executor: executor);
  }
  
  /**
   * Remove a label. Other labels are kept
   */
  Future remove(String label, {ServiceExecutor executor : null}) {
    Completer<Node> completer = new Completer();
    RestRequest request = new RestRequest('${_url}/${label}', 'DELETE');
    run(request, executor : executor).then((_) {
      completer.complete();
    }, onError: (e) {
      completer.completeError(e);
    });
    return completer.future;
  }
  
  /**
   * Set a list of labels to this bode. Previous labels are removed
   */
  Future _addLabels(Object labels, String method, {ServiceExecutor executor : null}) {
    Completer<Node> completer = new Completer();
    RestRequest request = new RestRequest(_url, method, labels);
    run(request, executor : executor).then((_) {
      completer.complete();
    }, onError: (e) {
      completer.completeError(e);
    });
    return completer.future;
  }
  
  /**
   * Returns the list of node's labels
   */
  Future<List<String>> get({ServiceExecutor executor : null}) {
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

class Nodes extends Object with HasContext, RestRunnable implements Service  {
  
  String _url;
  
  Nodes(this._url);
  
  Future get(int id, {ServiceExecutor executor : null}) { 
    Completer<Node> completer = new Completer();
    RestRequest request = new RestRequest('${_url}/${id}', 'GET');
    run(request, executor : executor).then((result) {
      completer.complete(new Node.fromJSON(result));
    }, onError: (e) {
      completer.completeError(e);
    });
    return completer.future;
  }
  
  Future create({Map<String, Object> properties, ServiceExecutor executor : null}) {
    Completer<Node> completer = new Completer();
    RestRequest request = new RestRequest("${_url}", 'POST', properties);
    run(request, executor : executor).then((result) {
      completer.complete(new Node.fromJSON(result));
    }, onError: (e) {
      completer.completeError(e);
    });
    return completer.future;
  }
  
  Future delete(int id, {ServiceExecutor executor : null}) {
    Node node = new Node.fromReference('${_url}/${id}');
    return node.delete();
  }

}


/**
 * This class defines a node with its properties.
 */
class Node extends HasProperties  {
  
  static final LOG = LoggerFactory.getLoggerFor(Node);
  RelationShips _relations;
  Labels _labels;
  
  int get id => int.parse((_json['self'] as String).split('/').last);
  
  Node();
  
  Node.fromReference(String reference) : super() {
    _json = new Map();
    _json['self'] = reference;
  }
  
  Node.fromJSON(Map data) {
    _setContextFromJSON(data);
    _relations = new RelationShips.fromJSON(_json);
    _labels = new Labels._fromURL(_json['labels']); 
  }
  
  RelationShips get relations => _relations;
  
  Labels get labels => _labels;
  
  /**
   * Delete the current node. You can create a node using [Node.fromReference] before deleting it.
   * 
   * Return nothing
   */
  Future delete({ServiceExecutor executor : null}) {
    Completer<Node> completer = new Completer();
    RestRequest request = new RestRequest(_json['self'], 'DELETE');
    run(request, executor : executor).then((_) {
      completer.complete();
    }, onError: (e) {
      completer.completeError(e);
    });
    return completer.future;
  }

 
}
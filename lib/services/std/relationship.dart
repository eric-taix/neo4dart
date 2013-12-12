part of neo4dart;

class RelationShipTypes extends Object with RestRunnable {
  String _url;
  
  RelationShipTypes(this._url);
  
  /**
   * Get all relationships' types.
   * If you want to retrieve relationships of a specific types, use the [labels] parameter.
   */
  Future<List<String>> getTypes({ServiceExecutor executor : null}) {
    Completer<Node> completer = new Completer();
    RestRequest request = new RestRequest(_url, 'GET');
    run(request, executor : executor).then((result) {
      completer.complete((result));
    }, onError: (e) {
      completer.completeError(e);
    });
    return completer.future;
  }

}

class RelationShips extends Object with HasContext, RestRunnable {
  
  RelationShips.fromJSON(Map<String, Object> json) {
    _setContextFromJSON(json);
  }
  
  /**
   * Create a [RelationShip] to the node [to] of a specific [type]
   */
  Future<RelationShip> create(Node to, String type, {Map<String, Object> properties : null, ServiceExecutor executor : null}) {
    Completer<Node> completer = new Completer();
    Map<String, Object> body = { 'to' : to.reference, "type" : type };
    if (properties != null && properties.isNotEmpty) {
      body['data'] = properties;
    }
    RestRequest request = new RestRequest(_json['create_relationship'], 'POST', body);
    run(request, executor : executor).then((Map data) {
      completer.complete(new RelationShip.fromJSON(data));
    }, onError: (e) {
      completer.completeError(e);
    });
    return completer.future;
  }  
  
  /**
   * Get all relationships (outgoing and incoming relationships) of this node.
   * If you want to retrieve relationships of a specific types, use the [labels] parameter.
   */
  Future<List<RelationShip>> getAll({List<String> types, ServiceExecutor executor : null}) {
    StringReplacer replacer = types == null ? null : new StringReplacer("{-list|&|types}", types.join("&"));
    String url = types == null ? 'all_relationships' : 'all_typed_relationships';
    return _relationShips(url, replacer: replacer);
  }
  
  /**
   * Get incoming relationships of this node.
   * If you want to retrieve relationships of a specific types, use the [labels] parameter.
   */
  Future<List<RelationShip>> getIncoming({List<String> labels, ServiceExecutor executor : null}) {
    StringReplacer replacer = labels == null ? null : new StringReplacer("{-list|&|types}", labels.join("&"));
    String url = labels == null ? 'incoming_relationships' : 'incoming_typed_relationships';
    return _relationShips(url, replacer: replacer);
  }
  
  /**
   * Get outgoing relationships of this node.
   * If you want to retrieve relationships of a specific types, use the [labels] parameter.
   */
  Future<List<RelationShip>> getOutgoing({List<String> labels, ServiceExecutor executor : null}) {
    StringReplacer replacer = labels == null ? null : new StringReplacer("{-list|&|types}", labels.join("&"));
    String url = labels == null ? 'outgoing_relationships' : 'outgoing_typed_relationships';
    return _relationShips('outgoing_relationships', replacer: replacer);
  }
  
  /*
   * Internal method to request relationships
   */
  Future<List<RelationShip>> _relationShips(String property, {StringReplacer replacer, ServiceExecutor executor : null}) {
    Completer<Node> completer = new Completer();
    String url = replacer == null ? _json[property] : replacer.replace(_json[property]);
    RestRequest request = new RestRequest(url, 'GET');
    run(request, executor : executor).then((List data) {
      List<RelationShip> relationShips = new List();
      data.forEach((element) { relationShips.add(new RelationShip.fromJSON(element)); });
      completer.complete(relationShips);
    }, onError: (e) {
      completer.completeError(e);
    });
    return completer.future;
  }  
}


class RelationShip extends HasProperties with RestRunnable {
  
  static final LOG = LoggerFactory.getLoggerFor(RelationShip);
  
  String get type => _json['type'];
  String get startReference => _json['start'];
  String get endReference => _json['end'];

  RelationShip();
  
  RelationShip.fromReference(String reference) {
    _json = new Map();
    _json['self'] = reference;
  }
  
  RelationShip.fromJSON(Map context) {
    this._setContextFromJSON(context); 
  }
  
  /**
   * Retrieves the start node and returns it
   */
  Future<Node> getStart({ServiceExecutor executor : null}) {
    return _getNode('start', executor: executor);
  }
  
  /**
   * Retrieves the end node and returns it
   */
  Future<Node> getEnd({ServiceExecutor executor : null}) {
    return _getNode('end', executor: executor);
  }
  
  /**
   * Delete the current [RelationShip].
   */
  Future delete({ServiceExecutor executor : null}) {
    Completer<Node> completer = new Completer();
    RestRequest request = new RestRequest(_json['self'], 'DELETE');
    run(request, executor : executor).then((result) {
      completer.complete();
    }, onError: (e) {
      completer.completeError(e);
    });
    return completer.future;
  }
  
  Future<Node> _getNode(String point, {ServiceExecutor executor : null}) {
    Completer<Node> completer = new Completer();
    RestRequest request = new RestRequest(_json[point], 'GET');
    run(request, executor : executor).then((result) {
      completer.complete(new Node.fromJSON(result));
    }, onError: (e) {
      completer.completeError(e);
    });
    return completer.future;
  }

}
part of neo4dart;


class StringReplacer {

  String _from;
  String _replace;
  
  StringReplacer(this._from, this._replace);
  
  String replace(String source) => source.replaceAll(_from, _replace);
  
}

/**
 * It provides some useful and magic things when trying to access a 
 * properties which does not exist: it tries to get the value from the properties (retrieved from the JSON stream).
 * 
 * Only getters are magic ! There's no setter magic because you have to use a provided method to change a property value (to be sure
 * that this value will be send across the network to the Neo4j server).
 */
class HasProperties extends Object with HasContext, RestRunnable {
  
  /// Get all properties
  Map get properties => _json['data'];

  /**
   * Remove all properties.
   * 
   * Returns nothing
   */
  Future removeProperty(String key, {ServiceExecutor executor : null}) {
    Completer<Node> completer = new Completer();
    RestRequest request = new RestRequest((_json['property'] as String).replaceAll('{key}', key), 'DELETE');
    run(request, executor : executor).then((result) {
      (_json['data'] as Map).remove(key);
      completer.complete();
    }, onError: (e) {
      completer.completeError(e);
    });
    return completer.future;
  }
  
  /**
   * Remove all properties.
   * 
   * Returns nothing
   */
  Future removeProperties({ServiceExecutor executor : null}) {
    Completer<Node> completer = new Completer();
    RestRequest request = new RestRequest(_json['properties'], 'DELETE');
    run(request, executor : executor).then((result) {
      _json['data'] = { };
      completer.complete();
    }, onError: (e) {
      completer.completeError(e);
    });
    return completer.future;
  }
  
  /**
   * Get all properties. This is not a usefull method because most of time the entity model has already its properties setted
   * except if you wan to reload from store.
   * 
   * Returns a [Map] containing properties values
   */
  Future<Map<String, Object>> getProperties({ServiceExecutor executor : null}) {
    Completer<Node> completer = new Completer();
    RestRequest request = new RestRequest(_json['properties'], 'GET');
    run(request, executor : executor).then((result) {
      Map<String, Object> properties = result != null && result.isNotEmpty ? result : { };
      _json['data'] = properties;
      completer.complete(properties);
    }, onError: (e) {
      completer.completeError(e);
    });
    return completer.future;
  }
  
  /**
   * Set all properties. Properties not declared into the [Map] are deleted.
   * 
   * Returns nothing
   */
  Future setProperties(Map<String, Object> properties, {ServiceExecutor executor : null}) {
    Completer<Node> completer = new Completer();
    RestRequest request = new RestRequest(_json['properties'], 'PUT', properties);
    run(request, executor : executor).then((result) {
      _json['data'] = properties;
      completer.complete();
    }, onError: (e) {
      completer.completeError(e);
    });
    return completer.future;
  }
  
  /**
   * Set a new value for a property. Other properties are not changed.
   * 
   * Returns the property's value
   */
  Future getProperty(String key, {ServiceExecutor executor : null}) {
    Completer<Node> completer = new Completer();
    RestRequest request = new RestRequest((_json['property'] as String).replaceAll('{key}', key), 'GET');
    run(request, executor : executor).then((result) {
      // Reflect the value into the current node as there's no result from the server
      (_json["data"] as Map)[key] = result;
      completer.complete(result);
    }, onError: (e) {
      completer.completeError(e);
    });
    return completer.future;
  }
  
  /**
   * Set a new value for a property. The value is reflected into the instance's properties and other properties are not changed.
   * 
   * Returns nothing
   */
  Future setProperty(String key, Object value, {ServiceExecutor executor : null}) {
    Completer<Node> completer = new Completer();
    RestRequest request = new RestRequest((_json['property'] as String).replaceAll('{key}', key), 'PUT', value);
    run(request, executor : executor).then((result) {
      // Reflect the value into the current node as there's no result from the server
      (_json['data'] as Map)[key] = value;
      completer.complete(this);
    }, onError: (e) {
      completer.completeError(e);
    });
    return completer.future;
  }
  
  /** 
   * NoSuchMethod() is where the magic happens.
   * If we try to access a property using dot notation (eg: o.wibble ), then
   * noSuchMethod will be invoked, and identify the getter or setter name.
   * It then looks up in the map contained in _objectData (represented using
   * this (as this class implements [Map], and forwards it's calls to that
   * class.
   * If it finds the getter or setter then it either updates the value, or
   * replaces the value.
   *
   * If isExtendable = true, then it will allow the property access
   * even if the property doesn't yet exist.
   */
  noSuchMethod(Invocation mirror) {
    int positionalArgs = 0;
    if (mirror.positionalArguments != null) positionalArgs = mirror.positionalArguments.length;

    var property = mirror.memberName is Symbol ? mirrors.MirrorSystem.getName(mirror.memberName) : mirror.memberName.toString();

    if (mirror.isGetter && (positionalArgs == 0)) {
      if (properties[property] != null) {
        return properties[property];
      }
    }

    // If we get here, then we've not found it - throw.
    LOG.warn("Not found: ${property}");
    super.noSuchMethod(mirror);
  }
}

/**
 * Base class for model which works with a context.
 */
abstract class HasContext {
  
  static final LOG = LoggerFactory.getLoggerFor(HasContext);
  
  // The saved context from which the model was created
  Map<String, Object> _json;
  
  
  /// Get an URL reference to self (can be used later to recreate a model)
  String get reference => _json['self'];
  
  /**
   * Set the context
   */
  void _setContextFromJSON(Map<String, Object> context) {
    _json = context;
  }
}


/**
 * A class which can run a [RestRequest] either by using an executor or by using the default [ServiceExecutor] which is btw an 
 * [ImmediateExecutor]
 */
class RestRunnable {
  
  // Default executor which is static
  static ImmediateExecutor defaultExecutor = new ImmediateExecutor();
  
  Future run(RestRequest request, {ServiceExecutor executor : null}) {
    executor = executor == null ? defaultExecutor : executor;
    return executor.execute(request);
  }
}
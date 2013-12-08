part of neo4dart;

/**
 * A [ServiceExecutor] aims to execute a request
 */
abstract class ServiceExecutor {
  Future execute(RestRequest request);
}

/**
 * This class (used as mixin) aims to execute a request by using the executor (if not null), or by delegating to the class itself.
 * 
 * The main use-case is to create a class which uses 2 mixins: [ExecutorRunner] and another [ServiceExecutor] implementation (see [Node] for example)
 */
abstract class ExecutorRunner implements ServiceExecutor {

}

/**
 * A [ServiceExecutor] which send the request immediatly
 */
class ImmediateExecutor implements ServiceExecutor {
  Future execute(RestRequest request) {
    return _send(request.url, request.method, request.body);
  }
}

/**
 * An [Batch] send many requests into a single batch. After adding many [RestRequest], they can be send using the [BatchExecutor.flush] method.
 * 
 * All jobs are transactionnal, which means that if one failed then all jobs are rollbacked
 */
class Batch implements ServiceExecutor, Service {
  
  String _url;
  int _id = 0;
  
  List<_BatchOperation> _operations = new List();
   
  Batch._fromUrl(this._url);
  
  factory Batch() => new ServiceFactory().get(ServiceFactory.BATCH, Neo4Dart.get()._context);
  
  Future execute(RestRequest request) {
    Completer completer = new Completer();
    _operations.add(new _BatchOperation(_id++, request, completer));
    return completer.future;
  }
  
  Future flush() {
    Completer completer = new Completer();
    List jobs = _operations.map((_BatchOperation op) {
      return {'id' : op.id, 'method' : op.request.method, 'to' : op.request.url.substring(new Neo4Dart()._baseUrl.length), 'body' : op.request.body};
    }).toList();
    _send(_url, 'POST', jobs).then((List<Map> datas) {
      List<Future> futures = new List();
      datas.forEach((Map data) {
        futures.add(_operations[data['id']].completer.future);
        _operations[data['id']].completer.complete(data['body']);
      });
      Future.wait(futures).then((_) => completer.complete());
    });
    return completer.future;
  }
}

///
/// A class to store a [RestRequest] and the associated [Completer]
/// 
class _BatchOperation {
  RestRequest request;
  Completer completer;
  int id;
  _BatchOperation(this.id, this.request, this.completer);
}


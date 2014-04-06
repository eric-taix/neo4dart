part of neo4dart;

/**
 * Defines a service creator function
 */
typedef Service ServiceCreator(String url);


/**
 * Minimal service interface (act as a marker)
 */
abstract class Service {
}


/**
 * A factory to retrieve an [Service]
 * 
 * Standard endpoints are already registered but extension endpoints can be added afterward
 * 
 */
class ServiceFactory {
  
  static const String NODES = "node";
  static const String VERSION = "neo4j_version";
  static const String BATCH = "batch";
  
  static ServiceFactory _instance = new ServiceFactory._internal();
  Map<String, ServiceCreator> _register = new Map();
  
  /**
   * Factory constructor which returns the singleton instance
   */
  factory ServiceFactory() => _instance;

  /*
   * Internal constructor which initialize standard endpoints
   */
  ServiceFactory._internal() {
//    "extensions" : {
//    },
    // Root endpoints
    register(NODES, (String url) => new Nodes(url));
//    register("reference_node");
//    register("node_index");
//    register("relationship_index");
//    register("extensions_info");
//    register("relationship_types");
    register(BATCH, (String url) => new Batch._fromUrl(url));
//    register("cypher");
    register(VERSION, (String version) => new Version(version));
//    
//    // Nodes' standard endpoints
//    register("paged_traverse");
//    register("labels");
//    register("outgoing_relationships");
//    register("traverse");
//    register("all_typed_relationships");
//    register("self");
//    register("property");
//    register("all_relationships");
//    register("properties");
//    register("outgoing_typed_relationships");
//    register("incoming_relationships");
//    register("incoming_typed_relationships");
//    register("create_relationship");
  }
  
  
  /**
   * Register a new [Service] for a particular [key]
   */
  void register(String key, ServiceCreator creator) {
    _register[key] = creator;
  }
  
  /**
   * Get a [Service] according to the key
   */
  Service get(String key, Map context) => _register[key](context[key]);
}


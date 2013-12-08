#Neo4Dart  
  
Server-side driver library for Neo4J implemented in pure Dart.  
  
###Simple usage   
  
This example is based on movies database:  
  
    void main() {  
      final LOG = LoggerFactory.getLogger("main");  
      ServiceRoot.init("127.0.0.1", 7474).then((ServiceRoot root) {  
        LOG.info('Running Neo4J server v${root.version.number}');  
        root.nodes.get(1).then((Node node) {  
          LOG.debug("Node1: ${node.properties['title']} (${node.properties['tagline']}), released in ${node.properties['released']}");  
          node.setProperty("title", "The Matrix (1)").then((Node node) {  
            LOG.debug('done');  
          });  
        });  
      });  
    }  
  
This driver is in a early development stage. You can use it at your own risks !  
  
#See also  
  
- REST Api compatibility list  
  
- More examples  
  
- Benchmark
 

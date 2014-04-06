import 'package:unittest/unittest.dart';

import '../lib/neo4dart.dart';

import 'utils.dart';
import 'nodes_tests.dart';
import 'transactionnal_tests.dart';
import 'relationship_tests.dart';
import 'relationshiptype_tests.dart';
import 'propertyvalues_tests.dart';
import 'nodeproperties_tests.dart';
import 'relationshipproperties_tests.dart';
import 'nodeslabels_tests.dart';
import 'batch_tests.dart';
import 'serviceroot_tests.dart';

main() {

  initialize().then((Neo4Dart neo4d) {
    transactionnal(neo4d);
    serviceRoot();
    streaming();
    cypher();
    propertyValues(neo4d);
    nodes(neo4d);
    relationShips(neo4d);
    relationShipTypes(neo4d);
    nodeProperties(neo4d);
    relationshipProperties(neo4d);
    nodeLabels(neo4d);
    indexing();
    constraints();
    traversals();
    graphAlgo();
    batch(neo4d);
//    legacyIndexing();
//    uniqueIndexing();
//    legacyAutomaticIndex();
//    configurableLegacyAutomaticIndex();
  });
}


void indexing() {
  group('Indexing', () {
    test('Create index', () {
      notYetImplemented();
    });
    test('List indexes for a label', () {
      notYetImplemented();
    });
    test('Drop index', () {
      notYetImplemented();
    }); 
  });
}

void constraints() {
  group('Constraints', () {
    test('Create uniqueness constraint', () {
      notYetImplemented();
    });
    test('Get a specific uniqueness constraint', () {
      notYetImplemented();
    });
    test('Get all uniqueness constraints for a label', () {
      notYetImplemented();
    }); 
    test('Get all constraints for a label', () {
      notYetImplemented();
    });
    test('Get all constraints', () {
      notYetImplemented();
    });
    test('Drop constraint', () {
      notYetImplemented();
    }); 
  });
}

void traversals() {
  group('Traversals', () {
    test('Traversal using a return filter', () {
      notYetImplemented();
    });
    test('Return relationships from a traversal', () {
      notYetImplemented();
    });
    test('Return paths from a traversal', () {
      notYetImplemented();
    }); 
    test('Traversal returning nodes below a certain depth', () {
      notYetImplemented();
    });
    test('Creating a paged traverser', () {
      notYetImplemented();
    });
    test('Paging through the results of a paged traverser', () {
      notYetImplemented();
    }); 
    test('Paged traverser page size', () {
      notYetImplemented();
    }); 
    test('Paged traverser timeout', () {
      notYetImplemented();
    }); 
  });
}

void graphAlgo() {
  group('Graph Algorithms', () {
    test('Find all shortest paths', () {
      notYetImplemented();
    });
    test('Find one of the shortest paths', () {
      notYetImplemented();
    });
    test('Execute a Dijkstra algorithm and get a single path', () {
      notYetImplemented();
    }); 
    test('Execute a Dijkstra algorithm with equal weights on relationships', () {
      notYetImplemented();
    });
    test('Execute a Dijkstra algorithm and get multiple paths', () {
      notYetImplemented();
    });
  });
}



void legacyIndexing() {
  group('Legacy indexing', () {
    test('Create node index', () {
      notYetImplemented();
    });
    test('Create node index with configuration', () {
      notYetImplemented();    });
    test('Delete node index', () {
      notYetImplemented();
    }); 
    test('List node indexes', () {
      notYetImplemented();
    });
    test('Add node to index', () {
      notYetImplemented();
    });
    test('Remove all entries with a given node from an index', () {
      notYetImplemented();
    });
    test('Remove all entries with a given node and key from an index', () {
      notYetImplemented();
    });
    test('Remove all entries with a given node, key and value from an index', () {
      notYetImplemented();
    });
    test('Find node by exact match', () {
      notYetImplemented();
    });
    test('Find node by query', () {
      notYetImplemented();
    });
  });
}

void uniqueIndexing() {
  group('Unique indexing', () {
    test('Get or create unique node (create)', () {
      notYetImplemented();
    });
    test('Get or create unique node (existing)', () {
      notYetImplemented();
    });
    test('Create a unique node or return fail (create)', () {
      notYetImplemented();
    }); 
    test('Create a unique node or return fail (fail)', () {
      notYetImplemented();
    });
    test('Add an existing node to unique index (not indexed)', () {
      notYetImplemented();
    });
    test('Add an existing node to unique index (already indexed)', () {
      notYetImplemented();
    });
    test('Get or create unique relationship (create)', () {
      notYetImplemented();
    });
    test('Get or create unique relationship (existing)', () {
      notYetImplemented();
    });
    test('Create a unique relationship or return fail (create)', () {
      notYetImplemented();
    });
    test('Create a unique relationship or return fail (fail)', () {
      notYetImplemented();
    });
    test('Add an existing relationship to a unique index (not indexed)', () {
      notYetImplemented();
    });
    test('Add an existing relationship to a unique index (already indexed)', () {
      notYetImplemented();
    });
  });
}

void legacyAutomaticIndex() {
  group('Legacy automatic indexing', () {
    test('Find node by exact match from an automatic index', () {
      notYetImplemented();
    });
    test('Find node by query from an automatic index', () {
      notYetImplemented();
    });
  });
}

void configurableLegacyAutomaticIndex() {
  group('Configurable Legacy automatic indexing', () {
    test('Create an auto index for nodes with specific configuration', () {
      notYetImplemented();
    });
    test('Create an auto index for relationships with specific configuration', () {
      notYetImplemented();
    });
    test('Get current status for autoindexing on nodes', () {
      notYetImplemented();
    });
    test('Enable node autoindexing', () {
      notYetImplemented();
    });
    test('Lookup list of properties being autoindexed', () {
      notYetImplemented();
    });
    test('Add a property for autoindexing on nodes', () {
      notYetImplemented();
    });
    test('Remove a property for autoindexing on nodes', () {
      notYetImplemented();
    });
  });
}



void streaming() {
  group('Streaming', () {
    test('Streaming', () {
      notYetImplemented();
    });
  });
}

void cypher() {
  group('Cypher queries', () {
    test('Use parameters', () {
      notYetImplemented();
    });
    test('Create a node', () {
      notYetImplemented();
    });
    test('Create a node with multiple properties', () {
      notYetImplemented();
    });
    test('Create mutiple nodes with properties', () {
      notYetImplemented();
    });
    test('Set all properties on a node using Cypher', () {
      notYetImplemented();
    });
    test('Send a query', () {
      notYetImplemented();
    });
    test('Return paths', () {
      notYetImplemented();
    });
    test('Nested results', () {
      notYetImplemented();
    });
    test('Retrieve query metadata', () {
      notYetImplemented();
    });
    test('Errors', () {
      notYetImplemented();
    });
  });
}
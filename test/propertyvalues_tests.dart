library propertyvalues_tests;

import 'package:unittest/unittest.dart';
import '../lib/neo4dart.dart';
import 'utils.dart';

main() {

  initialize().then((Neo4Dart neo4d) {
    propertyValues(neo4d);
  });
}

void propertyValues(Neo4Dart neo4d) {
  group('Property values', () {
    test('Arrays', () {
      fail("(Not implemented)");
    });
    test('Property keys', () {
      fail("(Not implemented)");
    });
    test('List all property keys', () {
      fail("(Not implemented)");
    });
  });
}
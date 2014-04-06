library relationshiptype_tests;

import 'dart:async';

import 'package:unittest/unittest.dart';
import '../lib/neo4dart.dart';
import 'utils.dart';

main() {

  initialize().then((Neo4Dart neo4d) {
    relationShipTypes(neo4d);
  });
}

void relationShipTypes(Neo4Dart neo4d) {
  group('Relationship types', () {
    test('Get relationship types', () {
      Future f = neo4d.relationTypes.getTypes();
      f.then((List<String> types) {
        expect(types, isNotNull);
        expect(types.length, isNonZero);
        // Can't expect much more ! We don't the store state...
      });
      expect(f, completes);
      return f;
    });
  });
}
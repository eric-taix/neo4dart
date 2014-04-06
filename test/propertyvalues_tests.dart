library propertyvalues_tests;

import 'package:unittest/unittest.dart';
import '../lib/neo4dart.dart';
import 'utils.dart';
import 'dart:async';

main() {

  initialize().then((Neo4Dart neo4d) {
    propertyValues(neo4d);
  });
}

void propertyValues(Neo4Dart neo4d) {
  group('Property values', () {
    test('List all property keys', () {
      Future f = neo4d.properties.getAll();
      f.then((List<String> keys) {
        expect(keys, isNotNull);
      }, onError: (e) {
        fail('Unable to retrieve property keys');
      });
      expect(f, completes);
    });
  });
}
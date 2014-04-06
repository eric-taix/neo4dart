library nodeproperties_tests;

import 'dart:async';

import 'package:unittest/unittest.dart';
import '../lib/neo4dart.dart';
import 'utils.dart';

main() {

 initialize().then((Neo4Dart neo4d) {
    nodeProperties(neo4d);
  });
}

void nodeProperties(Neo4Dart neo4d) {

  group('Node properties', () {
    Node n;
    test('Set property on node', () {
      Future f = neo4d.nodes.create(properties: {'firstname' : 'eric', 'name' : 'taix'}).then((Node r) => r.setProperty('name', 'Taix'));
      f.then((Node r) {
        n = r;
        // Not a real test as it does not test if the new property's value has been stored properly
        expect(n.properties['name'], equals('Taix'));
        Future f = n.getProperties();
        f.then((Map<String, Object> properties) {
          expect(properties, isNotNull);
          expect(properties.length, isNonZero);
          expect(properties['name'], equals('Taix'));
          expect(properties['firstname'], equals('eric'));
          // Now test if we can set a non existing property
          f = n.setProperty('age', 45);
          f.then((_) {
            Future f = n.getProperties();
            f.then((Map<String, Object> properties) {
              expect(properties, isNotNull);
              expect(properties.length, isNonZero);
              expect(properties['name'], equals('Taix'));
              expect(properties['firstname'], equals('eric'));
              expect(properties['age'], equals(45));
            });
            expect(f, completes);
          });
          expect(f, completes);
        });
        expect(f, completes);
      });
      expect(f, completes);
      return f;
    });
    test('Update node properties', () {
      Future f = n.setProperties({'firstname': 'Eric', 'married' : true});
      // We don't care about the result as it doesn't reflect the store's current values
      f.then((_) {
        Future f = n.getProperties();
        f.then((Map<String, Object> properties) {
          expect(properties, isNotNull);
          expect(properties.length, equals(2));
          expect(properties['firstname'], equals('Eric'));
          expect(properties['married'], equals(true));
          expect(properties['name'], isNull);
        });
        expect(f, completes);
      });
      expect(f, completes);
      return f;

    });
    test('Get properties for node', () {
      Future f = n.getProperties();
      f.then((Map<String, Object> properties) {
        expect(properties, isNotNull);
        expect(properties.length, equals(2));
        expect(properties['firstname'], equals('Eric'));
        expect(properties['married'], equals(true));
        expect(properties['name'], isNull);
      });
      expect(f, completes);
      return f;
     });
    test('Property values can not be null', () {
      Future f = n.setProperty('name', null).then((_) {
        fail("Should have failed: property values can not be null");
      }, onError: (RestException e) {
        expect(e.statusCode, 400);
      });
      return f;
    });
    test('Property values can not be nested', () {
      Future f = n.setProperty('name', { "foo" : "bar"});
      f.then((_) {
        fail("Should have failed: Property values can not be nested");
      }, onError: (e) {
        expect(e.statusCode, equals(400));
      });
    });
    test('Delete all properties from node', () {
      Future f = n.removeProperties();
      f.then((_) {
        Future f = n.getProperties();
        f.then((Map<String, Object> properties) {
          expect(properties, isNotNull);
          expect(properties.length, equals(0));
        });
        expect(f, completes);
      });
      expect(f, completes);
      return f;
    });
    test('Delete a named property from a node', () {
      Future f = n.setProperties({'firstname': 'Eric', 'married' : true});
      // We don't care about the result as it doesn't reflect the store's current values
      f.then((_) {
        Future f = n.removeProperty('firstname');
        f.then((_) {
          Future f = n.getProperties();
          f.then((Map<String, Object> properties) {
            expect(properties, isNotNull);
            expect(properties.length, equals(1));
            expect(properties['firstname'], isNull);
            expect(properties['married'], equals(true));
          });
          expect(f, completes);
        });
        expect(f, completes);
      });
      expect(f, completes);
      return f;
    });
  });
}

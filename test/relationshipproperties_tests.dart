library relationshipproperties_tests;

import 'dart:async';

import 'package:unittest/unittest.dart';
import '../lib/neo4dart.dart';
import 'utils.dart';

main() {

  initialize().then((Neo4Dart neo4d) {
      relationshipProperties(neo4d);
  });
}

void relationshipProperties(Neo4Dart neo4d) {
  group('Relationship properties', () {
    Node n1, n2;
    test('Update relationship properties', () {
      Future f = neo4d.nodes.create(properties: {'firstname' : 'eric', 'name' : 'taix'});
      f.then((Node n) {
        n1 = n;
        Future f = neo4d.nodes.create(properties: {'firstname' : 'eric2', 'name' : 'taix2'});
        f.then((Node n) {
          n2 = n;
          // Don't know if it's a good test for this chapter: it seems to be redundant with 20.9.2
          Future f = n1.relations.create(n2, "MARRIED", properties: {'role' : 'husband', 'since' : '1994/07/09'});
          f.then((RelationShip relation) {
            Future f = relation.setProperties({'role' : 'mari', 'years' : 19 });
            f.then((_) {
              Future f = relation.getProperties();
              f.then((Map<String, Object> properties) {
                expect(properties, isNotNull);
                expect(properties.length, 2);
                expect(properties['role'], equals('mari'));
                expect(properties['years'], equals(19));
                expect(properties['since'], isNull);
              });
              expect(f, completes);
            });
            expect(f, completes);
          });
          expect(f, completes);
        });
        expect(f, completes);
      });
      expect(f, completes);
    });
    // Seems to be redundant with 20.9.6
    test('Remove properties from a relationship', () {
      Future f = n1.relations.create(n2, "FRIEND", properties: {'when' : '1990/09/10', 'where' : 'nightclub'});
      f.then((RelationShip relation) {
        Future f = relation.removeProperties();
        f.then((_) {
          Future f = relation.getProperties();
          f.then((Map<String, Object> properties) {
            expect(properties, isNotNull);
            expect(properties.length, 0);
          });
          expect(f, completes);
        });
        expect(f, completes);
      });
      expect(f, completes);
      return f;
    });
    // Seems to be redundant with 20.9.7
    RelationShip relation;
    test('Remove property from a relationship', () {
      Future f = n2.relations.create(n1, "FRIEND", properties: {'when' : '1990/09/10', 'where' : 'nightclub'});
      f.then((RelationShip r) {
        relation = r;
        Future f = relation.removeProperty('where');
        f.then((_) {
          Future f = relation.getProperties();
          f.then((Map<String, Object> properties) {
            expect(properties, isNotNull);
            expect(properties.length, 1);
            expect(properties['when'], equals('1990/09/10'));
            expect(properties['where'], isNull);
          });
          expect(f, completes);
        });
        expect(f, completes);
      });
      expect(f, completes);
      return f;
    });
    test('Remove non-existent property from a relationship', () {
      Future f = relation.removeProperty('ghost');
      f.then((_) {
        fail("Should fail: can't remove a non-existent property");
      }, onError: (RestException e) {
        expect(e.statusCode, 404);
      });
    });
    test('Remove properties from a non-existing relationship', () {
      Future f = n2.relations.create(n2, 'DIRECTED');
      f.then((RelationShip relation) {
        Future f = relation.delete();
        f.then((_) {
          Future f = relation.removeProperties();
          f.then((_) {
            fail("Should fail: can't remove properties from a non-existing relationship");
          }, onError: (RestException e) {
            expect(e.statusCode, 404);
          });
        });
        expect(f, completes);
      });
      expect(f, completes);
      return f;
    });
    test('Remove property from a non-existing relationship', () {
      Future f = n2.relations.create(n2, 'DIRECTED');
      f.then((RelationShip relation) {
        Future f = relation.delete();
        f.then((_) {
          Future f = relation.removeProperty('does_not_matter');
          f.then((_) {
            fail("Should fail: can't remove properties from a non-existing relationship");
          }, onError: (RestException e) {
            expect(e.statusCode, 404);
          });
        });
        expect(f, completes);
      });
      expect(f, completes);
      return f;
    });
  });
}
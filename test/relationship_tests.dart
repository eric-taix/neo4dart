library relationship_tests;

import 'dart:async';

import 'package:unittest/unittest.dart';
import '../lib/neo4dart.dart';
import 'utils.dart';

main() {

  initialize().then((Neo4Dart neo4d) {
    relationShips(neo4d);
  });
}

void relationShips(Neo4Dart neo4d) {
  group('Relationships', () {
    test('Get Relationship by ID', () {
      fail("(Not yet implemented)");
    });
    test('Create relationship', () {
      Future f = neo4d.nodes.create();
      f.then((Node node1) {
        expect(node1, isNotNull);
        Future f = neo4d.nodes.create();
        f.then((Node node2) {
          expect(node2, isNotNull);
          Future f = node1.relations.create(node2, "LIKES");
          f.then((RelationShip relation) {
            expect(relation, isNotNull);
            expect(relation.type, equals("LIKES"));
          });
          expect(f, completes);
        });
        expect(f, completes);
      });
      expect(f, completes);
      return f;
    });
    RelationShip rs_20_7_3;
    Node n_20_7_3;
    test('Create a relationship with properties', () {
      Future f = neo4d.nodes.create();
      f.then((Node node1) {
        n_20_7_3 = node1;
        expect(node1, isNotNull);
        Future f = neo4d.nodes.create();
        f.then((Node node2) {
          expect(node2, isNotNull);
          Future f = node1.relations.create(node2, "LIKES", properties: { "foo" : "bar", "hip" : "hop"});
          f.then((RelationShip relation) {
            rs_20_7_3 = relation;
            expect(relation, isNotNull);
            expect(relation.type, equals("LIKES"));
            expect(relation.properties['foo'], equals('bar'));
            expect(relation.properties['hip'], equals('hop'));
            print('${relation.startReference} -> ${relation.endReference}');
          });
          expect(f, completes);
        });
        expect(f, completes);
      });
      expect(f, completes);
      return f;
    });
    test('Delete relationship', () {
      Node n1, n2;
      Future fn1 = neo4d.nodes.create();
      fn1.then((Node n) { n1 = n; });
      Future fn2 = neo4d.nodes.create();
      fn2.then((Node n) { n2 = n; });
      Future fn = Future.wait([fn1, fn2]);
      fn.then((_) {
        Future f = n1.relations.create(n2, 'SELF');
        f.then((RelationShip relation) {
          Future f = relation.delete();
          expect(f, completes);
        });
        expect(f, completes);
      });
      expect(fn, completes);
      return fn;
    });
    test('Get all properties on a relationship', () {
      Future f = rs_20_7_3.getProperties();
      f.then((Map properties) {
        expect(properties, isNotNull);
        expect(properties['foo'], equals('bar'));
        expect(properties['hip'], equals('hop'));
      });
      expect(f, completes);
      return f;
    });
    test('Set all properties on a relationship', () {
      Future f = rs_20_7_3.setProperties({ "name" : "Eric Taix", "birthday" : "1968/11/11"}); 
      f.then((_) {
        expect(rs_20_7_3.type, equals("LIKES"));
        expect(rs_20_7_3.properties['foo'], isNull);
        expect(rs_20_7_3.properties['hip'], isNull);
        expect(rs_20_7_3.properties['name'], equals('Eric Taix'));
        expect(rs_20_7_3.properties['birthday'], equals('1968/11/11'));
      });
      expect(f, completes);
      return f;
    });
    test('Get single property on a relationship', () {
      Future f = rs_20_7_3.getProperty('name');
      f.then((String value) {
        expect(value, equals('Eric Taix'));
      });
      expect(f, completes);
      return f;
    });
    test('Set single property on a relationship', () {
      Future f = rs_20_7_3.setProperty('name','Eric Taxi');
      f.then((_) {
        expect(rs_20_7_3.properties['name'], equals('Eric Taxi'));
        expect(rs_20_7_3.properties['birthday'], equals('1968/11/11'));
        Future f = rs_20_7_3.getProperty('name');
        f.then((String value) {
          expect(value, equals('Eric Taxi'));
        });
        expect(f, completes);
      });
      expect(f, completes);
      return f;
    });
    Node n1, n2, n3;
    test('Get all relationships', () {
      Future fn1 = neo4d.nodes.create(properties: {'name':'Eric'});
      fn1.then((Node n) { n1 = n; });
      Future fn2 = neo4d.nodes.create(properties: {'name':'Chrystèle'});
      fn2.then((Node n) { n2 = n; });
      Future fn3 = neo4d.nodes.create(properties: {'name':'Edgard'});
      fn3.then((Node n) { n3 = n; });
      Future fn = Future.wait([fn1, fn2, fn3]);
      fn.then((_) {
        Future fr1 = n1.relations.create(n2, 'MARRIED_WITH', properties : {'role' : 'husband'});
        Future fr2 = n1.relations.create(n3, 'PARENT_OF', properties : {'role' : 'father'});
        Future fr3 = n2.relations.create(n3, 'PARENT_OF', properties : {'role' : 'mother'});
        Future fr4 = n2.relations.create(n1, 'MARRIED_WITH', properties : {'role' : 'wife'});
        Future fr = Future.wait([fr1, fr2, fr3, fr4]);
        fr.then((_) {
          Future f = n1.relations.getAll();
          f.then((List<RelationShip> relations) {
            relations.forEach((RelationShip r) {
              if (r.type == 'PARENT_OF') {
                expect(r.properties['role'], equals('father'));
                return;
              }
              if (r.type == 'MARRIED_WITH') {
                if (r.startReference == n1.reference) {
                  expect(r.properties['role'], equals('husband'));
                  return;
                }
                if (r.endReference == n1.reference) {
                  expect(r.properties['role'], equals('wife'));
                  return;
                } 
              }
              fail('Wrong relation: ${r}');
            });
            expect(relations, isNotNull);
            expect(relations.length, 3);
          });
          expect(f, completes);
        });
        expect(fr, completes);
      });
      expect(fn, completes);
      return fn;
    });
    test('Get incoming relationships', () {
      Future f = n1.relations.getIncoming();
      f.then((List<RelationShip> relations) {
        expect(relations, isNotNull);
        expect(relations.length, 1);
        expect(relations[0].endReference, equals(n1.reference));
        expect(relations[0].properties['role'], equals('wife'));
      });
      expect(f, completes);
      return f;
    });
    test('Get outgoing relationships', () {
      Future f = n1.relations.getOutgoing();
      f.then((List<RelationShip> relations) {
        expect(relations, isNotNull);
        expect(relations.length, 2);
      });
      expect(f, completes);
      return f;
    });
    test('Get typed relationships', () {
      Node n4, n5;
      Future fn4 = neo4d.nodes.create(properties: {'name':'Arthur'});
      fn4.then((Node n) => n4 = n);
      Future fn5 = neo4d.nodes.create(properties: {'name':'Jules'});
      fn5.then((Node n) => n5 = n);
      Future fn = Future.wait([fn4, fn5]);
      fn.then((_) {
        Future fr4 = n1.relations.create(n4, 'PARENT_OF', properties: {'role':'father'});
        Future fr5 = n1.relations.create(n5, 'PARENT_OF', properties: {'role':'father'});
        Future fr = Future.wait([fr4, fr5]);
        fr.then((_) {
          Future f = n1.relations.getAll(types: ['PARENT_OF']);
          f.then((List<RelationShip> relations) {
            expect(relations, isNotNull);
            expect(relations.length, 3);
          });
          expect(f, completes);
        });
        expect(fr, completes);
      });
      expect(fn, completes);
      return fn;
    });
    test('Get relationships on a node without relationships', () {
      Future f = neo4d.nodes.create(properties: {'name':'ghost'});
      f.then((Node n) {
       Future f =  n.relations.getAll();
       f.then((List<RelationShip> relations) {
          expect(relations, isNotNull);
          expect(relations, isEmpty);
        });
       expect(f, completes);
      });
      expect(f, completes);
      return f;
    });
  });
}
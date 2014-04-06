library mode_tests;

import 'dart:async';

import 'package:unittest/unittest.dart';
import '../lib/neo4dart.dart';
import 'utils.dart';

main() {

  initialize().then((Neo4Dart neo4dart) {
    nodes(neo4dart);
  });
}

void nodes(Neo4Dart neo4d) {
  group('Nodes', () {
    Node createdNode;
    test('Create node', () {
      Future f = neo4d.nodes.create();
      f.then((Node node) {
        expect(node, isNotNull);
        expect(node.properties, isNotNull);
        expect(node.properties.length, isZero);
        createdNode = node;
      });
      expect(f, completes);
      return f;
    });
    Node n1;
    test('Create node with properties', () {
      Future f = neo4d.nodes.create(properties: {"name": "Eric Taix", "birthday": "1968/11/11"});
      f.then((Node node) {
        n1 = node;
        expect(node, isNotNull);
        expect(node.properties, isNotNull);
        expect(node.properties.length, isNonZero);
        expect(node.properties['name'], equals('Eric Taix'));
        expect(node.properties['birthday'], equals('1968/11/11'));
      });
      expect(f, completes);
      return f;
    });
    test('Get node', () {
       neo4d.nodes.get(n1.id).then((Node node) {  
        expect(node, isNotNull);
        expect(node.id, equals(n1.id));
      });
    });
    test('Get non-existent node', () {
      neo4d.nodes.get(9999999999).then((Node node) {  
        fail('This node should not exist');
      }, onError: (e) {
        expect(e.statusCode, equals(404));
      });
    });
    test('Delete node', () {
      Future f = neo4d.nodes.delete(createdNode.id);
      expect(f, completes);
    });
    test('Nodes with relationships cannot be deleted', () {
      Batch batch = new Batch();
      Node n1, n2;
      neo4d.nodes.create(executor: batch).then((Node n) => n1 = n);
      neo4d.nodes.create(executor: batch).then((Node n) => n2 = n);      
      Future f = batch.flush().then((_) => n1.relations.create(n2, 'friend')).then((_) => n1.delete()).then((_) => fail('This node should not exist'), onError: (e) => expect(e.statusCode, equals(409)));
      expect(f, completes);
    });
  });
}
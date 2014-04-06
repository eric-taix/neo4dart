library nodelabels_test;

import 'dart:async';

import 'package:unittest/unittest.dart';
import '../lib/neo4dart.dart';
import 'utils.dart';

main() {

  initialize().then((Neo4Dart neo4d) {
    nodeLabels(neo4d);
  });
}

void nodeLabels(Neo4Dart neo4d) {
  group('Node labels', () {
    Node n;
    test('Adding a label to a node', () {
      Future f = neo4d.nodes.create(properties: {'firstname' : 'eric', 'name' : 'taix'});
      f.then((Node r) {
        n = r;
        Future f = n.labels.add('MANAGER');
        f.then((_) {
          Future f = n.labels.get();
          f.then((List<String> labels) {
             expect(labels, isNotNull);
             expect(labels.length, 1);
             expect(labels[0], equals('MANAGER'));
          });
          expect(f, completes);
        });
        expect(f, completes);
        return f;
      });
      expect(f, completes);
    });
    test('Adding multiple labels to a node', () {
      Future f = n.labels.adds(['MUSICIAN', 'PLAYER']);
      f.then((_) {
        Future f = n.labels.get();
        f.then((List<String> labels) {
           expect(labels, isNotNull);
           expect(labels.length, 3);
        });
        expect(f, completes);
      });
      expect(f, completes);
      return f;
    });
    test('Adding a label with an invalid name', () {
      Future f = n.labels.add('');
      f.then((_) {
       fail("Should fail: can't add an empty label");
      }, onError: (RestException e) {
        expect(e.statusCode, 400);
      });
    });
    test('Replacing labels on a node', () {
      Future f = n.labels.set(['ENGINEER', 'COOKER']);
      f.then((_) {
        Future f = n.labels.get();
        f.then((List<String> labels) {
           expect(labels, isNotNull);
           expect(labels.length, 2);
           expect(labels[0], 'ENGINEER');
           expect(labels[1], 'COOKER');
        });
        expect(f, completes);
      });
      expect(f, completes);
      return f;
    });
    test('Removing a label from a node', () {
      Future f = n.labels.remove('COOKER');
      f.then((_) {
        Future f = n.labels.get();
        f.then((List<String> labels) {
           expect(labels, isNotNull);
           expect(labels.length, 1);
           expect(labels[0], 'ENGINEER');
        });
        expect(f, completes);
      });
      expect(f, completes);
      return f;
    });
    test('Listing labels for a node', () {
      Future f = n.labels.get();
      f.then((List<String> labels) {
        expect(labels, isNotNull);
        expect(labels.length, 1);
        expect(labels[0], 'ENGINEER');
      });
      expect(f, completes);
      return f;
    });
    test('Get all nodes with a label', () {
      fail("(Can't be implemented: wait for Neo4J answer)");
    });
    test('Get nodes by label and property', () {
      fail("(Can't be implemented: wait for Neo4J answer)");
    });
    test('List all labels', () {
      fail("(Can't be implemented: wait for Neo4J answer)");
    });
  }); 
}
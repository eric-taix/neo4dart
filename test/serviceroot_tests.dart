library serviceroot_test;

import 'dart:io';
import 'dart:async';

import 'package:unittest/unittest.dart';
import '../lib/neo4dart.dart';
import 'utils.dart';

main() {

  initialize().then((_) {
    serviceRoot();
  });
}

void serviceRoot() {
  group('Service root', () {
    test('Get service root', () {
      Future f = Neo4Dart.init("127.0.0.1");
      f.then((Neo4Dart neo4d) {
        expect(neo4d.version.number, isNotNull);
        expect(neo4d.nodes, isNotNull);
        expect(neo4d.relationTypes, isNotNull);
      }, onError: (e) {
        fail("Unable to initialize Neo4Dart: $e");
      });
      expect(f, completes);
    });
    test('Get unvalid service root', () {
      Future f = Neo4Dart.init("127.0.0.1", port: 7777);
      f.then((Neo4Dart neo4d) {
        fail("Should not complete correctly");
      }, onError: (e) {
        expect(e, new isInstanceOf<SocketException>('SocketException'));
      });
    });    
  });
}
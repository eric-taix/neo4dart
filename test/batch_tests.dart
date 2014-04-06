library batch_tests;

import 'dart:async';

import 'package:unittest/unittest.dart';
import '../lib/neo4dart.dart';
import 'utils.dart';

main() {

  initialize()..then((Neo4Dart neo4d) {
    batch(neo4d);
  });
}

void batch(Neo4Dart neo4d) {
  group('Batch operations', () {
    test('Execute multiple operations in batch', () {
      Node n1, n2, n3;
      Batch batch = new Batch();
      neo4d.nodes.create(executor: batch).then((Node n) => n1 = n);
      neo4d.nodes.create(properties : {'name' : 'chrystelle', 'age' : 44}, executor: batch).then((Node n) => n2 = n);
      neo4d.nodes.create(executor: batch).then((Node n) => n3 = n);
      Future f = batch.flush();
      f.then((e) {
        expect(n1, isNotNull);
        expect(n2, isNotNull);
        expect(n3, isNotNull);
        // Add another test to verify if we can use relationships and change node with the same batch
        RelationShip r1;
        Batch batch = new Batch();
        n1.setProperties({'name' : 'eric', 'age' :  45}, executor: batch);
        n2.setProperty('name', 'chrystele', executor: batch);
        n1.relations.create(n2, 'MARRIED', executor: batch).then((RelationShip r) => r1 = r);
        Future f = batch.flush();
        f.then((_) {
          expect(r1, isNotNull);
          expect(r1.type, equals('MARRIED'));
        });
        expect(f, completes);
      });
      expect(f, completes);
      return f;
    });
    test('Refer to items created earlier in the same batch job', () {
      Node n1, n2;
      RelationShip r1;
      Batch batch = new Batch();
      neo4d.nodes.create(properties : {'name' : 'bob'}, executor: batch).then((Node n) => n1 = n);
      neo4d.nodes.create(properties : {'age' : 12}, executor: batch).then((Node n) => n2 = n);
      neo4d.run(new RelativeRestRequest('{0}/relationships','POST',{'to': '{1}', 'data': {'since': '2012'}, 'type': 'KNOWS'}), executor: batch).then((Map m) => r1 = new RelationShip.fromJSON(m));
      Future f = batch.flush();
      f.then((_) {
        expect(n1, isNotNull);    
        expect(n2, isNotNull); 
        expect(r1, isNotNull);
        expect(n1.properties['name'], 'bob');
        expect(n2.properties['age'], 12);
        expect(r1.startReference, equals(n1.reference));
        expect(r1.endReference, equals(n2.reference));
        expect(r1.type, 'KNOWS');
        expect(r1.properties['since'], '2012');
      });
      expect(f, completes);
      return f;
    });
    test('Execute multiple operations in batch streaming', () {
      fail("(Not implemented)");
    }); 
  });
}
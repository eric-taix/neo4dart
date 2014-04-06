library transactionnal_test;


import 'package:unittest/unittest.dart';
import '../lib/neo4dart.dart';
import 'utils.dart';

main() {

  initialize().then((Neo4Dart neo4dart) {
    transactionnal(neo4dart);
  });
}

void transactionnal(Neo4Dart neo4d) {
  group('Transactionnal', () {
    test('Begin a transaction', () {
      fail("(Not implemented)");
    });
    test('Execute statements in an open transaction', () {
      fail("(Not implemented)");
    });
    test('Execute statements in an open transaction in REST format for the return', () {
      fail("(Not implemented)");
    });
    test('Reset transaction timeout of an open transaction', () {
      fail("(Not implemented)");
    });
    test('Commit an open transaction', () {
      fail("(Not implemented)");
    });
    test('Rollback an open transaction', () {
      fail("(Not implemented)");
    });
    test('Begin and commit a transaction in one request', () {
      fail("(Not implemented)");
    });
    test('Return results in graph format', () {
      fail("(Not implemented)");
    });
    test('Handling errors', () {
      fail("(Not implemented)");
    });
  });
}
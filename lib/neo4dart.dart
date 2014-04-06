library neo4dart;

import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:mirrors' as mirrors;

import "package:log4dart/log4dart.dart";

part 'services/base.dart';
part 'services/std/root.dart';
part 'services/std/version.dart';
part 'services/std/node.dart';
part 'services/std/relationship.dart';
part 'services/std/properties.dart';
part 'services/services.dart';

part 'executors/executors.dart'; 
part 'http/http.dart';


Neo4Dart root;

abstract class Movie extends Node {
  String get title;
  String get tagline;
  String get released;
}

void main() {
  LoggerFactory.config["http"].debugEnabled = true;
  print( Platform.script.pathSegments);
  final LOG = LoggerFactory.getLogger("main");
  Neo4Dart.init("127.0.0.1").then((Neo4Dart root) {
    LOG.info('Running Neo4J server v${root.version.number}');
    root.nodes.get(1).then((Node movie) {
      movie.relations.getAll(types: ['ACTED_IN']).then((List<RelationShip> relationShips) {
        LOG.info("${relationShips.length} actors played in this ${movie.properties['title']}");
        relationShips.forEach((RelationShip relation) {
          relation.getStart().then((Node actor) {
            LOG.info("${actor.properties['name']} as ${relation.properties['roles']}");
          });
        });
      });
    });
  });
}





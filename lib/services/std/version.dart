part of neo4dart;

/**
 * This is not a real endpoint but it acts as. It only returns the current version of the Neo4J's version 
 */
class Version implements Service {
  
  String _number;

  String get number => _number;
  
  Version(this._number);
}
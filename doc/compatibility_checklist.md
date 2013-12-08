#REST Api compatibility check list

This check list is based on the [REST api documentation](http://docs.neo4j.org/chunked/snapshot/rest-api.html) of Neo4j 2.0 snapshot 
  
  
###Done

###In progress
- 20.2.1. Get service root  
- 20.6.1. Create node
- 20.9.1. Set property on node
  
###To do
- 20.1.1. Begin a transaction  
- 20.1.2. Execute statements in an open transaction  
- 20.1.3. Execute statements in an open transaction in REST format for the return  
- 20.1.4. Reset transaction timeout of an open transaction  
- 20.1.5. Commit an open transaction  
- 20.1.6. Rollback an open transaction  
- 20.1.7. Begin and commit a transaction in one request  
- 20.1.8. Return results in graph format  
- 20.1.9. Handling errors  
  
- 20.3 Streaming  
  
- 20.4.1. Use parameters  
- 20.4.2. Create a node  
- 20.4.3. Create a node with multiple properties  
- 20.4.4. Create mutiple nodes with properties  
- 20.4.5. Set all properties on a node using Cypher  
- 20.4.6. Send a query  
- 20.4.7. Return paths  
- 20.4.8. Nested results  
- 20.4.9. Retrieve query metadata  
- 20.4.10. Errors  

- 20.5.1. Arrays
- 20.5.2. Property keys
- 20.5.3. List all property keys

- 20.6.2. Create node with properties
- 20.6.3. Get node
- 20.6.4. Get non-existent node
- 20.6.5. Delete node
- 20.6.6. Nodes with relationships cannot be deleted

- 20.7.1. Get Relationship by ID
- 20.7.2. Create relationship
- 20.7.3. Create a relationship with properties
- 20.7.4. Delete relationship
- 20.7.5. Get all properties on a relationship
- 20.7.6. Set all properties on a relationship
- 20.7.7. Get single property on a relationship
- 20.7.8. Set single property on a relationship
- 20.7.9. Get all relationships
- 20.7.10. Get incoming relationships
- 20.7.11. Get outgoing relationships
- 20.7.12. Get typed relationships
- 20.7.13. Get relationships on a node without relationships

- 20.8.1. Get relationship types

- 20.9.2. Update node properties
- 20.9.3. Get properties for node
- 20.9.4. Property values can not be null
- 20.9.5. Property values can not be nested
- 20.9.6. Delete all properties from node
- 20.9.7. Delete a named property from a node

- 20.10.1. Update relationship properties
- 20.10.2. Remove properties from a relationship
- 20.10.3. Remove property from a relationship
- 20.10.4. Remove non-existent property from a relationship
- 20.10.5. Remove properties from a non-existing relationship
- 20.10.6. Remove property from a non-existing relationship

- 20.11.1. Adding a label to a node
- 20.11.2. Adding multiple labels to a node
- 20.11.3. Adding a label with an invalid name
- 20.11.4. Replacing labels on a node
- 20.11.5. Removing a label from a node
- 20.11.6. Listing labels for a node
- 20.11.7. Get all nodes with a label
- 20.11.8. Get nodes by label and property
- 20.11.9. List all labels

- 20.12.1. Create index
- 20.12.2. List indexes for a label
- 20.12.3. Drop index

- 20.13.1. Create uniqueness constraint
- 20.13.2. Get a specific uniqueness constraint
- 20.13.3. Get all uniqueness constraints for a label
- 20.13.4. Get all constraints for a label
- 20.13.5. Get all constraints
- 20.13.6. Drop constraint

- 20.14.1. Traversal using a return filter
- 20.14.2. Return relationships from a traversal
- 20.14.3. Return paths from a traversal
- 20.14.4. Traversal returning nodes below a certain depth
- 20.14.5. Creating a paged traverser
- 20.14.6. Paging through the results of a paged traverser
- 20.14.7. Paged traverser page size
- 20.14.8. Paged traverser timeout

- 20.15.1. Find all shortest paths
- 20.15.2. Find one of the shortest paths
- 20.15.3. Execute a Dijkstra algorithm and get a single path
- 20.15.4. Execute a Dijkstra algorithm with equal weights on relationships
- 20.15.5. Execute a Dijkstra algorithm and get multiple paths

- 20.16.1. Execute multiple operations in batch
- 20.16.2. Refer to items created earlier in the same batch job
- 20.16.3. Execute multiple operations in batch streaming

- 20.17.1. Create node index
- 20.17.2. Create node index with configuration
- 20.17.3. Delete node index
- 20.17.4. List node indexes
- 20.17.5. Add node to index
- 20.17.6. Remove all entries with a given node from an index
- 20.17.7. Remove all entries with a given node and key from an index
- 20.17.8. Remove all entries with a given node, key and value from an index
- 20.17.9. Find node by exact match
- 20.17.10. Find node by query

- 20.18.1. Get or create unique node (create)
- 20.18.2. Get or create unique node (existing)
- 20.18.3. Create a unique node or return fail (create)
- 20.18.4. Create a unique node or return fail (fail)
- 20.18.5. Add an existing node to unique index (not indexed)
- 20.18.6. Add an existing node to unique index (already indexed)
- 20.18.7. Get or create unique relationship (create)
- 20.18.8. Get or create unique relationship (existing)
- 20.18.9. Create a unique relationship or return fail (create)
- 20.18.10. Create a unique relationship or return fail (fail)
- 20.18.11. Add an existing relationship to a unique index (not indexed)
- 20.18.12. Add an existing relationship to a unique index (already indexed)

- 20.19.1. Find node by exact match from an automatic index
- 20.19.2. Find node by query from an automatic index

- 20.20.1. Create an auto index for nodes with specific configuration
- 20.20.2. Create an auto index for relationships with specific configuration
- 20.20.3. Get current status for autoindexing on nodes
- 20.20.4. Enable node autoindexing
- 20.20.5. Lookup list of properties being autoindexed
- 20.20.6. Add a property for autoindexing on nodes
- 20.20.7. Remove a property for autoindexing on nodes

###Won't be done
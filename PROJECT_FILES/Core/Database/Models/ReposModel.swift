import CoreData

protocol IRepos {
    var name: String? { get set }
}

class ReposModel: NSManagedObject, Identifiable, IRepos {
    @NSManaged var name: String?
    
    static func create(dataStore: IDataStore,
                       context: NSManagedObjectContext?) throws -> ReposModel {
        let _context = context ?? dataStore.context
        let result: ReposModel = try dataStore.create(context: _context)
        return result
    }
    
    static func fetch(dataStore: IDataStore) async throws -> [ReposModel]? {
        let result: [ReposModel]? = try await fetch(dataStore: dataStore,
                                                    sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)],
                                                    predicate: nil,
                                                    context: nil,
                                                    fetchLimit: nil, offset: nil)
        
        return result
    }
    
    static func fetch(dataStore: IDataStore,
                      sortDescriptors: [NSSortDescriptor]?,
                      predicate: NSPredicate?,
                      context: NSManagedObjectContext?,
                      fetchLimit: Int?,
                      offset: Int?) async throws -> [ReposModel]? {
        var result: [ReposModel]?

        guard let context = context else {
            result = try await dataStore.fetch(sortDescriptors: sortDescriptors,
                                               predicate: predicate,
                                               context: dataStore.context,
                                               fetchLimit: fetchLimit,
                                               offset: offset)
            return result
        }

        result = try await dataStore.fetch(sortDescriptors: sortDescriptors,
                                           predicate: predicate,
                                           context: context,
                                           fetchLimit: fetchLimit,
                                           offset: offset)
        return result
    }
}

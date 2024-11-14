import CoreData

enum DataStoreError: Error {
    case invalidData
    case invalidContext
    case invalidEntity
    case initError
}

enum PreferedContext {
    case main, background
}

protocol IDataStore {
    var context: NSManagedObjectContext { get }
    var backgroundContext: NSManagedObjectContext { get }

    func fetch<T>(sortDescriptors: [NSSortDescriptor]?,
                  predicate: NSPredicate?,
                  context: NSManagedObjectContext?,
                  fetchLimit: Int?,
                  offset: Int?) async throws -> [T] where T: NSManagedObject
    func fetchSingle<T>(context: NSManagedObjectContext?) async throws -> T where T: NSManagedObject
    func create<T>(context: NSManagedObjectContext) throws -> T where T: NSManagedObject
    func save(context: NSManagedObjectContext?) throws
}

extension IDataStore {
    
    func fetch<T>(sortDescriptors: [NSSortDescriptor]? = nil,
                  predicate: NSPredicate? = nil,
                  context: NSManagedObjectContext? = nil,
                  fetchLimit: Int? = nil,
                  offset: Int? = nil) async throws -> [T] where T: NSManagedObject {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.sortDescriptors = sortDescriptors
        request.predicate = predicate
        if let fetchLimit = fetchLimit {
            request.fetchLimit = fetchLimit
        }
        if let offset = offset {
            request.fetchOffset = offset
        }
        let result = try (context?.fetch(request) ?? self.context.fetch(request))
        return result
    }

    func fetchSingle<T>(context: NSManagedObjectContext? = nil) async throws -> T where T: NSManagedObject {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        let _context = context ?? self.context

        let results = try _context.fetch(request)
        guard let first = results.first else {
            return try self.create(context: _context)
        }
        return first
    }

    func create<T>(context: NSManagedObjectContext) throws -> T where T: NSManagedObject {
        guard let entity = NSEntityDescription.entity(forEntityName: String(describing: T.self),
                                                      in: context) else {
            throw DataStoreError.invalidEntity
        }

        return T(entity: entity, insertInto: context)
    }

    func save(context: NSManagedObjectContext? = nil) throws {
        let newContext: NSManagedObjectContext? = context ?? self.context
        if newContext?.hasChanges ?? false {
            try newContext?.save()
        }
    }
}

final class DataStore: IDataStore {

    // MARK: - Properties

    private let persistentContainer: NSPersistentContainer
    private(set) var isPersistentContainerLoaded = false

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private(set) lazy var backgroundContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()

    static let shared: DataStore = {
        let store = DataStore()
        return store
    }()
    
    // MARK: - Init

    convenience init() {
        self.init(modelName: "AppDatabase")
    }
    
    init(name: String,
         model: NSManagedObjectModel,
         typeOf: String = NSSQLiteStoreType) {
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = typeOf
        
        persistentContainer = NSPersistentContainer(name: name, managedObjectModel: model)
        persistentContainer.persistentStoreDescriptions = [persistentStoreDescription]
        persistentContainer.loadPersistentStores { [weak self] _, error in
            guard error == nil else {
                self?.isPersistentContainerLoaded = false
                print("Failed to load CoreData: \(error?.localizedDescription ?? "")")
                return
            }
            
            self?.isPersistentContainerLoaded = true
        }
        
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    init(modelName: String,
         typeOf: String = NSSQLiteStoreType) {
        
        let modelURL = Bundle(for: type(of: self)).url(forResource: modelName,
                                                       withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)!
    
        let storeURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            .appendingPathComponent("\(modelName).sqlite")
        
        let storeDescription = NSPersistentStoreDescription(url: storeURL)
        storeDescription.type = typeOf
        
        persistentContainer = NSPersistentContainer(name: modelName,
                                                    managedObjectModel: managedObjectModel)
        persistentContainer.persistentStoreDescriptions = [storeDescription]
        persistentContainer.loadPersistentStores { [weak self] description, error in
            guard error == nil else {
                self?.isPersistentContainerLoaded = false
                print("Failed to load CoreData: \(error?.localizedDescription ?? "")")
                return
            }
            
            self?.isPersistentContainerLoaded = true
        }
        
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
}

import Foundation

extension Bundle {
    
    var appIdentifier: String {
        "com.appgroup.sample"
    }

    var groupIdentifier: String {
        "group." + appIdentifier
    }

    var persistenceContainerName: String {
        "AppDatabase"
    }
}

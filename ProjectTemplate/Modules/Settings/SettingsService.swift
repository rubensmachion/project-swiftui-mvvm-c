import Foundation

protocol SettingsServiceProcotol {
    func fetch(result: @escaping (_ response: Bool) -> Void)
}

final class SettingsService: SettingsServiceProcotol {

    func fetch(result: @escaping (Bool) -> Void) {
        result(true)
    }
}

import Foundation

protocol SettingDetailServiceProcotol {
    func fetch(result: @escaping (_ response: Bool) -> Void)
}

final class SettingDetailService: SettingDetailServiceProcotol {

    func fetch(result: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            result(true)
        }
    }
}

import Foundation

protocol HomeServiceProcotol {
    func fetch(result: @escaping (_ response: Bool) -> Void)
}

final class HomeService: HomeServiceProcotol {

    func fetch(result: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            result(true)
        }
    }
}

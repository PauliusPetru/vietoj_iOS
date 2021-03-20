import Foundation

func delay(_ time: Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        closure()
    }
}

func asyncOnMain(closure: @escaping ()->()) {
    DispatchQueue.main.async {
        closure()
    }
}

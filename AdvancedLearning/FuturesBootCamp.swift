//
//  FuturesBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 25/12/2023.
//

import SwiftUI
import Combine
// download with Combine
// download with @escaping closure
// convert @escaping to Combine

class FuturesBootCampViewModel: ObservableObject {
    
    @Published var title: String = "Starting Title"
    let url = URL(string: "https://www.google.com")!
    var cancallables = Set<AnyCancellable>()
    
    init() {
        download()
    }
    
    func download() {
//        getCombinePublisher()
//            .sink { _ in
//                
//            } receiveValue: { [weak self] returnedValue in
//                self?.title = returnedValue
//            }
//            .store(in: &cancallables)
//        getEscapingClosure { [weak self] returnedValue, error in
//            self?.title = returnedValue
//        }
        getFuturePublisher()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedValue in
                self?.title = returnedValue
            }
            .store(in: &cancallables)
    }
    
    func getCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map({ _ in
                return "New Value"
            })
            .eraseToAnyPublisher()
    }
    
    func getEscapingClosure(completionHandler: @escaping (_ returnedValue: String, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completionHandler("New value 2", nil)
        }
        .resume()
    }
    
    func getFuturePublisher() -> Future<String, Error> {
        return Future { promise in
            self.getEscapingClosure { returnedValue, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(returnedValue))
                }
            }
        }
    }
    
    func doSomething(completionHandler: @escaping (_ value: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completionHandler("New String")
        }
    }
    
    func doSomethingInTheFuture() -> Future<String, Never> {
        Future { promise in
            self.doSomething { value in
                promise(.success(value))
            }
        }
    }
    
}

struct FuturesBootCamp: View {
    
    @StateObject private var vm = FuturesBootCampViewModel()
    
    var body: some View {
        Text(vm.title)
    }
}

#Preview {
    FuturesBootCamp()
}

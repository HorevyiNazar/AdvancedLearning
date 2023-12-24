//
//  AdvancedCombineBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 14/12/2023.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    
//1    @Published var basicPublisher: String = "first publish"
//2    let currentValuePublisher = CurrentValueSubject<String, Error>("first publish")
    
    let passThroughPublisher = PassthroughSubject<Int, Error>()
    let boolPublisher = PassthroughSubject<Bool, Error>()
    let intPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        
        let items: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                self.passThroughPublisher.send(items[x])
                //2self.currentValuePublisher.send(items[x])
                //1self.basicPublisher = items[x]
                
                if (x > 4 && x < 8) {
                    self.boolPublisher.send(true)
                    self.intPublisher.send(999)
                } else {
                    self.boolPublisher.send(false)
                }
                
                if x  == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                }
            }
        }
    }
    
}

class AdvancedCombineBootCampViewModel: ObservableObject {
    
    @Published var data: [String] = []
    @Published var bools: [Bool] = []
    @Published var error: String = ""
    let dataService = AdvancedCombineDataService()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
       
        
        // MARK: Sequance operations
        /*
            //.first()
            //.first(where: { $0 > 4 })
//            .tryFirst(where: { int in
//                
//                if int == 3 {
//                    throw URLError(.badServerResponse)
//                }
//                return int > 1
//            })
            //.last()
            //.last(where: { $0 > 4 })
//            .tryLast(where: { Int in
//                if Int == 13 {
//                    throw URLError(.badServerResponse)
//                }
//                return Int > 1
//            })
//            .dropFirst()
//            .dropFirst(3)
            //.drop(while: { $0 < 5 })
//            .tryDrop(while: { Int in
//                if Int == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return Int < 6
//            })
//            .prefix(4)
//            .prefix(while: { $0 < 5 })
//            .tryPrefix(while: <#T##(Int) throws -> Bool#>)
//            .output(at: 5)
//            .output(in: 2..<4)
        
         
         */
        
        // MARK: Math operations
        /*
        //            .max()
//            .max(by: { $0 < $1 })
//            .tryMax(by: )
//            .min()
//            .min(by: )
//            .tryMin(by: )
        */
        
        // MARK: Filterting / Reducing Operations
        /*
//            .map({ String($0) })
//            .tryMap({ int in
//                if int == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return String(int)
//            })
//            .compactMap({ Int in
//                if Int == 5 {
//                    return nil
//                }
//                return String(Int)
//            })
//            .tryCompactMap()
//            .filter({ ($0 > 3) && ($0 < 7) })
//            .tryFilter()
//            .removeDuplicates()
//            .removeDuplicates(by: { $0 == $1 })
//            .tryRemoveDuplicates(by: )
//            .replaceNil(with: 5)
//            .replaceEmpty(with: [])
//            .replaceError(with: "DEAFUALT VALUE")
//            .scan(0, { $0 + $1 }) // .scan(0, +)
//            .tryScan(0, )
//            .reduce(0, +)
//            .allSatisfy({ $0 < 50 })
//            .tryAllSatisfy()
        */
        
        // MARK: Timing operations
        /*
//            .debounce(for: 1, scheduler: DispatchQueue.main)
//            .delay(for: 2, scheduler: DispatchQueue.main)
//            .measureInterval(using: DispatchQueue.main)
//            .throttle(for: 5, scheduler: DispatchQueue.main, latest: true)
//            .retry(3)
//            .timeout(0.75, scheduler: DispatchQueue.main)
        */
        
        // MARK: Multiple Publishers / Subscribers
        /*
//            .merge(with: dataService.intPublisher)
//            .zip(dataService.boolPublisher, dataService.intPublisher)
//            .map({ tuple in
//                return String(tuple.0) + tuple.1.description + String(tuple.2)
//            })
//            .tryMap({ int in
//                if int == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                return int
//            })
//            .catch({ error in
//                return self.dataService.intPublisher
//            })
        */
        
        
        let sharedPublisher = dataService.passThroughPublisher
            .share()
            .multicast {
                PassthroughSubject<Int, Error>()
            }
        
        sharedPublisher
            .map({ String($0) })
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error): self.error = "ERROR: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue)
            }
            .store(in: &cancellables)
        
        sharedPublisher
            .map({ $0 > 5 ? true : false })
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error): self.error = "ERROR: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] returnedValue in
                self?.bools.append(returnedValue)
            }
            .store(in: &cancellables)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            sharedPublisher
                .connect()
                .store(in: &self.cancellables)
        }
    }
    
}

struct AdvancedCombineBootCamp: View {
    
    @StateObject private var vm = AdvancedCombineBootCampViewModel()
    
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    ForEach(vm.data, id: \.self) {
                        Text($0)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    if !vm.error.isEmpty {
                        Text(vm.error)
                    }
                }
                VStack {
                    ForEach(vm.bools, id: \.self) {
                        Text($0.description)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    AdvancedCombineBootCamp()
}

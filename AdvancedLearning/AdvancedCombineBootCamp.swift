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
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        
        let items: [Int] = Array(0..<11)
        
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                self.passThroughPublisher.send(items[x])
                //2self.currentValuePublisher.send(items[x])
                //1self.basicPublisher = items[x]
                
                if x  == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                }
            }
        }
    }
    
}

class AdvancedCombineBootCampViewModel: ObservableObject {
    
    @Published var data: [String] = []
    @Published var error: String = ""
    let dataService = AdvancedCombineDataService()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.passThroughPublisher
        
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
        
            .map({ String($0) })
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error): self.error = "\(error.localizedDescription)"
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue)
            }
            .store(in: &cancellables)

    }
    
}

struct AdvancedCombineBootCamp: View {
    
    @StateObject private var vm = AdvancedCombineBootCampViewModel()
    
    var body: some View {
        ScrollView {
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
        }
    }
}

#Preview {
    AdvancedCombineBootCamp()
}

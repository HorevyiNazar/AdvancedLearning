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
    
    let passThroughPublisher = PassthroughSubject<String, Error>()
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        
        let items = ["One", "Two", "Three"]
        
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                self.passThroughPublisher.send(items[x])
                //2self.currentValuePublisher.send(items[x])
                //1self.basicPublisher = items[x]
            }
        }
    }
    
}

class AdvancedCombineBootCampViewModel: ObservableObject {
    
    @Published var data: [String] = []
    let dataService = AdvancedCombineDataService()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.passThroughPublisher
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error): print("ERROR \(error)")
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
            }
        }
    }
}

#Preview {
    AdvancedCombineBootCamp()
}

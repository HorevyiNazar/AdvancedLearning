//
//  TaskBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 08/02/2024.
//

import SwiftUI

class TaskBootCampViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil

    
    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        do {
            guard let url = URL(string: "https://via.placeholder.com/150") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run {
                self.image = UIImage(data: data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://via.placeholder.com/150") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run {
                self.image2 = UIImage(data: data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

struct TaskBootCampHomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                NavigationLink("Clike me") {
                    TaskBootCamp()
                }
            }
        }
    }
}

struct TaskBootCamp: View {
    
    @StateObject private var vm = TaskBootCampViewModel()
    @State private var fetchImageTask: Task<(), Never>? = nil
    
    var body: some View {
        VStack(spacing: 40, content: {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            if let image2 = vm.image2 {
                Image(uiImage: image2)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        })
        .task {
            await vm.fetchImage()
            await vm.fetchImage2()
        }
//        .onAppear(perform: {
//            fetchImageTask = Task {
//                await vm.fetchImage()
//            }
//            Task {
//                try? await Task.sleep(nanoseconds:2_000_000_000)
//                await vm.fetchImage2()
//            }
//        })
//        .onDisappear(perform: {
//            fetchImageTask?.cancel()
//        })
    }
}

#Preview {
    TaskBootCampHomeView()
}

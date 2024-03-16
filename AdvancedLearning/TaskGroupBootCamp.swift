//
//  TaskGroupBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 16/03/2024.
//

import SwiftUI

class TaskGroupBootCampDataManager {
    
    func fetchImagesWithAsyncLet() async throws -> [UIImage] {
        async let fetchImage1 = fetchImage(urlString: "https://via.placeholder.com/150")
        async let fetchImage2 = fetchImage(urlString: "https://via.placeholder.com/150")
        async let fetchImage3 = fetchImage(urlString: "https://via.placeholder.com/150")
        async let fetchImage4 = fetchImage(urlString: "https://via.placeholder.com/150")
        
        let (image1, image2, image3, image4) = await ( try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4)
        return [image1, image2, image3, image4]

    }
    
    func fetchImagesWithTaskGroup() async throws -> [UIImage] {
        let urlStrings = [
            "https://via.placeholder.com/150",
            "https://via.placeholder.com/150",
            "https://via.placeholder.com/150",
            "https://via.placeholder.com/150",
            "https://via.placeholder.com/150",
        ]
        return try await withThrowingTaskGroup(of: UIImage?.self) { group in
            var images: [UIImage] = []
            images.reserveCapacity(urlStrings.count)
            
            for urlString in urlStrings {
                group.addTask {
                    try? await self.fetchImage(urlString: urlString)
                }
            }
            
//            group.addTask {
//                try await self.fetchImage(urlString: "https://via.placeholder.com/150")
//            }
//            group.addTask {
//                try await self.fetchImage(urlString: "https://via.placeholder.com/150")
//            }
//            group.addTask {
//                try await self.fetchImage(urlString: "https://via.placeholder.com/150")
//            }
//            group.addTask {
//                try await self.fetchImage(urlString: "https://via.placeholder.com/150")
//            }
            
            for try await image in group {
                if let image = image {
                    images.append(image)
                }
            }
            
            return images
        }
    }
    
    private func fetchImage(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError.init(.badURL)
            }
        } catch  {
            throw error
        }
    }
}

class TaskGroupBootCampViewModel: ObservableObject {
    
    @Published var images: [UIImage] = []
    let manager = TaskGroupBootCampDataManager()
    
    func getImages() async {
        if let images = try? await manager.fetchImagesWithTaskGroup() {
            self.images.append(contentsOf: images)
        }
    }
    
}

struct TaskGroupBootCamp: View {
    
    @StateObject private var vm = TaskGroupBootCampViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(vm.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                })
            }
            .navigationTitle("Task Group")
            .task {
                await vm.getImages()
            }
        }
    }
}

#Preview {
    TaskGroupBootCamp()
}

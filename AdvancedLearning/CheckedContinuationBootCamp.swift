//
//  CheckedContinuation.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 26/03/2024.
//

import SwiftUI

class CheckedContinuationBootCampNetworkManager {
    func getData(url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch  {
            throw error
        }
    }
    
    func getData2(url: URL) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    continuation.resume(returning: data)
                } else if let error = error{
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
            .resume()
        }
    }
    
    func getHeartImageFromDatabase(completionHandler: @escaping (_ image: UIImage) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            completionHandler(UIImage(systemName: "heart.fill")!)
        }
    }
    
    func getHeartImageFromDatabase() async -> UIImage {
        await withCheckedContinuation { continuation in
            getHeartImageFromDatabase { image in
                continuation.resume(returning: image)
            }
        }
    }
    
}


class CheckedContinuationBootViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let manager = CheckedContinuationBootCampNetworkManager()
    
    func getImage() async {
        guard let url = URL(string: "https://via.placeholder.com/150") else { return }
        do {
            let data = try await manager.getData2(url: url)
            
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.image = image
                }
            }
        } catch  {
            print("error")
        }
    }
    
    func getHeartImage() async {
        self.image = await manager.getHeartImageFromDatabase()
    }
}

struct CheckedContinuationBootCamp: View {
    
    @StateObject private var vm = CheckedContinuationBootViewModel()
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
//            await vm.getImage()
            await vm.getHeartImage()
        }
    }
}

#Preview {
    CheckedContinuationBootCamp()
}

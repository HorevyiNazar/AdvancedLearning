//
//  ErrorAlertBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 02/01/2024.
//

import SwiftUI

struct ErrorAlertBootCamp: View {
    
    @State private var alert: MyCustomAlert? = nil
    
    var body: some View {
        Button("Click me") {
            saveData()
        }
        .alert(alert?.title ?? "Error", isPresented: Binding(value: $alert), actions: {
            if let alert {
                getButtonForAlert(alert: alert)
            }
        }, message: {
            if let subtitle = alert?.subtitle {
                Text(subtitle)
            }
        })
    }
    
    @ViewBuilder
    private func getButtonForAlert(alert: MyCustomAlert) -> some View {
        switch alert {
        case .noInternetConnection:
            Button("OK") {}
        case .dataNotFound:
            Button("Retry") {}
        default:
            Button("Delete", role: .destructive) {}
        }
    }
    
    enum MyCustomError: Error, LocalizedError {
        case noInternetConnection
        case dataNotFound
        case urlError(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .noInternetConnection:
                return "Please check your connection"
            case .dataNotFound:
                return "Error loading data"
            case .urlError(error: let error):
                return "Error: \(error.localizedDescription)"
            }
        }
    }
    
    enum MyCustomAlert: Error, LocalizedError {
        case noInternetConnection
        case dataNotFound
        case urlError(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .noInternetConnection:
                return "Please check your connection"
            case .dataNotFound:
                return "Error loading data"
            case .urlError(error: let error):
                return "Error: \(error.localizedDescription)"
            }
        }
        
        var title: String {
            switch self {
            case .noInternetConnection:
                return "No connection"
            case .dataNotFound:
                return "No data"
            case .urlError(let error):
                return "Error"
            }
        }
        
        var subtitle: String? {
            switch self {
            case .noInternetConnection:
                return "Please check your connection"
            case .dataNotFound:
                return nil
            case .urlError(error: let error):
                return "Error: \(error.localizedDescription)"
            }
        }
    }
    
    private func saveData() {
        let isSuccesful: Bool = false
        
        if isSuccesful {
            // do smth
        } else {
            // error
//            let myError: Error = URLError(.badURL)
//            let myError: Error = MyCustomAlert.urlError(error: URLError(.badURL))
//            errorTitle = "Error occured"
            alert = .noInternetConnection
        }
    }
}

#Preview {
    ErrorAlertBootCamp()
}

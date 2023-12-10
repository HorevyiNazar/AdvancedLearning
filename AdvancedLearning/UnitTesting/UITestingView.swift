//
//  UnitTestingView.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 08/12/2023.
//

import SwiftUI

class UITestingBootCampViewModel: ObservableObject {
    let placeholderText: String = "Add your name..."
    @Published var textFieldText: String = ""
    @Published var currentUserIsSignedIn: Bool
    
    init(currentUserIsSignedIn: Bool) {
        self.currentUserIsSignedIn = currentUserIsSignedIn
    }
    
    func signUpButtonPressed() {
        guard !textFieldText.isEmpty else { return }
        currentUserIsSignedIn = true
    }
}

struct UnitTestingView: View {
    
    @StateObject private var vm: UITestingBootCampViewModel
    
    init(currentUserIsSignedIn: Bool) {
        _vm = StateObject(wrappedValue: UITestingBootCampViewModel(currentUserIsSignedIn: currentUserIsSignedIn))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .leading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            ZStack {
                if vm.currentUserIsSignedIn {
                    // content
                    SignedInHomeView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .trailing))
                }
                if !vm.currentUserIsSignedIn {
                    // content
                    signUpLayer
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                }
            }

        }
    }
}

#Preview {
    UnitTestingView(currentUserIsSignedIn: true)
}

extension UnitTestingView {
    private var signUpLayer: some View {
        VStack {
                       TextField(vm.placeholderText, text: $vm.textFieldText)
                           .font(.headline)
                           .padding()
                           .background(Color.white)
                           .clipShape(.rect(cornerRadius: 10))
                           .accessibilityIdentifier("SignUpTextField")
                       
                       Button(action: {
                           withAnimation(.spring()) {
                               vm.signUpButtonPressed()
                           }
                       }, label: {
                           Text("Sign up")
                               .font(.headline)
                               .padding()
                               .frame(maxWidth: .infinity)
                               .foregroundStyle(Color.white)
                               .background(.blue)
                               .clipShape(.rect(cornerRadius: 10))
                               .accessibilityIdentifier("SignUpButton")

                       })
                   }
    }
}

struct SignedInHomeView: View {
    
    @State private var showAllert: Bool = false
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20, content: {
                Button(action: {
                    showAllert.toggle()
                }, label: {
                    Text("Show welcome alert")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.white)
                        .background(.red)
                        .clipShape(.rect(cornerRadius: 10))
                })
                .accessibilityIdentifier("ShowAlertButton")
                .alert("Welcome Alert", isPresented: $showAllert) {}
                NavigationLink {
                    Text("Destination")
                } label: {
                    Text("Navigate")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.white)
                        .background(.blue)
                        .clipShape(.rect(cornerRadius: 10))
                }
                //.accessibilityIdentifier("NavigationLinkDestination")
            })
            .padding()
            .navigationTitle("Welcome")
            

        }
    }
}

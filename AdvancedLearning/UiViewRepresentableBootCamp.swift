//
//  UiViewRepresentableBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 19/11/2023.
//

import SwiftUI
// Convert a UIView from UIKit to SwiftUI
struct UiViewRepresentableBootCamp: View {
    @State private var text: String = ""
    var body: some View {
        VStack {
            Text(text)
            TextField("Type here...", text: $text)
                .frame(height: 55)
                .background(Color.gray)
            UITextFieldViewRepresentable(text: $text)
                .updatePlaceholder("New placeholder...")
                .frame(height: 55)
                .background(Color.gray)
        }
    }
}

#Preview {
    UiViewRepresentableBootCamp()
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    let color: UIColor
    
    init(text: Binding<String>, placeholder: String = "Default Placeholder", color: UIColor = .red) {
        self._text = text
        self.placeholder = placeholder
        self.color = color
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = getTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    // From SwiftUI to UIKit
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    private func getTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        let placeholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: color])
        textField.attributedPlaceholder = placeholder
        
        return textField
    }
    func updatePlaceholder(_ text: String) -> UITextFieldViewRepresentable {
        var viewRepresentable = self
        viewRepresentable.placeholder = text
        return viewRepresentable
    }
    // from UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
    }
}

struct BasicUIViewreporesentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

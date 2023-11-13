//
//  GenericsBootCamp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 13.11.2023.
//

import SwiftUI

struct StringModel {
    let info: String?
    
    func removeInfo() -> StringModel {
        StringModel(info: nil)
    }
}

struct GenericModel<CustomType> {
    let info: CustomType?
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}

class GenericsViewModel: ObservableObject {
    @Published var stringModel = StringModel(info: "Hello world")
    @Published var genericStringModel = GenericModel(info: "Hello World")
    @Published var genericBoolModel = GenericModel(info: true)
    func removeData() {
        stringModel = stringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
        genericStringModel = genericStringModel.removeInfo()
    }
}

struct GenericsBootCamp: View {
    
    @StateObject private var vm = GenericsViewModel()
    
    var body: some View {
        VStack {
            GenericView(content: Text("custom content"), title: "new view")
            Text(vm.genericStringModel.info ?? "no data")
            Text(vm.genericBoolModel.info?.description ?? "no data")
        }
        .onTapGesture {
            vm.removeData()
        }

    }
}

struct GenericView<T:View>: View {
    
    let content: T
    let title: String
    
    var body: some View {
        Text(title)
        content
    }
}

#Preview {
    GenericsBootCamp()
}

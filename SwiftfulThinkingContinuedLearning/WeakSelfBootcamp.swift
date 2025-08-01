//
//  WeakSelfBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Juan David Gutierrez Olarte on 30/07/25.
//

import SwiftUI




struct WeakSelfBootcamp: View {
    
    @AppStorage("count") var count: Int?
    
    init(){
        count = 0
    }
        
    var body: some View {
        NavigationStack {
            NavigationLink(value: "second", label: {
                Text("Navigate")
            })
            .navigationDestination(for: String.self) { tag in
                if tag == "second" {
                    WeakSelfSecondScreen()
                }
            }
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(
                    Color.green.clipShape(RoundedRectangle(cornerRadius: 10))
                )
            ,
 alignment: .topTrailing
        )
    }
}

@Observable class WeakSelfSecondScreenViewModel {
    
    var data: String? = nil
    
    init() {
        print("iniciatilze now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1,forKey: "count")
        getData()
        
    }
    deinit {
        print("Deinitialize now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1,forKey: "count")
    }
    func getData() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.data = "New Data"
        }
        
    }
    

    
}


struct WeakSelfSecondScreen: View {
    
    @State var vm = WeakSelfSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("second view")
                .font(.largeTitle)
                .foregroundStyle(.red)
        }
        if let data = vm.data {
            Text(data)
        }
    }
}


#Preview {
    WeakSelfBootcamp()
}

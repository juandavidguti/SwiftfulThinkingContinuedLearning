//
//  SubscriberBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Juan David Gutierrez Olarte on 1/08/25.
//

import SwiftUI
import Combine


class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    var cancellables = Set<AnyCancellable>()
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    @Published var showButton: Bool = false
    
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscribier()
    }
    
    func setUpTimer(){
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
//        onreceive is only for view, instead we use sink
            .sink { [weak self] _ in
                guard let self = self else {return}
                self.count += 1
//                if self.count >= 10 {
//                    for item in self.cancellables {
//                        item.cancel()
//                    }
//                }
            }
            .store(in: &cancellables)
    }
    
    
    func addTextFieldSubscriber() {
            $textFieldText
                .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // for search queries or filtering functionality is great
                .map { $0.count > 3 }
                .sink { [weak self] isValid in
                    self?.textIsValid = isValid
                }
                .store(in: &cancellables)
        }
    
    func addButtonSubscribier(){
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self = self else {return}
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}


struct SubscriberBootcamp: View {
    
    @State var vm = SubscriberViewModel()
    
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            Text(vm.textIsValid.description)
            TextField("Type something here...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay (
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundStyle(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0 :
                                    vm.textIsValid ? 0 : 1)
                        Image(systemName: "checkmark")
                            .foregroundStyle(.green)
                            .opacity(vm.textIsValid ? 1 : 0)
                    }
                    .font(.title)
                    .padding(.trailing)
                    , alignment: .trailing
                )
            
            Button(action: {}) {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(vm.showButton ? 1 : 0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .disabled(!vm.showButton)
        }
        .padding()
    }
}

#Preview {
    SubscriberBootcamp()
}

//
//  EscapingBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Juan David Gutierrez Olarte on 30/07/25.
//

import SwiftUI

@Observable class EscapingViewModel {
    
    var text: String = "Hello"
    
    func getData() {
        downloadData5  { [weak self] (returnedResult) in
            self?.text = returnedResult.data
        }
    }
    
    func downloadData() -> String {
        return "New Data"
    }
    
    func downloadData2(completionHandler: (_ data: String) -> ()) {
        completionHandler("New Data")
    }
    
    func downloadData3(completionHandler: @escaping (_ data: String) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            completionHandler("New Data")
        }
    }
    func downloadData4(completionHandler: @escaping (DownloadResult) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "New Data")
            completionHandler(result)
        }
    }
    func downloadData5(completionHandler: @escaping (DownloadCompletion)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "New Data")
            completionHandler(result)
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingBootcamp: View {
    
    @State var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .foregroundStyle(.blue)
            .fontWeight(.semibold)
            .onTapGesture {
                vm.getData()
            }
            
    }
}

#Preview {
    EscapingBootcamp()
}

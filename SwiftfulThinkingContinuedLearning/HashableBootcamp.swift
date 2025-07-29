//
//  HashableBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Juan David Gutierrez Olarte on 28/07/25.
//

import SwiftUI

struct MyCustomModel: Hashable {
    let title: String
    let subtitle: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(title + subtitle)
    }
}

struct HashableBootcamp: View {
    
    let data: [MyCustomModel] = [MyCustomModel(title: "ONE",subtitle: "yes"),
                                 MyCustomModel(title: "TWO",subtitle: "yes"),
                                 MyCustomModel(title: "THREE",subtitle: "yes"),
                                 MyCustomModel(title: "FOUR",subtitle: "yes"),
                                 MyCustomModel(title: "FIVE",subtitle: "yes")]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
//                ForEach(data) { item in
//                    Text(item.id)
//                        .font(.headline)
//                }
                ForEach(data, id: \.self) { item in
                    Text(item.hashValue.description)
                        .font(.headline)
                    Text(item.subtitle)
                    Text(item.title)
                }
            }
        }
    }
}

#Preview {
    HashableBootcamp()
}

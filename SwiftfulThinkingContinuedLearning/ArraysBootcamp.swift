//
//  ArraysBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Juan David Gutierrez Olarte on 28/07/25.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

@Observable class ArrayModificationViewModel {
    
    var dataArray: [UserModel] = []
    var filteredArray: [UserModel] = []
    var mappedArray: [String] = []
    
    init() {
        getUsers()
    }
    func getUsers() {
        let user1 = UserModel(name: "Juan", points: 5, isVerified: true)
        let user2 = UserModel(name: "Vale", points: 25, isVerified: false)
        let user3 = UserModel(name: "Paty", points: 20, isVerified: true)
        let user4 = UserModel(name: "Orlando", points: 4, isVerified: false)
        let user5 = UserModel(name: "Erika", points: 8, isVerified: true)
        let user6 = UserModel(name: "", points: 7, isVerified: false)
        let user7 = UserModel(name: "", points: 99, isVerified: true)
        let user8 = UserModel(name: "Emilio", points: 55, isVerified: false)
        let user9 = UserModel(name: "Jack", points: 111, isVerified: true)
        let user10 = UserModel(name: "Toulouse", points: 888, isVerified: false)
        self._dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10
        ])
    }
    func updateFilteredArray() {
        //sort
        /*
        filteredArray = dataArray
            .sorted { (user1, user2) -> Bool in // compare objects
            return user1.points > user2.points
        }
        filteredArray = dataArray.sorted(by: { $0.points > $1.points }) // shorter form for the code above.
         */
        
        //filter
        /*
        filteredArray = dataArray.filter({ user -> Bool in
            return user.name.contains(["i","a"]) // for filtering with several conditions
        })
        filteredArray = dataArray.filter( { $0.isVerified }) // cleaner form
        */
        
        //map
        /*
//        mappedArray = dataArray.map({ user -> String in
//            return user.name ?? "ERROR"
//        })
//        mappedArray = dataArray.map({$0.name}) // shorter version
        mappedArray = dataArray.compactMap({ user -> String? in
            return user.name
        })
        mappedArray = dataArray.compactMap({ $0.name }) // shorter versions
         */
        
//        let sort = dataArray.sorted { $0.points > $1.points }
//        let filter = dataArray.filter { $0.isVerified }
//        let map = dataArray.compactMap { $0.name }
        
        mappedArray = dataArray
            .sorted { $0.points > $1.points }
            .filter { $0.isVerified }
            .compactMap { $0.name }
    }
}


struct ArraysBootcamp: View {
    
    @State var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundStyle(.white)
//                    .padding()
//                    .background {
//                        Color.blue.clipShape(RoundedRectangle(cornerRadius: 10))
//                    }
//                    .padding(.horizontal)
//                }
                
            }
        }
    }
}

#Preview {
    ArraysBootcamp()
}

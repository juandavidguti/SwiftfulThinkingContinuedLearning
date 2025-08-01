//
//  DownloadWithCombine.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Juan David Gutierrez Olarte on 31/07/25.
//

import SwiftUI
import Combine

struct PostModel: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

@Observable class DownloadWithCombineViewModel {
    
    
    var posts: [PostModel] = []
    @ObservationIgnored var cancellable = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // Combine discussion:
        /*
        // 1. sign up for monthly subscription for package to be delivered
        // 2. the company would make teh package behind the scene
        // 3. receive the package at your front door
        // 4. make sure the box isn't damaged
        // 5. open and make sure the item is correct
        // 6. use the item!!
        // 7. cancellable at any time!
        
        // 1. create the publisher.
        // 2. subscribe publisher on background thread
        // 3. Receive on main thread
        // 4. tryMap (check that the data is good)
        // 5. decode (decode data into PostModels)
        // 6. Sink (put the item into our app)
        // 7. Store (cancel subscription if needed)
        */
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
//            .replaceError(with: []) // if you dont want to handle errors.
            .sink { completion in
                switch completion {
                    case .finished:
                        print("Completion :\(completion)")
                    case .failure(let error):
                        print("There was an error: \(error)") // show an alert in the screen to handle the error
                }
            } receiveValue: { [weak self] returnedPost in
                
                print("\(Thread.isMainThread)")
                print("\(Thread.current)")
                
                self?.posts = returnedPost
            }
            .store(in: &cancellable)

    }
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombine: View {
    
    @State var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

#Preview {
    DownloadWithCombine()
}

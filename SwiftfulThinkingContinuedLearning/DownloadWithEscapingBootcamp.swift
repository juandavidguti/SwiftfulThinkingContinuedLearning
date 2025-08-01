//
//  DownloadWithEscapingBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Juan David Gutierrez Olarte on 31/07/25.
//

import SwiftUI
/* HTTP response status codes
 informational responses 100-199
 successful responses 200-299
 redirects 300-399
 client errors 400-499
 server errors 500-599
 */

//struct PostModel: Codable, Identifiable {
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//}

@Observable class DownloadWithEscapingViewModel {
    
    var posts: [PostModel] = []
    
    init() {
        getPosts()
    }

    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        downloadData(fromURL: url) { returnedData in
            if let data = returnedData {
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else {
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPosts
                }
            } else {
                print("No data returned.")
            }
        }
        
    }
    
    // this func can be used across the app to download data from the internet.
    func downloadData(fromURL url: URL,completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data,response,error in
            
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error downloading data!")
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
            
        }
        .resume()
    }
    
}


struct DownloadWithEscapingBootcamp: View {
    
    @State var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack {
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
    DownloadWithEscapingBootcamp()
}

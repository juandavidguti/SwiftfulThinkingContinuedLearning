//
//  CacheBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Juan David Gutierrez Olarte on 3/08/25.
//

import SwiftUI

class CacheManager {
    static let instance = CacheManager() // singleton
    
    private init () { // useful for only initializing the singleton from this class
        
    }
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 megabytes
        return cache
    }() // NS means NextStep
    
    func add(image: UIImage, name: String)-> String{
        imageCache.setObject(image, forKey: name as NSString)
        return("Added to cache!")
        
    }
    
    func remove(name: String) -> String{
        imageCache.removeObject(forKey: name as NSString)
        return("Removed from cache!")
    }
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
    
}


class CacheViewModel: ObservableObject {
    
    let imageName: String = "juan-david"
    let manager = CacheManager.instance
    @Published var cachedImage: UIImage? = nil
    @Published var startingImage: UIImage? = nil
    @Published var infoMessage: String = ""
    
    init() {
        getImageFromAssetFolder()
    }
    
    func getImageFromAssetFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache(){
        guard let image = startingImage else {return}
        infoMessage = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache(){
        infoMessage = manager.remove(name: imageName)
    }
    
    func getFromCache(){
        
        if let returnedImage = manager.get(name: imageName) {
            cachedImage = returnedImage
            infoMessage = "Got image from Cache"
        } else {
            infoMessage = "Image not found in Cache"
        }
    }
    
}


struct CacheBootcamp: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Text(vm.infoMessage)
                    .font(.headline)
                    .foregroundStyle(.purple)
                HStack {
                    Button {
                        vm.saveToCache()
                    } label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    Button {
                        vm.removeFromCache()
                    } label: {
                        Text("Delete from Cache")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                Button {
                    vm.getFromCache()
                } label: {
                    Text("Get from Cache")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                Spacer()
                
            }
            .navigationTitle("Cache Bootcamp")
        }
    }
}

#Preview {
    CacheBootcamp()
}

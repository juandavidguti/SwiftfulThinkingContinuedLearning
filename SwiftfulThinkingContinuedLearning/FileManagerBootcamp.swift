//
//  FileManagerBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Juan David Gutierrez Olarte on 1/08/25.
//

import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    let folderName = "MyApp_Images"
    
    init () {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded () {
        guard
            let path = FileManager.default.urls(
                for: .cachesDirectory,
                in: .userDomainMask
            ).first?.appendingPathComponent(folderName)
                .path else {return}
        if !FileManager.default.fileExists(atPath: path){
            do {
                try FileManager.default
                    .createDirectory(
                        atPath: path,
                        withIntermediateDirectories: true,
                        attributes: nil
                    )
                print("success creating folder")
            } catch let error {
                print("error creating folder. \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager.default.urls(
                for: .cachesDirectory,
                in: .userDomainMask
            ).first?.appendingPathComponent(folderName)
                .path else {return}
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success delete folder")
        } catch let error {
            print("Error deleting folder \(error)")
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String{
        guard let data = image.jpegData(compressionQuality: 1),
        let path = getPathForImage(name: name)
        else {
            return("Error getting data.")
            
        } // % of compression
        
        do {
            try? data.write(to: path)
            print(path)
            return ("Success saving!")
        } catch let error {
            return ("Error saving. \(error)")
        }
        
    }
    
    func getImage(name: String) -> UIImage? {
        guard let path = getPathForImage(name: name)?.path,
              FileManager.default.fileExists(atPath: path) else {
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name:String) -> String{
        guard let path = getPathForImage(name: name)?.path,
              FileManager.default.fileExists(atPath: path) else {
            return ("Error getting path")
        }
        do {
            try FileManager.default.removeItem(atPath: path)
            return ("Successfully removed!")
        } catch let error {
            return("Error deleting image. \(error)")
        }
    }
    
    
    func getPathForImage(name: String) -> URL? {
        guard let path = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent(folderName)
            .appendingPathComponent("\(name)", conformingTo: .jpeg) else {
            print("Error getting path")
            return nil
        }
        return path
    }
    
}


class FileManagerViewModel: ObservableObject {
    @Published var image: UIImage? = nil // easier to use uimage in background
    let imageName: String = "juan-david"
    let manager = LocalFileManager.instance
    @Published var infoMessage: String = ""
    
    init() {
        getImageFromAssetFolder()
//        getImageFromFileManager()
    }
    
    func getImageFromAssetFolder() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager(){
        image = manager.getImage(name: imageName)
    }
    
    func saveImage(){
        guard let image = image else {return}
        infoMessage = manager.saveImage(image: image, name: imageName)
        
    }
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
    
}

struct FileManagerBootcamp: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                HStack {
                    Button{
                        vm.saveImage()
                    } label: {
                        Text("Save to FM")
                            .foregroundStyle(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    Button{
                        vm.deleteImage()
                    } label: {
                        Text("Delete from FM")
                            .foregroundStyle(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.red)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.purple)

                
                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

#Preview {
    FileManagerBootcamp()
}

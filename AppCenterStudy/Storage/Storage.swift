//
//  Storage.swift
//  AppCenterStudy
//
//  Created by 권오준 on 2022/05/01.
//

import Foundation

class Storage {
    
    private init() { }
    
    static func saveTodo(todo: [Todo], fileName: String) {
        let jsonEncoder = JSONEncoder()
        
        do {
            let encodedData = try jsonEncoder.encode(todo)
            guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let fileURL = documentDirectoryUrl.appendingPathComponent(fileName)
            print("fileURL: \(fileURL)")
            do {
                try encodedData.write(to: fileURL)
                print("Write Successed!")
            } catch let error as NSError {
                print("Write Error becuase \(error)!")
            }
        } catch {
            print("Write Error because \(error)!")
        }
        
    }
    
    static func loadTodo(fileName: String) -> [Todo]? {
        let jsonDecoder = JSONDecoder()
        
        do {
            guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
            let fileURL = documentDirectoryUrl.appendingPathComponent(fileName)
            
            let jsonData = try Data(contentsOf: fileURL, options: .mappedIfSafe)
            
            let decodedJson = try jsonDecoder.decode([Todo].self, from: jsonData)
            print("Load Successed!")
            return decodedJson
        } catch {
            print("Load Error because \(error)!")
            return nil
        }
    }
}

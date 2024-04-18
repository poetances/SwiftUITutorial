//
//  CoreDataTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/6.
//

import SwiftUI
import CoreData

struct KeyPathModel {

    var age = 12
}


struct CoreDataTutorial: View {
    var body: some View {
        Button("Create", action: createPersistentContainer).padding()

        Button("Read") {
            let container = NSPersistentContainer(name: "Model")
            container.loadPersistentStores { des, error in
                if let error {
                    fatalError("Error: \(error)")
                } else {
                    print("Load stores success")
                    readBooks(container: container)
                }
            }
        }
    }
}

extension CoreDataTutorial {
    func createPersistentContainer() {
        // 其中"Model"字符串就是我们建立的Model.xcdatamodeld文件。但是输入参数的时候，我们不需要（也不应该）输入.xcdatamodeld后缀。
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { des, error in
            if let error {
                fatalError("Error: \(error)")
            } else {
                print("Load stores success")
                parseEntities(container: container)
                // 创建book
                createBook(container: container,
                           name: "算法（第4版）",
                           isbm: "9787115293800",
                           pageCount: 636)
            }
        }
    }

    func parseEntities(container: NSPersistentContainer) {
        let entities = container.managedObjectModel.entities
        print("Entity count = \(entities.count)\n")
        for entity in entities {
            print("Entity: \(entity.name!)")
            for property in entity.properties {
                print("Property: \(property.name)")
            }
            print("")
        }
    }

    func createBook(container: NSPersistentContainer,
                            name: String, isbm: String, pageCount: Int) {
        let context = container.viewContext
        let book = NSEntityDescription.insertNewObject(forEntityName: "Book",
                                                        into: context) as! Book
        book.name = name
        book.isbm = isbm
        book.page = Int64(pageCount)
        if context.hasChanges {
            do {
                try context.save()
                print("Insert new book(\(name)) successful.")
            } catch {
                print("\(error)")
            }
        }
    }

    func readBooks(container: NSPersistentContainer) {
       let context = container.viewContext
       let fetchBooks = NSFetchRequest<Book>(entityName: "Book")
       do {
           let books = try context.fetch(fetchBooks)
           print("Books count = \(books.count)")
           for book in books {
               print("Book name = \(book.name!)")
           }
       } catch {

       }
   }
}

#Preview {
    CoreDataTutorial()
}

//
//  ContentView.swift
//  Project11BookwormNew
//
//  Created by bingyuan xu on 2020-06-13.
//  Copyright © 2020 bingyuan xu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var showingAddScreen = false
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true)]) var books: FetchedResults<Book>
  
  func removeRows(at offsets : IndexSet) {
    for offset in offsets {
      let book = books[offset]
      moc.delete(book)
    }
    try? moc.save()
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(books, id: \.self) { book in
          NavigationLink(destination: DetailView(book: book)) {
            EmojiRatingView(rating: book.rating)
              .font(.largeTitle)
            
            VStack(alignment: .leading) {
              Text(book.title ?? "Unknow Title")
                .font(.headline)
              Text(book.author ?? "Unknown Author")
                .foregroundColor(.secondary)
            }
          }
          
        }
        .onDelete(perform: removeRows)
      }
      .navigationBarTitle("Bookworm")
      .navigationBarItems(leading: EditButton(), trailing: Button(action: {
        self.showingAddScreen.toggle()
      }) {
        Image(systemName: "plus")
      })
        .sheet(isPresented: $showingAddScreen) {
          AddBookView().environment(\.managedObjectContext, self.moc)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

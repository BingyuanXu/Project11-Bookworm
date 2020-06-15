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
  @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
  
  var body: some View {
    NavigationView {
      List {
        ForEach(books, id: \.self) { book in
          NavigationLink(destination: Text(book.title ?? "Unknown Title")) {
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
      }
        
        
        
        
        
        
        
        .navigationBarTitle("Bookworm")
        .navigationBarItems(trailing: Button(action: {
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

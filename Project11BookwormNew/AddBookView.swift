//
//  AddBookView.swift
//  Project11BookwormNew
//
//  Created by bingyuan xu on 2020-06-13.
//  Copyright © 2020 bingyuan xu. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
  @Environment(\.managedObjectContext) var moc
  @Environment(\.presentationMode) var presentationMode   
  @State private var title = ""
  @State private var author = ""
  @State private var rating = 3
  @State private var genre = ""
  @State private var review = ""
  let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Name of book", text: $title)
          TextField("Author's name", text: $author)
          Picker("Genre", selection: $genre) {
            ForEach(genres, id: \.self){
              Text($0)
            }
          }
        }
        
        
        Section {
          RatingView(rating: $rating)
          TextField("Write a review", text: $review)
        }
        
        Section {
          Button("Save") {
            let book = Book(context: self.moc)
            book.author = self.author
            book.genre = self.genre
            book.id = UUID()
            book.rating = Int16(self.rating)
            book.review = self.review
            book.title = self.title
            
            try? self.moc.save()
            
            self.presentationMode.wrappedValue.dismiss()
          }
        }
      }
      .navigationBarTitle("Add Book")
    }
  }
}


struct AddBookView_Previews: PreviewProvider {
  static var previews: some View {
    AddBookView()
  }
}

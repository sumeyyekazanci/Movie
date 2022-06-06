//
//  MovieDetailView.swift
//  Movie
//
//  Created by Sümeyye Kazancı on 4.06.2022.
//

import SwiftUI

struct MovieDetailView: View {
    let searchItem: SearchListItem
    @ObservedObject var movieDetailVM = MovieDetailViewModel()
    
    var body: some View {
        let url = URL(string: movieDetailVM.movie.poster )
        VStack (alignment: .leading, spacing: 10){
            Text("\(movieDetailVM.movie.title)").font(.headline)
            
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }.frame(height: 200)
            
            Text("**Açıklama:** \(movieDetailVM.movie.plot)")
            Text("**Kategori:** \(movieDetailVM.movie.genre)")
            Text("**Süre:** \(movieDetailVM.movie.runtime)")
            Text("**Yıl:** \(movieDetailVM.movie.released)")
            Text("**Yönetmen:** \(movieDetailVM.movie.director)")
            Text("**Oyuncular:** \(movieDetailVM.movie.actors)")
            Text("**Dil:** \(movieDetailVM.movie.language)")
//            Text("**Puan:** \(movieDetailVM.movie.rated)")
            Spacer()
            
        }
        .padding()
        .onAppear{
            Task {
                await movieDetailVM.loadMovieDetails(id: searchItem.imdbID)
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(searchItem: SearchListItem())
    }
}

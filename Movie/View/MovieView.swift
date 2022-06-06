//
//  MovieView.swift
//  Movie
//
//  Created by Sümeyye Kazancı on 4.06.2022.
//

import SwiftUI
import ActivityIndicatorView

struct MovieView: View {
    @ObservedObject var movieVM = MovieViewModel()
    @State private var searchText = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                ActivityIndicatorView(isVisible: $movieVM.isSearching, type: .equalizer(count: 5))
                    .foregroundColor(.blue)
                    .frame(width: 90, height: 90, alignment: .center)
                
                if movieVM.movies.isEmpty {
                    VStack (alignment: .center, spacing: 10){
                        Image(systemName: "star")
                            .resizable()
                            .frame(maxWidth: 100, maxHeight: 100)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.blue)
                            .padding()
                        
                        Text("Bir film bulun")
                            .font(.headline)
                            .tracking(2)
                        Text("Arama sonuçlarıyla eşleşen filmler burada görüntülenecektir")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem()],spacing: 15, content: {
                            ForEach(movieVM.movies, id: \.self) { item in
                                HStack {
                                    AsyncImage(url: URL(string: item.poster)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    
                                    VStack(alignment: .leading, spacing: 10, content: {
                                        NavigationLink(destination: MovieDetailView(searchItem: item)) {
                                            Text(item.title ).bold()
                                        }
                                        
                                        
                                    }).transition(.asymmetric(insertion: .opacity, removal: .scale))
                                    
                                }.padding(.horizontal)
                                    .frame(width: 400, height: 100, alignment: .leading)
                                    .background(Color(.systemGray6))
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                
                            }
                        })
                    }
                }
                
            }
            .searchable(text: $searchText,prompt: "Film Ara")
            .onSubmit(of: .search){
                Task {
                    await movieVM.execQuery(for: searchText.lowercased())
                    if movieVM.movies.isEmpty {
                        showAlert = true
                    }
                }
            }
            .alert("Aramalarınıza uygun sonuç bulunamadı.", isPresented: $showAlert) {
                Button("Kapat", role: .cancel) { }
            }
            .navigationTitle("Filmler")
        }.navigationViewStyle(.stack)
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
    }
}

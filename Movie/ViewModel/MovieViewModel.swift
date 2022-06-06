//
//  MovieViewModel.swift
//  Movie
//
//  Created by Sümeyye Kazancı on 4.06.2022.
//

import Foundation

class MovieViewModel: ObservableObject {
    let urlString = "http://www.omdbapi.com/?apikey=e35a0efb"
    @Published var movies = [SearchListItem]()
    @Published var isSearching = false
    
    @MainActor
    func execQuery(for searchTerm: String) async {
        isSearching = true
        await searchMovie(searchText: searchTerm)
        isSearching = false
    }
    
    func searchMovie(searchText: String) async  {
        guard let url = URL(string: urlString + "&s=" + searchText) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data,_) = try await URLSession.shared.data(for: request)
            
            if let json = try? JSONDecoder().decode(SearchList.self, from: data) {
                DispatchQueue.main.async {
                    self.movies = json.Search
                    print(json)
                }
            }else {
                DispatchQueue.main.async {
                    self.movies.removeAll()
                }
            }
        }catch {
            print("error: \(error.localizedDescription)")
        }
    }
}

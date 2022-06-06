//
//  MovieDetailViewModel.swift
//  Movie
//
//  Created by Sümeyye Kazancı on 5.06.2022.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    let urlString = "http://www.omdbapi.com/?apikey=e35a0efb"
    @Published var movie = Movie()
    @Published var isLoading = false
    
    init() {
        
    }
    
    func loadMovieDetails(id: String) async {
        guard let url = URL(string: urlString + "&i=" + id) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data,_) = try await URLSession.shared.data(for: request)

            if let json = try? JSONDecoder().decode(Movie.self, from: data) {
                DispatchQueue.main.async {
                    self.movie = json
                    print(json)
                }
            }
        }catch {
            print("error: \(error.localizedDescription)")
        }
    }
}

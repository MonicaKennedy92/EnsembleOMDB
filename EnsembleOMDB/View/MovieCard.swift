//
//  MovieCard.swift
//  EnsembleOMDB
//
//  Created by Monica on 2024-07-24.
//

import SwiftUI

struct MovieCard: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                                if let posterURL = URL(string: movie.poster), movie.poster != "N/A" {
                                    AsyncImage(url: posterURL) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 150)
                                            .cornerRadius(8)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 100, height: 150)
                                    }
                                    .clipped()
                                    .cornerRadius(10)
                                } else {
                                    Rectangle()
                                        .fill(Color.gray)
                                        .frame(width: 100, height: 150)
                                        .cornerRadius(8)
                                }
                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(movie.title)
                                        .font(.headline)
                                    Text("Year: \(movie.year)")
                                        .font(.subheadline)
                                    Spacer()
                                    Button(action: {}) {
                                        Text("Action")
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                }
                                .padding(.leading, 10)

                Spacer()
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding([.horizontal, .bottom])
    }
}

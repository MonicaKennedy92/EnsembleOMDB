import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MovieListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ZStack(alignment: .trailing) {
                        TextField("Search movies", text: $viewModel.query)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .onChange(of: viewModel.query) {
                                viewModel.resetSearch()
                                viewModel.searchMovies(page: 1)
                            }
                              
                        if !viewModel.query.isEmpty {
                            Button(action: {
                                viewModel.query = ""
                                viewModel.resetSearch()
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 20)
                            }
                        }
                    }
                    .padding()
                }
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.movies) { movie in
                                MovieCard(movie: movie)
                                    .padding(.horizontal, 20)
                                    .padding(.top, 5)
                                    .padding(.bottom, 5)
                            }
                            if !viewModel.isLoading && viewModel.movies.count < viewModel.totalResults {
                                ProgressView()
                                    .padding()
                                    .onAppear {
                                        viewModel.loadMoreMovies()
                                    }
                            }
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("OMDB Search")
        }
    }
    
}

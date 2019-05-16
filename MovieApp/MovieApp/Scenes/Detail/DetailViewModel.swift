//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 13/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class DetailViewModel {
    
    // MARK: - Properties
    var movie: Movie = Movie()
    let movieCode: Int
    let movieService = MovieAPIManager()
    var coordinatorDelegate: DetailCoordinatorDelegate?
    weak var controllerDelegate: DetailViewControllerDelegate?
    
    // MARK: - Initialization methods
    init(_ movieCode: Int) {
        self.movieCode = movieCode
    }
    
    // MARK: - Public methods
    func reload() {
        controllerDelegate?.reload(.loading)
        
        movieService.getMovie(by: movieCode) {
            switch($0) {
            case .success(let result):
                self.movie = result
                self.controllerDelegate?.reload(.success(result))
            case .error(let string):
                self.controllerDelegate?.reload(.error(string))
            }
        }
    }
    
    func configure(_ view: DetailView) {
        let imagePath = movieService.getImagePath(movie.posterPath ?? "")
        view.imageView.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "placeholder"))
        view.titleLabel.text = movie.title ?? ""
        view.releaseDateLabel.text = getFormmatedDate()
        view.durationLabel.text = "\(movie.runtime ?? 0) min"
        view.averageVoteLabel.text = "Nota geral:"
        view.averageVoteNumberLabel.text = String(movie.voteAverage ?? 0.0)
        view.averageVoteProgressView.setProgress((movie.voteAverage ?? 0.0) / 10, animated: false)
        view.overviewLabel.text = movie.overview ?? ""
    }
    
    func back() {
        coordinatorDelegate?.back()
    }
    
    // MARK: - Private methods
    // TODO: - Melhorar soluçãos
    private func getFormmatedDate() -> String {
        let months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
        
        let year = movie.releaseDate?.split(separator: "-")[0] ?? "0000"
        let month = Int(movie.releaseDate?.split(separator: "-")[1] ?? "0") ?? 1
        let day = movie.releaseDate?.split(separator: "-")[2] ?? "1"
        
        return "\(day) de \(months[month - 1]) de \(year)"
    }
}

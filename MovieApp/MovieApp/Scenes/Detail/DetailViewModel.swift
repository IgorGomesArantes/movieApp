//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 13/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit
import SDWebImage

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
        
        if MovieEntity.isSaved(code: movie.id ?? 0) {
            
            view.titleLabel.backgroundColor = .red
            
        } else {
            save()
        }
    }
    
    func back() {
        coordinatorDelegate?.back()
    }
    
    func save() {
        let code = movie.id ?? 0
        let imagePath = movie.posterPath ?? ""
        
        MovieEntity.save(code: code, imagePath: imagePath)
    }
    
    // MARK: - Private methods
    // TODO: - Melhorar soluçãos
    private func getFormmatedDate() -> String {
        let months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
        
        guard let releaseDate = movie.releaseDate else { return "1 de \(months[0]) de 1900" }
        
        let releaseSplittedDate = releaseDate.split(separator: "-")
        
        if releaseSplittedDate.count != 3 { return "1 de \(months[0]) de 1900" }
        
        let year = releaseSplittedDate[0]
        let month = Int(releaseSplittedDate[1]) ?? 1
        let day = releaseSplittedDate[2]
        
        return "\(day) de \(months[month - 1]) de \(year)"
    }
}

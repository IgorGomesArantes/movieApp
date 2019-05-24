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
    var movie = Movie()
    var recomendations = [Movie]()
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
    
    func reloadRecomendations() {
        controllerDelegate?.reloadRecomendations(.loading)
        
        movieService.getSimilarMovies(code: movieCode) {
            switch $0 {
            case .success(let result):
                if result.results.isEmpty {
                    self.controllerDelegate?.reloadRecomendations(.empty)
                } else {
                    self.recomendations = result.results
                    self.controllerDelegate?.reloadRecomendations(.success(self.recomendations))
                }
                
            case .error(let string):
                self.controllerDelegate?.reloadRecomendations(.error(string))
            }
        }
    }
    
    func configure(_ view: DetailView) {
        let imagePath = movieService.getImagePath(movie.posterPath ?? "")
        let budget = getFormattedMoney(value: Float(movie.budget ?? 0))
        let revenue = getFormattedMoney(value: Float(movie.revenue ?? 0))
        
        view.imageView.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "placeholder"))
        view.titleLabel.text = movie.title ?? ""
        view.releaseDateLabel.text = getFormmatedDate()
        view.durationLabel.text = "\(movie.runtime ?? 0) min"
        view.averageVoteLabel.text = "Nota geral:"
        view.averageVoteNumberLabel.text = String(movie.voteAverage ?? 0.0)
        view.averageVoteProgressView.setProgress((movie.voteAverage ?? 0.0) / 10, animated: false)
        view.overviewLabel.text = movie.overview ?? ""
        view.budgetLabel.text = "Despesas:\t\(budget)"
        view.revenueLabel.text = "Receita:\t\(revenue)"
        
        if MovieEntity.isSaved(code: movie.id ?? 0) {
            view.check()
        } else {
            view.uncheck()
        }
    }
    
    func detail(_ index: Int) {
        let movieCode = recomendations[index].id ?? 0
        
        coordinatorDelegate?.detail(movieCode)
    }
    
    func back() {
        coordinatorDelegate?.back()
    }
    
    func saveOrRemove(_ view: DetailView) {
        let code = movie.id ?? 0
        let imagePath = movie.posterPath ?? ""
        
        let isSaved = MovieEntity.saveOrRemove(code: code, imagePath: imagePath)
        
        if isSaved {
            view.check()
        } else {
            view.uncheck()
        }
    }
    
    // MARK: - Cell configuration
    func configureCell(_ cell: RecomendationCell, index: Int) {
        let imagePath = movieService.getImagePath(recomendations[index].posterPath ?? "")
        let movieCode = recomendations[index].id ?? 0
        let voteAverare = recomendations[index].voteAverage ?? 0
        let title = recomendations[index].title ?? ""
        
        cell.setup(movieCode: movieCode, imagePath: imagePath, voteAverage: voteAverare, title: title)
    }
    
    // MARK: - Private methods
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
    
    private func getFormattedMoney(value: Float) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let valueString = currencyFormatter.string(from: NSNumber(value: value))!
        
        return valueString
    }
}

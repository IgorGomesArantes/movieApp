//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Igor Gomes Arantes on 13/05/19.
//  Copyright © 2019 Igor Gomes Arantes. All rights reserved.
//

import UIKit
import SDWebImage

protocol DetailViewModelDelegate: class {
    func detail(_ movieCode: Int)
    func back()
}

class DetailViewModel {
    
    // MARK: - Properties
    private let movieCode: Int
    private let movieService: MovieAPIManager
    
    private var model: DetailModel?
    private var recomendations: [Movie] = []
    
    weak var coordinatorDelegate: DetailViewModelDelegate?
    var onReloadDetails: ((ServiceStatus) -> Void)?
    var onReloadRecomendations: ((ServiceStatus) -> Void)?
    
    lazy var numberOfRecomendations: Int = {
        return recomendations.count
    } ()
    
    // MARK: - Initialization methods
    init(_ movieService: MovieAPIManager, movieCode: Int) {
        self.movieService = movieService
        self.movieCode = movieCode
    }
    
    deinit {
        debugPrint("Detail view model deinit")
    }
    
    // MARK: - Public methods
    func reload() {
        onReloadDetails?(.loading)
        
        movieService.getMovie(by: movieCode) { response in
            switch(response) {
            case .success(let result):
                self.model = self.movieToDetailModel(result)
                self.onReloadDetails?(.success)
                self.reloadRecomendations()
                
            case .error(let string):
                self.onReloadDetails?(.error(string))
            }
        }
    }
    
    func reloadRecomendations() {
        onReloadRecomendations?(.loading)
        
        movieService.getSimilarMovies(code: movieCode) {
            switch $0 {
            case .success(let result):
                if result.results.isEmpty {
                    self.onReloadRecomendations?(.empty)
                } else {
                    self.recomendations = result.results
                    self.onReloadRecomendations?(.success)
                }
                
            case .error(let string):
                self.onReloadRecomendations?(.error(string))
            }
        }
    }
    
    func configure(_ view: DetailView) {
        guard let model = model else { return }
        
        view.titleLabel.text = model.title
        view.durationLabel.text = model.runtime
        view.overviewLabel.text = model.overview
        view.averageVoteLabel.text = "Nota geral:"
        view.releaseDateLabel.text = model.releaseDate
        view.budgetLabel.text = "Despesas:\t\(model.budget)"
        view.revenueLabel.text = "Receita:\t\(model.revenue)"
        view.averageVoteNumberLabel.text = String(model.vote)
        view.averageVoteProgressView.setProgress((model.vote) / 10, animated: false)
        view.imageView.sd_setImage(with: URL(string: model.imageURL), placeholderImage: UIImage(named: "placeholder"))
        
        if MovieEntity.isSaved(code: model.code) {
            DispatchQueue.main.async {
                view.check()
            }
        } else {
            DispatchQueue.main.async {
                view.uncheck()
            }
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
        guard let model = model else { return }
        
        let code = model.code
        let imagePath = model.imageURL
        
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
    
    // MARK: - Format methods
    private func getFormmatedDate(_ date: String) -> String {
        let months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
        
        let splittedDate = date.split(separator: "-")
        if splittedDate.count != 3 { return "1 de \(months[0]) de 1900" }
        
        let year = splittedDate[0]
        let month = Int(splittedDate[1]) ?? 1
        let day = splittedDate[2]
        
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
    
    private func movieToDetailModel(_ movie: Movie) -> DetailModel {
        let code = movie.id ?? 0
        let vote = movie.voteAverage ?? 0.0
        let overview = movie.overview ?? ""
        let runtime = "\(movie.runtime ?? 0) min"
        let isSaved = MovieEntity.isSaved(code: code)
        let title = movie.title ?? "Título desconhecido"
        let releaseDate = getFormmatedDate(movie.releaseDate ?? "")
        let budget = getFormattedMoney(value: Float(movie.budget ?? 0))
        let imageURL = movieService.getImagePath(movie.posterPath ?? "")
        let revenue = getFormattedMoney(value: Float(movie.revenue ?? 0))
        
        return DetailModel(code: code, vote: vote, isSaved: isSaved, title: title, budget: budget, revenue: revenue, runtime: runtime, imageURL: imageURL, overview: overview, releaseDate: releaseDate)
    }
}

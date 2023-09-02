//
//  HomePageViewModel.swift
//  MedBook
//
//  Created by Gokul on 01/09/23.
//

import Foundation

protocol HomePageViewModelProtocol {
    typealias State = (Event) -> Void

    var eventHandler: State? { get set }
    
    func onViewDidLoad()
    var homePageListResponse: HomePageListResponse? { get set }
    
    func onSearch(searchText: String?)
}

final class HomePageViewModel: HomePageViewModelProtocol {
    
    var eventHandler: State?
    private let coreDataManager: CoreDataManager
    private let apiManager: ApiManager
    var homePageListResponse: HomePageListResponse?
    
    init(
        coreDataManager: CoreDataManager = CoreDataManager(),
        apiManager: ApiManager = ApiManager.shared
    ) {
        self.coreDataManager = coreDataManager
        self.apiManager = apiManager
    }
    
    func onSearch(searchText: String?) {
        homePageListResponse = nil
        fetchHomePageListResponse(searchText: searchText)
    }
    
    func onViewDidLoad() {
        
    }
    
}

private extension HomePageViewModel {
    
    func fetchHomePageListResponse(searchText: String?) {
        eventHandler?(.loading)
        fetchHomepageListItems(title: searchText, limit: 30) { [weak self] response in
            guard let self else { return }
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let response):
                self.homePageListResponse = response
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    func fetchHomepageListItems(title: String?, limit: Int, completion: @escaping (Result<HomePageListResponse, DataError>) -> ()) {
        var urlComponents = URLComponents(string: Assets.API.listApi)
        
        var queryItems = [URLQueryItem]()
        
        if let title = title {
            queryItems.append(URLQueryItem(name: "title", value: title))
        }
        queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else { return }
        apiManager.fetch(url: url, completion: completion)
    }
}

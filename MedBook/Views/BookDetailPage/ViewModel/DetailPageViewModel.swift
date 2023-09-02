//
//  DetailPageViewModel.swift
//  MedBook
//
//  Created by Gokul on 01/09/23.
//

import Foundation

protocol DetailPageViewModelProtocol {
    typealias State = (Event) -> Void

    var eventHandler: State? { get set }
    
    func onViewDidLoad()
    var homePageListResponse: HomePageListResponse? { get set }
}

final class DetailPageViewModel: DetailPageViewModelProtocol {
    
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
    
    func onViewDidLoad() {
        
    }
    
}

private extension DetailPageViewModel {
    
}

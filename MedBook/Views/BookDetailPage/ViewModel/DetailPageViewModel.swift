//
//  DetailPageViewModel.swift
//  MedBook
//
//  Created by Gokul on 01/09/23.
//

import Foundation

protocol DetailPageViewModelProtocol {
    typealias State = (Event) -> Void
    var observer: DetailPageViewModelObserver? { get set }
    var eventHandler: State? { get set }
    func onViewDidLoad()
    var doc: Doc? { get set }
    var isBookMarked: Bool { get set }
    var detailPageResponse: BookDetailResponse? { get set }
    func isBookmarkPressed()
}

protocol DetailPageViewModelObserver: AnyObject {
    func bookMark(isBookMarked: Bool)
    func bookMarkStatus(result: Bool)
}

final class DetailPageViewModel: DetailPageViewModelProtocol {
    
    var detailPageResponse: BookDetailResponse?
    var eventHandler: State?
    private let coreDataManager: CoreDataManager
    private let apiManager: ApiManager
    var doc: Doc?
    var isBookMarked: Bool = false
    weak var observer: DetailPageViewModelObserver?
    
    init(
        doc: Doc?,
        coreDataManager: CoreDataManager = CoreDataManager(),
        apiManager: ApiManager = ApiManager.shared
    ) {
        self.doc = doc
        self.coreDataManager = coreDataManager
        self.apiManager = apiManager
    }
    
    func onViewDidLoad() {
        fetchDetailPageInfo(doc: doc)
    }
    
    func isBookmarkPressed() {
        guard let doc = doc else { return }
        let docKey = doc.key ?? ""
        // Define a closure to handle the completion result
        let completion: (Bool) -> Void = { success in
            if success {
                self.observer?.bookMarkStatus(result: true)
                self.isBookMarked = !self.isBookMarked
                self.observer?.bookMark(isBookMarked: self.isBookMarked)
            } else {
                self.observer?.bookMarkStatus(result: false)
            }
        }
        if isBookMarked {
            // Remove the bookmark
            BookMarkDataManager.shared.removeDocFromCoreData(docKey: docKey, completion: completion)
        } else {
            // Save the bookmark
            BookMarkDataManager.shared.saveDocToCoreData(doc: doc, completion: completion)
        }
    }
}

// MARK: - Api call
private extension DetailPageViewModel {
    
    func fetchDetailPageInfo(doc: Doc?) {
        eventHandler?(.loading)
        guard let key = doc?.key else { return }
        makeApiCall(key: key) { [weak self] response in
            guard let self else { return }
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let response):
                self.detailPageResponse = response
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    func makeApiCall(key: String, completion: @escaping (Result<BookDetailResponse, DataError>) -> ()) {
        let baseURL = Assets.API.detailApi
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path += key + ".json"
        if let url = urlComponents?.url {
            apiManager.fetch(url: url, completion: completion)
        } else {
            completion(.failure(.invalidURL))
        }
    }
}

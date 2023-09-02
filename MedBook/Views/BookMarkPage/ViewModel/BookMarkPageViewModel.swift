//
//  BookMarkPageViewModel.swift
//  MedBook
//
//  Created by Gokul on 02/09/23.
//

import Foundation

protocol BookMarkPageViewModelProtocol {
    typealias State = (Event) -> Void
    var eventHandler: State? { get set }
    func onViewDidLoad()
    var list: [Doc]? { get set }
    func removeAt(key: String)
}

protocol BookMarkPageViewModelObserver: AnyObject {
    func dataLoaded(list: [Doc]?)
    func reloadTableView()
}

final class BookMarkPageViewModel: BookMarkPageViewModelProtocol {
    
    var eventHandler: State?
    private let coreDataManager: CoreDataManager
    var list: [Doc]?
    weak var observer: BookMarkPageViewModelObserver?
    
    init(
        coreDataManager: CoreDataManager = CoreDataManager()
    ) {
        self.coreDataManager = coreDataManager
    }
    
    func onViewDidLoad() {
        eventHandler?(.loading)
        fetchListResponse()
    }
    
    func removeAt(key: String) {
        removeBookmark(key: key)
    }
}

private extension BookMarkPageViewModel {
    
    func removeBookmark(key: String) {
        BookMarkDataManager.shared.removeDocFromCoreData(docKey: key) { result in
            if result == true {
                self.fetchListResponse()
            }
        }
    }
    
    func fetchListResponse() {
        eventHandler?(.stopLoading)
        if let listData = BookMarkDataManager.shared.fetchAllDocsFromCoreData() {
            self.list = listData
            self.observer?.dataLoaded(list: self.list)
            self.observer?.reloadTableView()
            eventHandler?(.dataLoaded)
        }
    }
}

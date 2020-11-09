//
//  HomeViewModelTests.swift
//  Dictionary_RickAndMortyTests
//
//  Created by Rodrigo Martins on 09/11/20.
//

import XCTest
@testable import Dictionary_RickAndMorty

class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var repository: Repository!
    private var service: NetworkManager!
    private var disk: Storage!
    
    override func setUp() {
        super.setUp()
        self.service = MockNetworkService()
        self.disk = MockLocalStorage()
        self.repository = RepositoryImpl(network: service, disk: disk)
        self.viewModel = HomeViewModel(repository: repository)
    }

    override func tearDown() {
        self.viewModel = nil
        self.repository = nil
        self.service = nil
        self.disk = nil
        super.tearDown()
    }

    func testCharacterIsApiError(){
        self.viewModel.fetchCharacters { (result) in
            switch result {
            case .success(_):
                XCTAssert(false, "Nao deveria apresentar conteúdo")
            break
            default:
            break
            }
        }
    }
    
}

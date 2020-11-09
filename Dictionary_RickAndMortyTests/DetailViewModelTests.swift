//
//  DetailViewModelTests.swift
//  Dictionary_RickAndMortyTests
//
//  Created by Rodrigo Martins on 09/11/20.
//

import XCTest
@testable import Dictionary_RickAndMorty

class DetailViewModelTests: XCTestCase {

    var viewModel: DetailViewModel!
    var repository: Repository!
    private var service: NetworkManager!
    private var disk: Storage!
    
    private var tempModel = CharacterModel(id: 92,
                                           name: "Davin",
                                           status: "Dead",
                                           species: "Human",
                                           type: "",
                                           gender: "Male",
                                           origin: CharacterOriginModel(name: "Earth (C-137)",
                                                                        url: "https://rickandmortyapi.com/api/location/1"),
                                           location: CharacterLocationModel(name: "Earth (C-137)",
                                                                            url: "https://rickandmortyapi.com/api/location/1"),
                                           image: "https://rickandmortyapi.com/api/character/avatar/92.jpeg",
                                           episode: ["https://rickandmortyapi.com/api/episode/1",
                                                     "https://rickandmortyapi.com/api/episode/6"],
                                           url: "https://rickandmortyapi.com/api/character/92",
                                           created: "2017-12-01T11:20:51.247Z")

    
    override func setUp() {
        super.setUp()
        self.service = MockNetworkService()
        self.disk = MockLocalStorage()
        self.repository = RepositoryImpl(network: service, disk: disk)
        self.viewModel = DetailViewModel(repository: repository)
    }

    override func tearDown() {
        self.viewModel = nil
        self.repository = nil
        self.service = nil
        self.disk = nil
        super.tearDown()
    }

    func testCharacterToggleFavoriteSuccess(){
        self.viewModel.toggleFavorite(model: tempModel) { (result) in
            XCTAssertTrue(result, "A ação deveria adicionar da lista de favoritos")
        }
        
        self.viewModel.toggleFavorite(model: tempModel) { (result) in
            XCTAssertFalse(result, "A ação deveria remover da lista de favoritos")
        }
    }
    
    func testCharacterRetrieveSuccess(){
        self.viewModel.toggleFavorite(model: tempModel) { (result) in
            XCTAssertTrue(result, "A ação deveria adicionar da lista de favoritos")
        }
        
        self.viewModel.loadFavorite(byId: tempModel.id) { (result) in
            XCTAssertTrue(result, "A ação deveria encontrar o item favorito")
        }
    }
    
    func testCharacterRetrieveFail(){
        self.viewModel.loadFavorite(byId: tempModel.id) { (result) in
            XCTAssertFalse(result, "A ação não deveria encontrar o item favorito")
        }
    }
    
}

//
//  Dictionary_RickAndMortyUITests.swift
//  Dictionary_RickAndMortyUITests
//
//  Created by Rodrigo Martins on 05/11/20.
//

import XCTest

class Dictionary_RickAndMortyUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSelectFavoriteCharacter() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.cells.staticTexts["Rick Sanchez"].tap()
        
        //Salvar favorito
        let detalhesNavigationBar = app.navigationBars["Detalhes"]
        let button = detalhesNavigationBar.children(matching: .button).element(boundBy: 1)
        button.tap()
        
        let backButton = detalhesNavigationBar.buttons["Back"]
        backButton.tap()
        app.tabBars["Tab Bar"].buttons["Bookmarks"].tap()
        
        //Remover favorito
        collectionViewsQuery.cells.staticTexts["Rick Sanchez"].tap()
        button.tap()
        backButton.tap()
        
        app.tabBars["Tab Bar"].buttons["Search"].tap()
    }
    
}

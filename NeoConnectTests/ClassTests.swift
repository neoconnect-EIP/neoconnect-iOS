//
//  ClassTests.swift
//  NeoConnectTests
//
//  Created by Ilan Cohen on 06/11/2020.
//  Copyright © 2020 EIP. All rights reserved.
//

//import XCTest
//@testable import NeoConnect
//
//class ClassTests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//    func testShopClass() throws {
//        var ilanImage = shopImage()
//        ilanImage.imageName = "Pikachu"
//        ilanImage.imageData = "pikachu.jpg"
//        var shop = Shop2()
//        shop.id = 1
//        shop.pseudo = "IlanShop"
//        shop.full_name = "Ilan Shop"
//        shop.theme = "Cosmetique"
//        shop.userPicture = [ilanImage]
//        shop.email = "ilan@test.fr"
//        shop.average = 2
//
//
//        XCTAssertEqual(1, shop.id)
//        XCTAssertEqual("IlanShop", shop.pseudo)
//        XCTAssertEqual("Ilan Shop", shop.full_name)
//        XCTAssertEqual("Cosmetique", shop.theme)
//        XCTAssertEqual("Pikachu", ilanImage.imageName)
//        XCTAssertEqual("pikachu.jpg", ilanImage.imageData)
//        XCTAssertEqual("ilan@test.fr", shop.email)
//        XCTAssertEqual(2, shop.average)
//
//    }
//
//    func testOfferClass() throws {
//        var offer = Offer2()
//        offer.id = 1
//        offer.idUser = 10
//        offer.productName = "T-shirt gris"
//        offer.productImg = [offerImage(imageName: "offer", imageData: "offer.jpg")]
//        offer.productSex = "Male"
//        offer.productDesc = "T-shirt de la marque Diesel"
//        offer.productSubject = "Mode"
//        offer.brand = "Diesel"
//        offer.average = 2.0
//        offer.createdAt = "01/02/03"
//        offer.updatedAt = "02/03/04"
//
//
//        XCTAssertEqual(1, offer.id)
//        XCTAssertEqual(10, offer.idUser)
//        XCTAssertEqual("T-shirt gris", offer.productName)
//        XCTAssertEqual("Male", offer.productSex)
//        XCTAssertEqual("T-shirt de la marque Diesel", offer.productDesc)
//        XCTAssertEqual("Mode", offer.productSubject)
//        XCTAssertEqual("Diesel", offer.brand)
//        XCTAssertEqual(2.0, offer.average)
//        XCTAssertEqual("01/02/03", offer.createdAt)
//        XCTAssertEqual("02/03/04", offer.updatedAt)
//
//
//    }
//    func testMyOffersClass() throws {
//        var myOffers = myOffer()
//        myOffers.id = 1
//        myOffers.idUser = 10
//        myOffers.idOffer = 2
//        myOffers.createdAt = "01/02/03"
//        myOffers.updatedAt = "02/03/04"
//
//
//        XCTAssertEqual(1, myOffers.id)
//        XCTAssertEqual(10, myOffers.idUser)
//        XCTAssertEqual(2, myOffers.idOffer)
//        XCTAssertEqual("01/02/03", myOffers.createdAt)
//        XCTAssertEqual("02/03/04", myOffers.updatedAt)
//}
//
//    func testInfClass() throws {
//        var ilanImage = infImage()
//        ilanImage.imageName = "Pikachu"
//        ilanImage.imageData = "pikachu.jpg"
//        var inf = Inf2()
//        inf.id = 1
//        inf.pseudo = "Ilan"
//        inf.full_name = "Ilan Inf"
//        inf.theme = "Cosmetique"
//        inf.userPicture = [ilanImage]
//        inf.email = "ilan@test.fr"
//        inf.average = 2
//
//
//        XCTAssertEqual(1, inf.id)
//        XCTAssertEqual("Ilan", inf.pseudo)
//        XCTAssertEqual("Ilan Inf", inf.full_name)
//        XCTAssertEqual("Cosmetique", inf.theme)
//        XCTAssertEqual("Pikachu", ilanImage.imageName)
//        XCTAssertEqual("pikachu.jpg", ilanImage.imageData)
//        XCTAssertEqual("ilan@test.fr", inf.email)
//        XCTAssertEqual(2, inf.average)
//
//    }
//}

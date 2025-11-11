import Foundation
import XCTest

// Modelo
struct Product: Codable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let currency: String
    let in_stock: Bool
}

struct ProductList: Codable {
    let products: [Product]
}

// Clase con lógica para mostrar productos
class ProductManager {
    func showProducts(from list: ProductList) -> [String] {
        return list.products.map { "\($0.name) - \($0.price) \($0.currency)" }
    }
}

// MARK: - TESTS

class ProductManagerTests: XCTestCase {

    func testProductsAreDisplayed() {
        // Given: una lista con productos
        let product1 = Product(id: 1, name: "iPhone 13", description: "The latest iPhone", price: 999.99, currency: "USD", in_stock: true)
        let product2 = Product(id: 2, name: "Samsung Galaxy S21", description: "The latest Samsung phone", price: 899.99, currency: "USD", in_stock: true)
        let productList = ProductList(products: [product1, product2])
        
        // When: mostramos los productos
        let manager = ProductManager()
        let result = manager.showProducts(from: productList)
        
        // Then: debería mostrar 2 elementos
        XCTAssertEqual(result.count, 2)
        XCTAssertTrue(result.first?.contains("iPhone 13") ?? false)
    }

    func testEmptyProductListShowsNothing() {
        // Given: lista vacía
        let emptyList = ProductList(products: [])
        
        // When
        let manager = ProductManager()
        let result = manager.showProducts(from: emptyList)
        
        // Then: el resultado debe estar vacío
        XCTAssertTrue(result.isEmpty)
    }
}

// Ejecutar las pruebas (solo si estás en Playground)
ProductManagerTests.defaultTestSuite.run()

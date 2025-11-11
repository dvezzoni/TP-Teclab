import Foundation

// Estructuras que representan el formato del JSON
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

// URL de la API externa
let url = URL(string: "https://jsonkeeper.com/b/MX0A")!

// Realizamos la solicitud HTTP
let task = URLSession.shared.dataTask(with: url) { data, _, error in
    // Verificamos si hubo error
    if let error = error {
        print("❌ Error al obtener datos: \(error.localizedDescription)")
        return
    }
    
    // Validamos los datos recibidos
    guard let data = data else {
        print("❌ No se recibieron datos desde la API.")
        return
    }
    
    do {
        // Decodificamos el JSON en nuestras estructuras
        let productList = try JSONDecoder().decode(ProductList.self, from: data)
        
        print("✅ Listado de productos obtenidos desde la API:\n")
        for product in productList.products {
            print("🛍️ \(product.name) - Precio: \(product.price) \(product.currency)")
        }
    } catch {
        print("⚠️ Error al decodificar el JSON: \(error)")
    }
}

// Ejecutamos la tarea
task.resume()

// Mantener el Playground activo para recibir la respuesta
RunLoop.main.run()

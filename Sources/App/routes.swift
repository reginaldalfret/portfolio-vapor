import Vapor

func routes(_ app: Application) throws {
    // Health check endpoint
    app.get("health") { req async -> String in
        return "OK"
    }

    // Serve portfolio HTML on root
    app.get { req async throws -> Response in
        let publicDir = req.application.directory.publicDirectory
        let indexPath = publicDir + "index.html"
        guard let data = FileManager.default.contents(atPath: indexPath),
              let html = String(data: data, encoding: .utf8) else {
            return Response(status: .internalServerError, body: .init(string: "Failed to load portfolio index"))
        }
        var headers = HTTPHeaders()
        headers.add(name: .contentType, value: "text/html; charset=utf-8")
        headers.add(name: "Server", value: "Vapor/4.99.0 (SwiftNIO)")
        headers.add(name: "X-Powered-By", value: "Vapor/4.99.0")
        return Response(status: .ok, headers: headers, body: .init(string: html))
    }

    // Serve on /stacks/vapor
    app.get("stacks", "vapor") { req async throws -> Response in
        let publicDir = req.application.directory.publicDirectory
        let indexPath = publicDir + "index.html"
        guard let data = FileManager.default.contents(atPath: indexPath),
              let html = String(data: data, encoding: .utf8) else {
            return Response(status: .internalServerError, body: .init(string: "Failed to load portfolio index"))
        }
        var headers = HTTPHeaders()
        headers.add(name: .contentType, value: "text/html; charset=utf-8")
        headers.add(name: "Server", value: "Vapor/4.99.0 (SwiftNIO)")
        headers.add(name: "X-Powered-By", value: "Vapor/4.99.0")
        return Response(status: .ok, headers: headers, body: .init(string: html))
    }
}

import Vapor

public func configure(_ app: Application) async throws {
    let port = Environment.get("PORT").flatMap(Int.init) ?? 8093
    app.http.server.configuration.port = port
    app.http.server.configuration.hostname = "127.0.0.1"

    let publicDir = app.directory.publicDirectory
    app.middleware.use(FileMiddleware(publicDirectory: publicDir))

    try routes(app)
}

import Fluent
import Vapor

struct MatchController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let matches = routes.grouped("matches")
        matches.get(use: index)
        matches.post(use: create)
        matches.group(":matchID") { match in
            match.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Match]> {
        return Match.query(on: req.db)
            .sort(\.$date, .ascending)
            .all()
    }

    func count(req: Request) throws -> EventLoopFuture<Int> {
        return Match.query(on: req.db).count()
    }

    func create(req: Request) throws -> EventLoopFuture<Match> {
        let match = try req.content.decode(Match.self)
        return match.save(on: req.db).map { match }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Match.find(req.parameters.get("matchID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}

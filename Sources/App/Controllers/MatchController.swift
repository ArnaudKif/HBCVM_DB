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
        matches.group(":teamName") { match in
            match.get(use: indexTeam)
        }
        let updMatches = routes.grouped("update")
        updMatches.group(":matchID") { updmatch in
            updmatch.post(use: update)
        }
        let countMatches = routes.grouped("count")
        countMatches.get(use: count)

    }

    func indexTeam(req: Request) throws -> EventLoopFuture<[Match]> {
        let teamName = req.parameters.get("teamName")!
        return Match.query(on: req.db)
            .sort(\.$date, .ascending)
            .filter(\.$teamName =~ "\(teamName)")
            .all()
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

    func update(req : Request) throws -> EventLoopFuture<Match> {
        guard let id = req.parameters.get("matchID", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        let input = try req.content.decode(Match.self)
        return Match.find(id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { match in
                match.teamName = input.teamName
                match.adversaryTeamName = input.adversaryTeamName
                match.date = input.date
                match.isInHome = input.isInHome
                match.matchAdress = input.matchAdress
                match.comment = input.comment
                match.team1Score = input.team1Score
                match.team2Score = input.team2Score
                return match.save(on: req.db).map { match }
            }

    }

}

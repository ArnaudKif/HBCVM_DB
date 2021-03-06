import Fluent

struct CreateMatch: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("matches")
            .id()
            .field("teamName", .string, .required)
            .field("adversaryTeamName", .string, .required)
            .field("date", .string, .required)
            .field("isInHome", .bool, .required)
            .field("matchAdress", .string, .required)
            .field("comment", .string, .required)
            .field("team1Score", .int)
            .field("team2Score", .int)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("matches").delete()
    }
}

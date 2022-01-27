import Fluent
import Vapor
import Foundation

final class Match: Model, Content {
    
    static let schema = "matches"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "teamName")
    var teamName: String

    @Field(key: "adversaryTeamName")
    var adversaryTeamName: String


    @Field(key: "date")
    var date: String

    @Field(key: "isInHome")
    var isInHome: Bool

    @Field(key: "matchAdress")
    var matchAdress: String

    @Field(key: "comment")
    var comment: String

    @Field(key: "team1Score")
    var team1Score: Int?

    @Field(key: "team2Score")
    var team2Score: Int?

    init() { }

    init(id: UUID? = nil, teamName: String, adversaryTeamName: String, date: String, isInHome: Bool, matchAdress: String, comment: String, team1Score: Int?, team2Score: Int?) {
        self.id = id
        self.teamName = teamName
        self.adversaryTeamName = adversaryTeamName
        self.date = date
        self.isInHome = isInHome
        self.matchAdress = matchAdress
        self.comment = comment
        self.team1Score = team1Score
        self.team2Score = team2Score
    }


}

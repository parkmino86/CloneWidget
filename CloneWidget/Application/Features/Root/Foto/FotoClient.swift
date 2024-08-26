import ComposableArchitecture
import Foundation

extension DependencyValues {
    var fotoClient: FotoClient {
        get { self[FotoClient.self] }
        set { self[FotoClient.self] = newValue }
    }
}

@DependencyClient
struct FotoClient {
    var fetchMembers: @Sendable () async throws -> [ArtistMemberDomain.State]
}

extension FotoClient: DependencyKey {
    static let liveValue: FotoClient = {
        let service = FotoService()
        return Self(
            fetchMembers: {
                try await service.fetchMembers()
            }
        )
    }()

    static let previewValue: FotoClient = {
        let service = FotoService()
        return Self(
            fetchMembers: {
                try await service.fetchMembers()
            }
        )
    }()

    private actor FotoService {
        private var storedMembers: [ArtistMemberDomain.State] = [
            ArtistMemberDomain.State(name: "Hongjoong", group: "ATEEZ"),
            ArtistMemberDomain.State(name: "Seonghwa", group: "ATEEZ"),
            ArtistMemberDomain.State(name: "Yunho", group: "ATEEZ"),
            ArtistMemberDomain.State(name: "Yeosang", group: "ATEEZ"),
            ArtistMemberDomain.State(name: "San", group: "ATEEZ"),
            ArtistMemberDomain.State(name: "Mingi", group: "ATEEZ"),
            ArtistMemberDomain.State(name: "Wooyoung", group: "ATEEZ"),
            ArtistMemberDomain.State(name: "Jongho", group: "ATEEZ"),
            ArtistMemberDomain.State(name: "RM", group: "BTS"),
            ArtistMemberDomain.State(name: "Jin", group: "BTS"),
            ArtistMemberDomain.State(name: "Suga", group: "BTS"),
            ArtistMemberDomain.State(name: "J-Hope", group: "BTS"),
            ArtistMemberDomain.State(name: "Jimin", group: "BTS"),
            ArtistMemberDomain.State(name: "V", group: "BTS"),
            ArtistMemberDomain.State(name: "Jungkook", group: "BTS"),
            ArtistMemberDomain.State(name: "Jisoo", group: "BLACKPINK"),
            ArtistMemberDomain.State(name: "Jennie", group: "BLACKPINK"),
            ArtistMemberDomain.State(name: "Rosé", group: "BLACKPINK"),
            ArtistMemberDomain.State(name: "Lisa", group: "BLACKPINK"),
        ]

        func fetchMembers() async throws -> [ArtistMemberDomain.State] {
            return storedMembers
        }
    }
}

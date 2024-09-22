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
    var fetchArtistMembers: @Sendable (String) async throws -> [ProfileCore.State]
    var fetchArtists: @Sendable () async throws -> [CategoryButtonCore.State]
}

extension FotoClient: DependencyKey {
    static let liveValue: FotoClient = {
        let service = FotoService()
        return Self(
            fetchArtistMembers: { group in
                try await service.fetchArtistMembers(for: group)
            },
            fetchArtists: {
                try await service.fetchArtists()
            }
        )
    }()

    static let previewValue: FotoClient = {
        let service = FotoService()
        return Self(
            fetchArtistMembers: { group in
                try await service.fetchArtistMembers(for: group)
            },
            fetchArtists: {
                try await service.fetchArtists()
            }
        )
    }()
}

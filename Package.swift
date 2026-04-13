// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "FilesProvider",
    products: [
        .library(
            name: "FilesProvider",
            targets: ["FilesProvider"]
        )
    ],
    dependencies: [],
    targets: [
        .target(name: "FilesProvider",
            dependencies: [],
            path: "Sources",
            sources: [
                "Extensions",
                "FPSStreamTask.swift",
                "FTPFileProvider.swift",
                "FTPHelper.swift",
                "FileObject.swift",
                "FileProvider.swift",
                "RemoteSession.swift",
                "ServerTrustPolicy.swift"
            ]
        ),
        .testTarget(name: "FilesProviderTests",
                dependencies: ["FilesProvider"],
                path: "Tests"
        ),
    ]
)

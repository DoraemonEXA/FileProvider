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
            exclude: [
                "AEXML/LICENSE",
                "CloudFileProvider.swift",
                "DropboxFileProvider.swift",
                "DropboxHelper.swift",
                "ExtendedLocalFileProvider.swift",
                "LocalFileProvider.swift",
                "LocalHelper.swift",
                "OneDriveFileProvider.swift",
                "OneDriveHelper.swift",
                "SMBClient.swift",
                "SMBFileProvider.swift",
                "SMBTypes"
            ],
            sources: [
                "AEXML/Document.swift",
                "AEXML/Element.swift",
                "AEXML/Error.swift",
                "AEXML/Options.swift",
                "AEXML/Parser.swift",
                "Extensions",
                "FPSStreamTask.swift",
                "FTPFileProvider.swift",
                "FTPHelper.swift",
                "FileObject.swift",
                "FileProvider.swift",
                "HTTPFileProvider.swift",
                "RemoteSession.swift",
                "ServerTrustPolicy.swift",
                "WebDAVFileProvider.swift"
            ]
        ),
        .testTarget(
            name: "FilesProviderTests",
            dependencies: ["FilesProvider"],
            path: "Tests/FilesProviderTests"
        ),
    ]
)

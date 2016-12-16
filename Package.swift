import PackageDescription

let package = Package(
    name: "VaporMustache",
    dependencies: [
        .Package(url: "https://github.com/kateinoigakukun/Mustache.git", majorVersion: 0),
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1)
    ]
)

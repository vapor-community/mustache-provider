import PackageDescription

let package = Package(
    name: "VaporMustache",
    dependencies: [
        .Package(url: "https://github.com/nsleader/Mustache.git", majorVersion: 0, minor: 7),
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 0, minor: 11)
    ]
)

import PackageDescription

let package = Package(
    name: "VaporMustache",
    dependencies: [
        .Package(url: "https://github.com/LoganWright/Mustache.git", majorVersion: 0, minor: 0),
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 0, minor: 16)
    ]
)

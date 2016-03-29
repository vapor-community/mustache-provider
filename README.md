# Vapor Zewo Mustache

Vapor `RenderDriver` implementation for [Zewo Mustache](https://github.com/Zewo/Mustache).

## Installation

### Provider

This package includes a Vapor Provider.

```swift
import VaporZewoMustache

let app = Application()

//routes, etc

app.providers.append(VaporZewoMustache.Provider)
app.start()
```

### Manual

To add `VaporZewoMustache`, add the following package to your `Package.swift`.

`Package.swift`
```swift
.Package(url: "https://github.com/tannernelson/vapor-zewo-mustache.git", majorVersion: 0, minor: 1)
```

Then set the `MustacheRenderer()` on your `View.renderers` for whatever file extensions you would like to be rendered as `Mustache` templates.

`main.swift`
```swift
import Vapor
import VaporZewoMustache

//set the mustache renderer
//for all .mustache files
View.renderers[".mustache"] = VaporZewoMustache.MustacheRenderer()
```

## Includes

To use includes, you must specify them ahead of time to the `MustacheRenderer`.

### Provider

Simply add them as the Provider's `includeFiles`.

```swift
VaporZewoMustache.Provider.includeFiles = [
	"header": "Includes/header.mustache",
	"footer": "Includes/footer.mustache"
]
```

The path will be appended to `Resources/Views/...` by default.

### Manual

The `MustacheRenderer` accepts a dictionary of files where the key is the include name and the value is the file path relative to the working directory.

```swift
public init(files: [String: String])
```

# Vapor Mustache

Vapor `RenderDriver` implementation for [Mustache](https://github.com/Zewo/Mustache).

## Installation

### Package

To add `VaporMustache`, add the following package to your `Package.swift`.

`Package.swift`
```swift
.Package(url: "https://github.com/qutheory/vapor-mustache.git", majorVersion: 0, minor: 5)
```

### Provider

This package includes a Vapor Provider which makes it easy to add as a dependency.

```swift
import Vapor
import VaporMustache

let app = Application()

//routes, etc

app.providers.append(VaporMustache.Provider())
app.start()
```

### Manual

If you don't want to use the Provider, set the `MustacheRenderer()` on your `View.renderers` for whatever file extensions you would like to be rendered as `Mustache` templates.

`main.swift`
```swift
import VaporMustache

//set the mustache renderer
//for all .mustache files
View.renderers[".mustache"] = VaporZewoMustache.MustacheRenderer()
```

## Includes

Includes let you load other mustache templates into your template with a syntax like `{{> header}}`.

To use includes, you must specify them ahead of time to the `MustacheRenderer`.

### Provider

Simply add them as the Provider's `includeFiles`.

```swift
let provider = VaporMustache.Provider(withIncludes: [
	"header": "Includes/header.mustache",
	"footer": "Includes/footer.mustache"
])
app.providers.append(provider)
```

The path will be appended to `Resources/Views/...` by default.

### Manual

The `MustacheRenderer` accepts a dictionary of files where the key is the include name and the value is the file path relative to the working directory.

```swift
public init(files: [String: String])
```

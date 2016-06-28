import Vapor
import Mustache

public class MustacheRenderer: RenderDriver {
    static let currentName = "__current"

    public enum Error: ErrorProtocol {
        case file(String, ErrorProtocol)
    }

    public var includes: [String: String]

    public init(files: [String: String] = [:]) throws {
        includes = [:]

        for (name, file) in files {
            do {
                var bytes = try File.readBytes(path: file)
                bytes.append(0)

                includes[name] = String(validatingUTF8: bytes)
            } catch {
                throw Error.file(file, error)
            }
        }
    }

    public func render(template: String, context: [String: Any]) throws -> String {
        var templates = includes
        templates[MustacheRenderer.currentName] = template
        let repository = TemplateRepository(templates: templates)

        let renderer = try repository.template(named: MustacheRenderer.currentName)

        let result = try renderer.render(box: context.mustacheBox)
        return result
    }

}

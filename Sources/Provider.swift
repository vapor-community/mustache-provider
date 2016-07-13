import Vapor

public class Provider: Vapor.Provider {
	public var includeFiles: [String: String]

	public init(withIncludes includeFiles: [String: String] = [:]) {
		self.includeFiles = includeFiles
	}

	public func boot(with drop: Droplet) {
		var files: [String: String] = [:]
		includeFiles.forEach { (name, file) in
			files[name] = drop.workDir + "Resources/Views/" + file
		}

        do {
            View.renderers[".mustache"] = try MustacheRenderer(files: files)
        } catch {
            drop.log.error("Could not configure Mustache: \(error)")
        }
	}

}

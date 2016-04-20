import Vapor

public class Provider: Vapor.Provider {
	public var includeFiles: [String: String]

	public init(withIncludes includeFiles: [String: String] = [:]) {
		self.includeFiles = includeFiles
	}

	public func boot(with application: Application) {
		var files: [String: String] = [:]
		includeFiles.forEach { (name, file) in
			files[name] = application.workDir + "Resources/Views/" + file
		}
		
		View.renderers[".mustache"] = MustacheRenderer(files: files)
	}

}

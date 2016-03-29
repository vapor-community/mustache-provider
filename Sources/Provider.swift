import Vapor

public class Provider: Vapor.Provider {
	public static var includeFiles: [String: String] = [:]

	public static func boot(application: Application) {
		var files: [String: String] = [:]
		includeFiles.forEach { (name, file) in
			files[name] = application.workDir + "Resources/Views/" + file
		}
		
		View.renderers[".mustache"] = MustacheRenderer(files: files)
	}

}

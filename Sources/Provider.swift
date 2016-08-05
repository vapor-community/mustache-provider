import Vapor

public class Provider: Vapor.Provider {
	public var includeFiles: [String: String]

    public var provided: Providable { return Providable() }

    public required init(config: Config) throws {
        self.includeFiles = [:]
    }
    
	public init(withIncludes includeFiles: [String: String] = [:]) {
		self.includeFiles = includeFiles
	}


    /**
     Called after the Droplet has completed
     initialization and all provided items
     have been accepted.
     */
    public func afterInit(_ drop: Droplet) {
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

    /**
     Called before the Droplet begins serving
     which is @noreturn.
     */
    public func beforeServe(_: Droplet) {}
}

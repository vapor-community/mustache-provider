#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

enum Error: ErrorProtocol {
    case CouldNotOpenFile
    case Unreadable
}

class File {
    static func readBytes(path: String) throws -> [Int8] {
        let fd = open(path, O_RDONLY);

        if fd < 0 {
            throw Error.CouldNotOpenFile
        }
        defer {
            close(fd)
        }

        var info = stat()
        let ret = withUnsafeMutablePointer(&info) { infoPointer -> Bool in
            if fstat(fd, infoPointer) < 0 {
                return false
            }
            return true
        }
        
        if !ret {
            throw Error.Unreadable
        }
        
        let length = Int(info.st_size)
        
        let rawData = malloc(length)
        var remaining = Int(info.st_size)
        var total = 0
        while remaining > 0 {
            let advanced = rawData!.advanced(by: total)
            
            let amt = read(fd, advanced, remaining)
            if amt < 0 {
                break
            }
            remaining -= amt
            total += amt
        }

        if remaining != 0 {
            throw Error.Unreadable
        }

        //thanks @Danappelxx
        let data = UnsafeMutablePointer<Int8>(rawData)
        let buffer = UnsafeMutableBufferPointer<Int8>(start: data, count: length)
        return Array(buffer)
    }
}

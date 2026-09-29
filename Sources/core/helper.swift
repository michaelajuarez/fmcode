import Foundation

public func isDirectory(_ url: URL) -> Bool {
  let resVals = try? url.resourceValues(forKeys: [.isDirectoryKey])
  if (resVals?.isDirectory == true) {
    return true
  }
  return false
}
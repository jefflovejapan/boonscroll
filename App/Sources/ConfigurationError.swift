import Foundation

internal enum ConfigurationError: Swift.Error {
    case unknownDatabaseType(String?)
}
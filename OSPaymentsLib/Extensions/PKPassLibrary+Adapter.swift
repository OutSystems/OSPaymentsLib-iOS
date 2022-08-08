import PassKit

extension PKPassLibrary: OSPMTWalletAvailabilityDelegate {
    static func isWalletAvailable() -> Bool {
        Self.isPassLibraryAvailable()
    }
}

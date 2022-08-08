typealias OSPMTCompletionHandler = (Result<OSPMTScopeModel, OSPMTError>) -> Void

protocol OSPMTHandlerDelegate: AnyObject {
    func setupConfiguration() -> Result<String, OSPMTError>
    func checkWalletAvailability() -> OSPMTError?
    func set(_ detailsModel: OSPMTDetailsModel, completion: @escaping OSPMTCompletionHandler)
}

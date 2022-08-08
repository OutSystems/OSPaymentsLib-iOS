protocol OSPMTActionDelegate: AnyObject {
    func setupConfiguration()
    func checkWalletSetup()
    func set(_ details: String)
}

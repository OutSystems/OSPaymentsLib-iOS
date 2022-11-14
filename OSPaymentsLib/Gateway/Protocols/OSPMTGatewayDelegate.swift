import PassKit

protocol OSPMTGatewayDelegate: AnyObject {
    func process(_ payment: PKPayment, with details: OSPMTDetailsModel, _ completion: @escaping (Result<String, OSPMTError>) -> Void)
}

extension OSPMTGatewayDelegate {
    func processURLRequest(for gateway: OSPMTGateway, and body: [String: Any], _ completion: @escaping (Result<String, OSPMTError>) -> Void) {
        let url = URL(string: "http://192.168.1.222:5000/pay/\(gateway.rawValue.lowercased())")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  error == nil,
                  let data = data,
                  let string = String(data: data, encoding: .utf8) else {
                completion(.failure(.paymentIssue))
                return
            }

            completion(.success(string))
        }
        task.resume()
    }
}

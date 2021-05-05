//
//  ViewController.swift
//  CryptoCurrency
//
//  Created by Juan carlos De la parra on 16/02/21.
//

import UIKit

class CellViewController: UITableViewCell {
  
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableCoins: UITableView!
    
    var messages = [Coin]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(messages.count)
       
        let message = messages[indexPath.row]
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "Cell",
                    for: indexPath
                ) as! CellViewController
                cell.nameLabel?.text = message.name
        
        let formattedprice = format(price: message.price)
                cell.priceLabel?.text = formattedprice
                return cell
       

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableCoins.delegate = self
        tableCoins.dataSource = self
        
        let sharedSession = URLSession.shared

            if let url = URL(string: "https://api.coinranking.com/v1/public/coins") {
                // Create Request
                let request = URLRequest(url: url)

                // Create Data Task
                let dataTask = sharedSession.dataTask(with: request, completionHandler: { [self] (data, response, error) -> Void in
                    print(data as Any)
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(CryptoDataContainer.self, from: data!)
                        print(response as Any)
                        //"Sunrise \n \(response.results.sunrise) "
                        messages = response.data.coins
                        print(messages as Any)
                         DispatchQueue.main.async {
                            tableCoins.reloadData()
                         }

                    } catch {
                        print(error)
                    }
                    
                })

                dataTask.resume()
            }
    }
   func format(price: String) -> String {
        // here we need to use methods to add $ and to truncate our decimals to 2 decimals.
        return price
        
      //return String(format: "$%d%d%d.2f" , price)
        
        //var result = NumberFormatter.localizedString(from: 99999.99, number: .currency)
        //return result
        
    }

}

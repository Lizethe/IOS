//
//  ClientTableViewController.swift
//  ClientRegistration
//
//  Created by Lizeth Ovando on 12/14/17.
//  Copyright © 2017 com.client.registration. All rights reserved.
//

import UIKit
import RealmSwift

class ClientTableViewController: UITableViewController {
    var clients = [Client]()
    var realm:Realm?
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        
        // retrieve from DB
        let arrayClient = realm?.objects(ClientDB.self)
        //print("Save !!! --Paht --> \( Realm.Configuration.defaultConfiguration.fileURL)")
        for clientDB in arrayClient!{
            let photo = UIImage(data: clientDB.photo! as Data)
            let newClient = Client(id: clientDB.id!,
                               name: clientDB.name!,
                               lastName: clientDB.lastName!,
                               photo: photo,
                               phone: clientDB.phone!,
                               birthday: clientDB.birthday!,
                               address: clientDB.address!)
            clients.append(newClient!)
        }        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func saveClient(client: Client){
        let newClientDB = ClientDB()
        newClientDB.id = client.id
        newClientDB.name = client.name
        newClientDB.lastName = client.lastName
        newClientDB.photo = UIImagePNGRepresentation(client.photo!)! as NSData
        newClientDB.phone = client.phone
        newClientDB.birthday = client.birthday
        newClientDB.address = client.address
       // Save new client into DB
        try! self.realm?.write {
            self.realm?.add(newClientDB)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return clients.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewClientCell", for: indexPath) as! ClientTableViewCell
        
        let client = clients[indexPath.row]
        cell.lbName.text = client.name
        cell.lbPhone.text = client.phone
        cell.lbAddress.text = client.address
        cell.photo.image = client.photo
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
         let selectedClient = clients[indexPath.row]
         let clientToDelete = realm?.objects(ClientDB.self).filter("id == %@", selectedClient.id!).first
             try! realm?.write {
             realm?.delete(clientToDelete!)
             }
             clients.remove(at: indexPath.row)
             tableView.deleteRows(at: [indexPath], with: .fade)
         
         } else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "addClient":
            print("Show Detail")            //os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "showClientDetail":
            print("Show Detal")
            
            guard let clientDetailViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedClientCell = sender as? ClientTableViewCell else {
                fatalError("Unexpected sender: \(sender!)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedClientCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedClient = clients[indexPath.row]
            clientDetailViewController.client = selectedClient
            
        default:
            print("Default")
            //fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
   
    // TableViewController // sent dato to back
    @IBAction func unwindToClientList1(send: UIStoryboardSegue){
        
        print("Unwiped!!!!!")
        
        if let sourceViewController = send.source as? ViewController, let client = sourceViewController.client{
            // click in row
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                clients[selectedIndexPath.row] = client
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                tableView.reloadData()
                // update Data
                let clientToUpdate = realm?.objects(ClientDB.self).filter("id == %@", client.id!).first
                try! realm?.write {
                    clientToUpdate?.name = client.name!
                    clientToUpdate?.lastName = client.lastName!
                    clientToUpdate?.phone = client.phone!
                    clientToUpdate?.address = client.address
                    clientToUpdate?.birthday = client.birthday!
                    clientToUpdate?.photo = UIImagePNGRepresentation(client.photo!)! as NSData
                }
                
                // click + button
            }else{
                let newIndexPath = IndexPath(row: clients.count, section: 0)
                clients.append(client)
                saveClient(client: client)
                
                //tableView.reloadData()
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
        // todo return data
    }    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

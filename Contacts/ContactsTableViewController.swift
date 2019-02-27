//
//  ContactsTableViewController.swift
//  Contacts
//
//  Created by Esteban Ordonez on 2/25/19.
//  Copyright © 2019 Esteban Ordonez. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    var contacts: [[Contact]] = [
        [
            //Contact(name: "Esteban", lastName: "Ordonez" ),
        
        ],
        [
            
        ],
        
        [
            
        ],
    ];

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         navigationItem.rightBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return contacts.count;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard (0 ..< contacts.count).contains(section) else {
            fatalError("There is no section number \(section)");
        }
        return contacts[section].count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = contacts[indexPath.section][indexPath.row].name;
        cell.detailTextLabel?.text = ("\(contacts[indexPath.section][indexPath.row]) is contact number \(indexPath.row) of \(indexPath.section)")
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "EditContact" {
            let indexPath: IndexPath = tableView.indexPathForSelectedRow!
            let contact: Contact = contacts[indexPath.section][indexPath.row]
            let navController: UINavigationController = segue.destination as!
            UINavigationController
            if let addContactTableViewController =
                navController.topViewController as?
                AddContactTableViewController {
                
                addContactTableViewController.contact = contact
            }
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard (0 ..< contacts.count).contains(section) else {
            fatalError("There is no section number \(section).");
        }
        
        let categories: [String] = [
            "College",
            "Work",
            "Family"
        ]
        
        return categories[section];
    }
    
    @IBAction func unwindToContactsTableView(segue: UIStoryboardSegue) {
        print("unwind");
        guard segue.identifier == "saveContact" else {
            return;  //nothing I need to do
        }
        
        guard let addContactTableViewController: AddContactTableViewController = segue.source as? AddContactTableViewController else {
            fatalError("we should have returned from an AddContactTableViewControlller");
        }
        
        guard let contact: Contact = addContactTableViewController.contact else {
            fatalError("addContactTableViewController.contact was nil");
        }
        
        if let indexPath: IndexPath = tableView.indexPathForSelectedRow {
            //at end of a journey that began when user tapped a cell
            contacts[indexPath.section][indexPath.row] = contact;
            tableView.reloadRows(at: [indexPath], with: .automatic);
        } else {
            //at end of a joureny that began when user tapped +
            //indexPath of place where additional cell would go, at the very end
            let newIndexPath: IndexPath = IndexPath(row: contacts[contacts.count - 1].count, section: contacts.count - 1);
            contacts[contacts.count - 1].append(contact);
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
    }
    
    /**
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        switch indexPath.row % 3 {
        case 0:
            return .none;
        case 1:
            return .delete;
        case 2:
            return .insert;
        default:
            return .none;
        }
    }
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .insert {
            //states.remove(at: indexPath.row);
            tableView.insertRows(at: [indexPath], with: .left);
            
        }
    }
**/
  
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

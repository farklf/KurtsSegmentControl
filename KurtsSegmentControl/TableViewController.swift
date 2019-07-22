//
//  TableViewController.swift
//  KurtsSegmentControl
//
//  Created by MAC Consultant on 7/20/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

  

  
    
    
        
        var books: [Book] = []
        
        
        @IBOutlet weak var tableView: UITableView!
        
        let searchController = UISearchController(searchResultsController: nil)
        let viewModel = ViewModel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            print("in table view controller")
            viewModel.get(books: "Harry Potter")
       //     viewModel.delegate = (self as! ViewModelDelegate)
            
            NotificationCenter.default.addObserver(forName: Notification.Name("Object"), object: nil, queue: .main) { [unowned self] _ in
                self.tableView.reloadData()
            }
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            searchController.isActive = false
            searchController.definesPresentationContext = true
            
            
        }
        func createSearchBar() {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            
            searchController.dimsBackgroundDuringPresentation = false
            searchController.searchResultsUpdater = self
            searchController.searchBar.placeholder = "search books..."
            print("inside serach controller")
        }
        
        
        
        
    }
extension TableViewController: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //tells the table view how many rows to produce
            //        return self.books.count
            //        return myBooks.count
            
            return viewModel.myBooks.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
            UITableViewCell {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
                
                let  book = viewModel.myBooks[indexPath.row]
                
                cell.bookKindLabel.text = book.kind
                cell.bookIdLabel.text = book.id
               
                
                let url = URL(string: book.thumbnail)!
                
                URLSession.shared.dataTask(with: url) { (dat, _, _) in
                    
                    if let data = dat {
                        
                        if let image = UIImage(data: data) {
                            
                            DispatchQueue.main.async {
                                cell.bookthumbnail.image = image
                                self.view.layoutIfNeeded()
                                print("Received Image")
                            }
                        }
                    }
                    
                    }.resume()
                
                
                return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 137
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                
                //remove beer in array at the indexPath.row
                books.remove(at: indexPath.row)
            }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            //Add this to un-highlight the row that was tapped
            tableView.deselectRow(at: indexPath, animated: true)
            
            
            //Select the correct beer from the array
            let book  = viewModel.myBooks[indexPath.row]
            viewModel.currentBook = book
            
            let bkDetailVC = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as! DetailedViewController
            
            bkDetailVC.viewModel = viewModel
            
            //present the detail VC
            self.navigationController?.pushViewController(bkDetailVC, animated: true)
            
            
            
            
            
        }
        
    } // end extension
    
    extension TableViewController: UISearchResultsUpdating {
        
        func updateSearchResults(for searchController: UISearchController) {
            
            
            let searchText = searchController.searchBar.text!.replacingOccurrences(of: " ", with: "")
            
            viewModel.get(books: searchText)
        }
        
    }
    extension TableViewController: ViewModelDelegate{
        
        func updateView() {
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
        
}

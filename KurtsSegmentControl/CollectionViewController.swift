//
//  CollectionViewController.swift
//  KurtsSegmentControl
//
//  Created by MAC Consultant on 7/20/19.
//  Copyright © 2019 MAC Consultant. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    var books: [Book] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = ViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("cvc")
        viewModel.get(books: "Harry Potter")
        NotificationCenter.default.addObserver(forName: Notification.Name("Object"), object: nil, queue: .main) { [unowned self] _ in
            print(" in collections")
            self.collectionView.reloadData()
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("in number of item")
        print(viewModel.myBooks.count)
        return viewModel.myBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        let  book = viewModel.myBooks[indexPath.row]
        
        let url = URL(string: book.thumbnail)!
        
        URLSession.shared.dataTask(with: url) { (dat, _, _) in
            
            if let data = dat {
                
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        cell.collectionImage.image = image
                        self.view.layoutIfNeeded()
                        print("Received Image")
                    }
                }
            }
            
            }.resume()
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Add this to un-highlight the row that was tapped
        collectionView.deselectItem(at: indexPath, animated: true)
        
        
        //Select the correct beer from the array
        let book  = viewModel.myBooks[indexPath.row]
        viewModel.currentBook = book
        
        let bkDetailVC = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as! DetailedViewController
        
        bkDetailVC.viewModel = viewModel
        
        //present the detail VC
        self.navigationController?.pushViewController(bkDetailVC, animated: true)
        
    }
}


extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 131, height: 135)
    }
    
    
}

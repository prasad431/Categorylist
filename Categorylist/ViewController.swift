//
//  ViewController.swift
//  Categorylist
//
///  Created by Prasad on 16/05/18.
//  Copyright © 2018 HeadInfotech. All rights reserved.

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var categorytableview: UITableView!
    var  listArray = NSMutableArray()
    var  productsArray = NSMutableArray()
 var  casualproductsArray = NSMutableArray()
    var  rankingArray = NSMutableArray()
    var  VariantsArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "https://stark-spire-93433.herokuapp.com/json")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else { return }
            do {
                let str = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments)
                print(str)
        let dictcategories =  str as! NSDictionary
       let array = dictcategories.value(forKey: "categories")  as! NSArray
                
                self.listArray.removeAllObjects()
                self.productsArray.removeAllObjects()
                self.rankingArray.removeAllObjects()
                print("listarray",array)
                for dict in array {
                    self.listArray.add(dict as! NSDictionary)
                    for ditproducts in self.listArray {
                        let arrayofproducts = (ditproducts as! NSDictionary).value(forKey: "products") as! NSArray
                        for dictproductlist in arrayofproducts {
                            self.productsArray.add(dictproductlist as! NSDictionary)
                            
                            for variantsdict in self.productsArray {
                                let arrvariant = (variantsdict as! NSDictionary).value(forKey: "variants") as! NSArray
                                
                                for variantsspecifieddict in arrvariant {
                                    
                                   self.VariantsArray.add(variantsspecifieddict as! NSDictionary)
                                    
                                }
                            }
                        }
                    }
                }
                print("mainlistarray====",self.listArray)
                 print("productlist====",self.productsArray)
                let rankingArray = dictcategories.value(forKey: "rankings")  as! NSArray
                for dict in rankingArray {
                    self.rankingArray.add(dict as! NSDictionary)
                }
                print("rankingArray====",self.rankingArray)
                 self.categorytableview.reloadData()
                
            } catch {
                print("json error: \(error)")
            }
           
        }
        
        task.resume()
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- UITableview Delegate & Datasource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dict  = self.listArray.object(at: section) as! NSDictionary
 
        return (dict.value(forKey: "name") as! String)

    }
    private func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
//    private func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let Viewheader = UIView(frame: CGRect(x: 0, y: 0, width: self.categorytableview.frame.size.width, height: 40))
//        let lblHeader = UILabel()
//        lblHeader.frame = CGRect(x: 0, y: 0, width: 760, height: 40)
//        let dict  = self.listArray.object(at: section) as! NSDictionary
//        lblHeader.text = (dict.value(forKey: "name") as! String)
//        lblHeader.font = UIFont.boldSystemFont(ofSize: 20.0)
//        lblHeader.backgroundColor = UIColor.red
//        Viewheader .addSubview(lblHeader)
//
//        return Viewheader
//        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "Cell"

       var cell: CustomTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? CustomTableViewCell
        if indexPath.section == 0 {
        if cell == nil {
                tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CustomTableViewCell
            }
        let dict  = self.productsArray.object(at: indexPath.section) as! NSDictionary
        cell.namelabel?.text  = (dict.value(forKey: "name") as! String)
        
         let dictvariants  = self.VariantsArray.object(at: indexPath.section) as! NSDictionary
        cell.colorlabel?.text  = (dictvariants.value(forKey: "color") as! String)
        cell.sizelabel?.text  = String(format:"%@",(dictvariants.value(forKey: "size") as! NSNumber))
         cell.pricelabel?.text  = String(format:"%@",(dictvariants.value(forKey: "price") as! NSNumber))
            cell.idlabel?.text  = String(format:"%@",(dictvariants.value(forKey: "id") as! NSNumber))
            
            for dict  in rankingArray {
                let dictonary = dict as! NSDictionary
                let productsArray  = dictonary.value(forKey: "products") as! Array<Any>
                for object in productsArray{
                    let productsDictonary = object as! NSDictionary
                    if let keyString:String = dictonary.value(forKey: "ranking") as? String{
                        let viewedProductsString = "Most Viewed Products"
                        if keyString == viewedProductsString {
                            let productid = productsDictonary.value(forKey: "id") as? String
                            if dictvariants.value(forKey: "id") as? String == productid {
                                cell.viewCountLabel?.text = String(format:"Views:%@",(productsDictonary.value(forKey: "view_count") as! NSNumber))
                            }
                        }
                        
                        let orderedProductsString = "Most OrdeRed Products"
                        if keyString == orderedProductsString {
                            let productid = productsDictonary.value(forKey: "id") as? String
                            if dictvariants.value(forKey: "id") as? String == productid {
                                cell.orderCountLabel?.text = String(format:"Orders:%@",(productsDictonary.value(forKey: "order_count") as! NSNumber))
                            }
                        }
                        
                        let sharedProductsString = "Most ShaRed Products"
                        if keyString == sharedProductsString {
                            let productid = productsDictonary.value(forKey: "id") as? String
                            if dictvariants.value(forKey: "id") as? String == productid {
                                cell.shareCountLabel?.text = String(format:"Shares:%@",(productsDictonary.value(forKey: "shares") as! NSNumber))
                            }
                        }
                    }
                }
            }
            
        }
        
        return cell
    }
        
    
}


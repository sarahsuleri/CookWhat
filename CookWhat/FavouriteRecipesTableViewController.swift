//
//  FavouriteRecipesTableViewController.swift
//  CookWhat
//
//  Created by Sarah Suleri on 11/06/15.
//  Copyright (c) 2015 Sarah Suleri. All rights reserved.
//

import UIKit
import CoreData

class FavouriteRecipesTableViewController: UITableViewController {

    var myList: Array<AnyObject> = []
    var myIngrList: Array<AnyObject> = []
    var _fetchedResultsController: NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

  }
    //***** fetching data from desired table
    override func viewDidAppear(animated: Bool) {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "Recipes")
        let fetchIngr = NSFetchRequest(entityName: "Ingredients")
        myList =   context.executeFetchRequest(freq, error: nil)!
        myIngrList =   context.executeFetchRequest(fetchIngr, error: nil)!
        
      //  println(myList)
      //  println(myIngrList)
        tableView.reloadData()
    
    }

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myList.count
    }

    //***** loading code into table cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {


        // Configure the cell...
        
        let CellId: NSString = "Cell"
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellId as String) as! UITableViewCell
        
        var data: NSManagedObject = myList[indexPath.row] as! NSManagedObject
        
        var dataIngr: NSManagedObject = myIngrList[indexPath.row] as! NSManagedObject
        
      //  if let ip = indexPath as NSIndexPath? {
       //     var data: NSManagedObject = myList[ip.row] as! NSManagedObject
        
          //  cell.textLabel?.text = (data.valueForKey("title") as! String)
            
            var serv = data.valueForKey("servings") as! String
           
            var ingr = dataIngr.valueForKey("name") as! String
        
           // cell.detailTextLabel?.text = "\(serv)" //items - \(info)"
        //}
        
        
        
        
        //let events = data.recipes.allObjects as [Recipes]
        
        
        
        
        cell.detailTextLabel?.text = (data.valueForKey("title") as! String)
        
        cell.textLabel?.text = data.valueForKey("duration") as! String + "min"
        
      //  println(" ....")
      //  println(data.valueForKey("ingredients") as! NSSet)
        //println(ingr)
      //  println(" ....")
        //var info = data.valueForKey("info") as! String

        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            if let tv = tableView as UITableView?{
                context.deleteObject(myList[indexPath.row] as! NSManagedObject)
                myList.removeAtIndex(indexPath.row)
                tv.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
        }
        
        var error: NSError? = nil
        if !context.save(&error)
        {
            abort()
        }
   
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       if segue.identifier == "recipeDetail"
        {
            var selectedItem: NSManagedObject = myList[self.tableView.indexPathForSelectedRow()!.row] as! NSManagedObject
            let IVC: RecipeDetailsViewController = segue.destinationViewController as! RecipeDetailsViewController
            
            IVC.recipeTitle = selectedItem.valueForKey("title") as! String
            IVC.numberOfServings = selectedItem.valueForKey("servings") as! String
            IVC.recipeDirection = selectedItem.valueForKey("method") as! String
            
            IVC.recipeDuration = selectedItem.valueForKey("duration") as! String
            
            // IVC.info = selectedItem.valueForKey("info") as! String
            //   IVC.existingItem =  selectedItem
            
            IVC.recipeIngredients = selectedItem.valueForKey("ingredients") as! NSSet
            
//            var ingredien = selectedItem.valueForKey("ingredients") as! NSSet
//            
//            let ingo = ingredien.allObjects as! [Ingredients]
//            
//            for item in ingo as NSArray
//            {
//                println(item.valueForKey("name"))
//                println(item.valueForKey("quantity"))
//                println(item.valueForKey("unit"))
//            }
        }
    }

    
    
    func testFetch()
    {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest(entityName: "Recipes")
        myList =   context.executeFetchRequest(freq, error: nil)!
        

    }

}

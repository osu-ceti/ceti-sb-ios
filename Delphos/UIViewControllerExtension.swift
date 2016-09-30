import UIKit

extension UIViewController{
    
    func setNavigationBarItem() {
        
        self.navigationItem.title = "School Business"
        
        //self.navigationItem.titleView = imageView
        self.addRightBarButtonWithImage(UIImage(named: "menu_btn")!)
       
    }
    func fetchNavController(_ controllerId: String) -> UINavigationController{
       
        let objViewController = gObjStoryBoard.instantiateViewController(withIdentifier: controllerId)
        return UINavigationController( rootViewController: objViewController)
    }
}

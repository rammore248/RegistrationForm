//
//  TableViewController.h
//  UserList1
//
//  Created by XTSW-MAC-1137-2 on 10/04/24.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;

@property (strong, nonatomic) IBOutlet UITableView *tblView;



@property (strong, nonatomic)NSMutableArray *userArray;
@property (strong, nonatomic)AppDelegate *delegate;
@end

NS_ASSUME_NONNULL_END

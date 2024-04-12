//
//  RegistrationViewController.h
//  UserList1
//
//  Created by XTSW-MAC-1137-2 on 10/04/24.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegistrationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *placeLabel;
@property (weak, nonatomic) IBOutlet UITextField *mobileLabel;

@property(strong, nonatomic)AppDelegate *delegate;
- (IBAction)SubmitPressed:(UIButton *)sender;
- (IBAction)BackPressed:(UIButton *)sender;

@property (nonatomic, strong) RegistrationViewController *registration;
@property(strong)NSManagedObject *userDB;
@end

NS_ASSUME_NONNULL_END

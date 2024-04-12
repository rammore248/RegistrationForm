//
//  RegistrationViewController.m
//  UserList1
//
//  Created by XTSW-MAC-1137-2 on 10/04/24.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

@synthesize userDB;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (self.userDB) {
        [self.nameLabel setText:[self.userDB valueForKey:@"name"]];
        [self.placeLabel setText:[self.userDB valueForKey:@"place"]];
        [self.mobileLabel setText:[self.userDB valueForKey:@"mobile"]];
        
    }
}

-(NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    _delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if ([_delegate respondsToSelector:@selector(persistentContainer)]) {
        context = _delegate.persistentContainer.viewContext;
        
    }
    return context;
}
- (IBAction)BackPressed:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)SubmitPressed:(UIButton *)sender {
    
    // Check if input fields are empty
        if ([self.nameLabel.text isEqualToString:@""] || [self.placeLabel.text isEqualToString:@""] || [self.mobileLabel.text isEqualToString:@""]) {
            // Show an alert or message to inform the user about the empty fields
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please fill in all the fields." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }
        
        // Check name format
        NSString *nameRegex = @"^[a-zA-Z]+$"; // Assuming name should contain only alphabets
        NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
        if (![nameTest evaluateWithObject:self.nameLabel.text]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter a valid name with alphabets only." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }
        
        // Check place format (you can adjust this regex as per your requirement)
        NSString *placeRegex = @"^[a-zA-Z ]+$"; // Assuming place should contain only alphabets and spaces
        NSPredicate *placeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", placeRegex];
        if (![placeTest evaluateWithObject:self.placeLabel.text]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter a valid place name with alphabets and spaces only." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }
        
        // Check mobile number format (assuming a specific format here, adjust as per your requirement)
        NSString *mobileRegex = @"^[0-9]{10}$"; // Assuming mobile number is 10 digits
        NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
        if (![mobileTest evaluateWithObject:self.mobileLabel.text]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter a valid 10-digit mobile number." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }
        
        NSManagedObjectContext *context = [self managedObjectContext];
        if (self.userDB) {
            // Update existing user
            [self.userDB setValue:self.nameLabel.text forKey:@"name"];
            [self.userDB setValue:self.placeLabel.text forKey:@"place"];
            [self.userDB setValue:self.mobileLabel.text forKey:@"mobile"];
        } else {
            // Create new user
            NSManagedObject *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
            [newUser setValue:self.nameLabel.text forKey:@"name"];
            [newUser setValue:self.placeLabel.text forKey:@"place"];
            [newUser setValue:self.mobileLabel.text forKey:@"mobile"];
        }
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error: %@ %@", error, [error localizedDescription]);
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }

@end

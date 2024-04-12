//
//  TableViewController.m
//  UserList1
//
//  Created by XTSW-MAC-1137-2 on 10/04/24.

// TableViewController.m
#import "TableViewController.h"
#import "RegistrationViewController.h"
#import <CoreData/CoreData.h>

@interface TableViewController ()

@end

@implementation TableViewController

-(NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    _delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if ([_delegate respondsToSelector:@selector(persistentContainer)]) {
        context = _delegate.persistentContainer.viewContext;
    }
    return context;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
        // Fetch the devices from persistent data store
        NSManagedObjectContext *managedObjectContect = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"User"];
        self.userArray = [[managedObjectContect executeFetchRequest:fetchRequest error:nil]mutableCopy];
        [self.tblView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSManagedObject *device = [self.userArray objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [device valueForKey:@"name"]]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", [device valueForKey:@"place"]]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", [device valueForKey:@"mobile"]]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES; // Edit
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [context deleteObject:[self.userArray objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@%@", error, [error localizedDescription]);
            return;
        }
        [self.userArray removeObjectAtIndex:indexPath.row];
        [self.tblView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]isEqualToString:@"updateEntry"]) {
        NSManagedObject *selecteddevice = [self.userArray objectAtIndex:[[self.tblView indexPathForSelectedRow]row]];
        RegistrationViewController *destination = segue.destinationViewController;
        destination.userDB = selecteddevice;
    }
}
@end

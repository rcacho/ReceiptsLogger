//
//  CreaterViewController.m
//  Receipts++
//
//  Created by ricardo antonio cacho on 2015-07-21.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "CreatorViewController.h"
#import "CoreDataStack.h"
#import "Receipts.h"
#import "Tags.h"
#import "Taghandler.h"
#import "TagCell.h"

@interface CreatorViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *receiptDescriptonTextField;

@property (weak, nonatomic) IBOutlet UITextField *receiptAmountTextField;

@property (weak, nonatomic) IBOutlet UITextField *tagNameTextField;

@property Taghandler *tags;

@property NSString *receiptDescripton;

@property double receiptAmount;

@property NSString *tagName;

@end

@implementation CreatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tags = [[Taghandler alloc] init];
    self.tags.viewController = self;
    [self.tags fetch];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.tags numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tags numberOfRowsForSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.tags titleForHeaderInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TagCell *tagCell = [self.tableView dequeueReusableCellWithIdentifier:@"tagCell"];
    tagCell.tagForCell = [self.tags objectAtIndex:indexPath];
    return tagCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // fill in later
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // fill in later
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


- (void)reloadData {
    [self.tableView reloadData];
}



#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isEqual:self.receiptDescriptonTextField]) {
        self.receiptDescripton = textField.text;
        
    } else if ([textField isEqual:self.receiptAmountTextField]) {
        self.receiptAmount = [textField.text doubleValue];
        
    } else if ([textField isEqual:self.tagNameTextField]) {
        self.tagName = textField.text;
    
    }
}


#pragma mark - IBActions

- (IBAction)createNewReceipt:(UIButton *)sender {
    // create new entity...
    CoreDataStack *theCoreDataStack = [CoreDataStack defaultStack];
    Receipts *aReceipt = [NSEntityDescription insertNewObjectForEntityForName:@"Receipts" inManagedObjectContext:
     theCoreDataStack.managedObjectContext];
    aReceipt.receiptDescription = self.receiptDescripton;
    aReceipt.amount = self.receiptAmount;
    aReceipt.timeStamp = [[NSDate date] timeIntervalSince1970];
    
    [self.delegate changedObject:@"receipts"];
    
}

- (IBAction)createNewTag:(UIButton *)sender {
    // create new entity...
    // will need a new handler??
    CoreDataStack *theCoreDataStack = [CoreDataStack defaultStack];
    Tags *aTag = [NSEntityDescription insertNewObjectForEntityForName:@"Tags" inManagedObjectContext:
                          theCoreDataStack.managedObjectContext];
    aTag.tagName = self.tagName;
    
    [self.tags save];
}

@end

//
//  ReciptsRootViewController.m
//  Receipts++
//
//  Created by ricardo antonio cacho on 2015-07-21.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "ReceiptsRootViewController.h"
#import "ReceiptsCell.h"
#import "ReceiptHandler.h"

@interface ReceiptsRootViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property ReceiptHandler *receipts;

@end

@implementation ReceiptsRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.receipts = [[ReceiptHandler alloc] init];
    self.receipts.viewController = self;
    [self.receipts fetch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.receipts numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.receipts numberOfRowsForSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.receipts titleForHeaderInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReceiptsCell *receiptCell = [self.tableView dequeueReusableCellWithIdentifier:@"receiptCell"];
    receiptCell.receiptForCell = [self.receipts objectAtIndex:indexPath];
    return receiptCell;
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

#pragma mark - AlertHandler Protocal

- (void)changedObject:(NSString *)entity {
    if ([entity isEqualToString:@"receipts"]) {
        [self.receipts save];
    } else if ([entity isEqualToString:@"tags"]) {
        
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"createNewReceipt"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

#pragma mark - IBActions

- (IBAction)createNewReceipt:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"createNewReceipt" sender:self];
}


@end

//
//  ReceiptHandler.m
//  
//
//  Created by ricardo antonio cacho on 2015-07-21.
//
//

#import "ReceiptHandler.h"

@interface ReceiptHandler () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ReceiptHandler

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - fetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    CoreDataStack *theCoreDateStack = [CoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [self entryListFetchRequest];
    
    // how do I section name by a relationship??
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:theCoreDateStack.managedObjectContext sectionNameKeyPath:@"relationship" cacheName:nil];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (NSFetchRequest *)entryListFetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Receipts"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"timeStamp" ascending:YES]];
    return fetchRequest;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    // call the controller to reload the table view
    [self.viewController reloadData];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    // call the controller to reload the table view
    [self.viewController reloadData];
}

- (NSString *)getTitleForHeaderInSection:(NSInteger)section {
    return [self.fetchedResultsController.sections[section] name];
}

- (void)fetch {
    [self.fetchedResultsController performFetch:nil];
}

- (void)save {
    CoreDataStack *theCoreDataStack = [CoreDataStack defaultStack];
    NSArray *listToInspect = self.fetchedResultsController.fetchedObjects;
    [theCoreDataStack saveContext];
}


#pragma mark - Receipts Collection

- (Receipts *)objectAtIndex:(NSIndexPath *)indexPath {
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (NSInteger)numberOfSections {
     return self.fetchedResultsController.sections.count;
}

- (NSInteger)numberOfRowsForSection:(NSInteger)section {
    return [self.fetchedResultsController.sections[section] numberOfObjects];
}

- (NSString *)titleForHeaderInSection:(NSInteger)section {
    return [self.fetchedResultsController.sections[section] name];
}

@end

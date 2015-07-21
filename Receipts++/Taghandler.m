//
//  Taghandler.m
//  Receipts++
//
//  Created by ricardo antonio cacho on 2015-07-21.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "Taghandler.h"
#import "CoreDataStack.h"

@interface Taghandler () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation Taghandler

- (instancetype)init {
    self = [super init];
    if (self) {
        // move this to view did load of the controller...
        [self.fetchedResultsController performFetch:nil];
    }
    return self;
}

#pragma mark FetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    CoreDataStack *theCoreDateStack = [CoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [self entryListFetchRequest];
    
    // how do I section name by a relationship??
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:theCoreDateStack.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (NSFetchRequest *)entryListFetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tags"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"tagName" ascending:YES]];
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
    [theCoreDataStack saveContext];
}

#pragma mark - Receipts Collection

- (Tags *)objectAtIndex:(NSIndexPath *)indexPath {
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

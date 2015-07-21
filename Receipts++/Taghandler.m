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

@property (nonatomic) NSArray *fetchedTags;

@end

@implementation Taghandler

#pragma mark FetchedResultsController


- (void)fetch {
    self.fetchedTags = [self requestObjects];
    
}


- (NSArray *)requestObjects {
    CoreDataStack *theCoreDataStack = [CoreDataStack defaultStack];
    NSManagedObjectContext *managedObjectContext = theCoreDataStack.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [self entryListFetchRequest];
    NSError *error;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil)
    {
        // Deal with error...
    }
    return fetchedObjects;
}

- (NSFetchRequest *)entryListFetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tags"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"tagName" ascending:YES]];
    return fetchRequest;
}

- (void)save {
    CoreDataStack *theCoreDataStack = [CoreDataStack defaultStack];
    [theCoreDataStack saveContext];
    [self fetch];
    [self.viewController reloadData];
}


#pragma mark - Receipts Collection

- (Tags *)objectAtIndex:(NSIndexPath *)indexPath {
    return self.fetchedTags[indexPath.row];
}

- (NSInteger)numberOfSections {
    return 1;
}

- (NSInteger)numberOfRowsForSection:(NSInteger)section {
    return self.fetchedTags.count;
}

- (NSString *)titleForHeaderInSection:(NSInteger)section {
    return @"TAGS";
}


@end

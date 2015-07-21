//
//  ReceiptHandler.m
//  
//
//  Created by ricardo antonio cacho on 2015-07-21.
//
//

#import "ReceiptHandler.h"
#import "Tags.h"

@interface ReceiptHandler ()

@property NSDictionary *receiptsCollection;

@end

@implementation ReceiptHandler

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - fetching results

- (void)fetch {
    NSArray *fetchedObject = [self requestObjects];
    [self arrangeSections:fetchedObject];
    
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
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Receipts"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"timeStamp" ascending:YES]];
    return fetchRequest;
}

- (void)save {
    CoreDataStack *theCoreDataStack = [CoreDataStack defaultStack];
    [theCoreDataStack saveContext];
    [self fetch];
    [self.viewController reloadData];
}


#pragma mark - Receipts Collection

- (Receipts *)objectAtIndex:(NSIndexPath *)indexPath {
    return self.receiptsCollection.allValues[indexPath.section][indexPath.row];
}

- (NSString *)getTitleForHeaderInSection:(NSInteger)section {
    return self.receiptsCollection.allKeys[section];
}

- (NSInteger)numberOfSections {
     return self.receiptsCollection.allKeys.count;
}

- (NSInteger)numberOfRowsForSection:(NSInteger)section {
    return [self.receiptsCollection.allValues[section] count];
}

- (NSString *)titleForHeaderInSection:(NSInteger)section {
    return self.receiptsCollection.allKeys[section];
}

#pragma mark - Dictionary Methods

- (void)arrangeSections:(NSArray *)fetchedObjects {
    
    
    NSDictionary *objectsInDict = [self arrangeThroughLists:fetchedObjects];
    self.receiptsCollection = [[NSDictionary alloc] initWithDictionary:objectsInDict];
}


- (NSMutableDictionary *)arrangeThroughLists:(NSArray *)fetchedObjects {
    
    NSMutableDictionary *objectsInDict = [[NSMutableDictionary alloc] init];
    
    NSMutableSet *setOfTags = [[NSMutableSet alloc] init];
    for (Receipts *aReceipts in fetchedObjects) {
        NSMutableSet *tempSet = [[NSMutableSet alloc] init];
        [tempSet unionSet:aReceipts.relationship];
        [tempSet minusSet:setOfTags];
        for (Tags *tag in tempSet) {
            // add an item to the dict with the key tagname
            [objectsInDict setObject:[[NSMutableArray alloc] init] forKey:tag.tagName];
        }
        
        for (Tags *aTag in aReceipts.relationship) {
            // add the receipt into the arrays
            NSMutableArray *list = [objectsInDict objectForKey:aTag.tagName];
            [list addObject:aReceipts];
        }
        
        [setOfTags unionSet:tempSet];
    }
    
    return objectsInDict;
}

- (BOOL)doesDictionary:(NSMutableDictionary *)dictionary containTag:(Tags *)aTag {
    for (NSString *tagName in dictionary.allKeys) {
        if (tagName == aTag.tagName) {
            return YES;
        }
    }
    return NO;
}


@end

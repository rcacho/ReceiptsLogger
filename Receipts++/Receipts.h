//
//  Receipts.h
//  
//
//  Created by ricardo antonio cacho on 2015-07-21.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tags;

@interface Receipts : NSManagedObject

@property (nonatomic) double amount;
@property (nonatomic) NSTimeInterval timeStamp;
@property NSString* receiptDescription;
@property (nonatomic, retain) NSSet *relationship;
@end

@interface Receipts (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(Tags *)value;
- (void)removeRelationshipObject:(Tags *)value;
- (void)addRelationship:(NSSet *)values;
- (void)removeRelationship:(NSSet *)values;

@end

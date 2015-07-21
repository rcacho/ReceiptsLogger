//
//  Tags.h
//  
//
//  Created by ricardo antonio cacho on 2015-07-21.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Tags : NSManagedObject

@property (nonatomic, strong) NSString * tagName;
@property (nonatomic, strong) NSSet *relationship;
@end

@interface Tags (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(NSManagedObject *)value;
- (void)removeRelationshipObject:(NSManagedObject *)value;
- (void)addRelationship:(NSSet *)values;
- (void)removeRelationship:(NSSet *)values;

@end

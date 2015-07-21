//
//  ReceiptHandler.h
//  
//
//  Created by ricardo antonio cacho on 2015-07-21.
//
//

#import <Foundation/Foundation.h>
#import "ReceiptsRootViewController.h"
#import "Receipts.h"
#import "Tags.h"

@interface ReceiptHandler : NSObject 

@property ReceiptsRootViewController *viewController;

- (Receipts *)objectAtIndex:(NSIndexPath *)indexPath;

- (NSInteger)numberOfSections;

- (NSInteger)numberOfRowsForSection:(NSInteger)section;

- (NSString *)titleForHeaderInSection:(NSInteger)section;

- (void)fetch;

- (void)save;

@end

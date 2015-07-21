//
//  ReciptsRootViewController.h
//  Receipts++
//
//  Created by ricardo antonio cacho on 2015-07-21.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"
#import "CreatorViewController.h"

@interface ReceiptsRootViewController : UIViewController <AlertHandlerProtocal>

- (void)reloadData;

- (void)changedObject:(NSString *)entity;

@end

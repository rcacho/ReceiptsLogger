//
//  CreaterViewController.h
//  Receipts++
//
//  Created by ricardo antonio cacho on 2015-07-21.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlertHandlerProtocal <NSObject>

- (void)changedObject:(NSString *)entity;

@end

@interface CreatorViewController : UIViewController

@property id<AlertHandlerProtocal>delegate;

- (void)reloadData;

@end

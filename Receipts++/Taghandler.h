//
//  Taghandler.h
//  Receipts++
//
//  Created by ricardo antonio cacho on 2015-07-21.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreatorViewController.h"
#import "Tags.h"

@interface Taghandler : NSObject

@property CreatorViewController *viewController;

- (Tags *)objectAtIndex:(NSIndexPath *)indexPath;

- (NSInteger)numberOfSections;

- (NSInteger)numberOfRowsForSection:(NSInteger)section;

- (NSString *)titleForHeaderInSection:(NSInteger)section;

- (void)fetch;

- (void)save;

@end

//
//  tagCell.m
//  Receipts++
//
//  Created by ricardo antonio cacho on 2015-07-21.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "TagCell.h"

@interface TagCell ()

@property (weak, nonatomic) IBOutlet UILabel *tagNameLabel;

@end

@implementation TagCell


- (void)setTagForCell:(Tags *)tagForCell {
    _tagForCell = tagForCell;
    [self setContent];
}

- (void)setContent {
    self.tagNameLabel.text = self.tagForCell.tagName;
}

@end

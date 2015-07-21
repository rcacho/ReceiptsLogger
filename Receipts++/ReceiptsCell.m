//
//  ReceiptsCell.m
//  Receipts++
//
//  Created by ricardo antonio cacho on 2015-07-21.
//  Copyright (c) 2015 ricardo antonio cacho. All rights reserved.
//

#import "ReceiptsCell.h"

@interface ReceiptsCell ()

@property (weak, nonatomic) IBOutlet UILabel *receiptAmountLabel;

@property (weak, nonatomic) IBOutlet UILabel *receiptTimeStampLabel;

@property (weak, nonatomic) IBOutlet UILabel *receiptDescriptionLabel;

@end

@implementation ReceiptsCell


- (void)setReceiptForCell:(Receipts *)receiptForCell {
    _receiptForCell = receiptForCell;
    [self setContent];
}


- (void)setContent {
    // should round the number to 2 decimal places...
    self.receiptAmountLabel.text = [NSString stringWithFormat:@"%f",self.receiptForCell.amount];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:
                                [NSDate dateWithTimeIntervalSince1970:self.receiptForCell.timeStamp]];

    self.receiptTimeStampLabel.text = stringFromDate;
    self.receiptDescriptionLabel.text = self.receiptForCell.receiptDescription;
}

@end

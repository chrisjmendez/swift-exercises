//
//  FileMessageTableViewCell.h
//  SendBirdiOSSample
//
//  Created by SendBird Developers on 2015. 7. 29..
//  Copyright (c) 2015 SENDBIRD.COM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SendBirdSDK/SendBirdSDK.h>
#import "SendBirdCommon.h"

@interface FileMessageTableViewCell : UITableViewCell

@property (retain) UILabel *nicknameLabel;
@property (retain) UILabel *messageLabel;
@property (retain) UIImageView *fileImageView;
@property (retain) UILabel *filenameLabel;
@property (retain) UILabel *filesizeLabel;

- (void) setModel:(SendBirdFileLink *)model;
- (CGFloat)getHeightOfViewCell:(CGFloat)totalWidth;

@end

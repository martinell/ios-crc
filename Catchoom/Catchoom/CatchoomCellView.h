//
//© Catchoom Technologies S.L.
//Licensed under the MIT license.
//http://github.com/Catchoom/ios-crc/blob/master/LICENSE.md
//
//
//  CatchoomCellView.h
//  Catchoom
//
//  Created by Crisredfi on 9/19/12.
//  Copyright (c) 2012 Catchoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatchoomCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

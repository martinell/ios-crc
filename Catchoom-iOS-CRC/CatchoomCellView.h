//
// © Catchoom Technologies S.L.
// Licensed under the MIT license.
// https://github.com/Catchoom/ios-crc/blob/master/LICENSE
//
//
//  CatchoomCellView.h
//

#import <UIKit/UIKit.h>

@interface CatchoomCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

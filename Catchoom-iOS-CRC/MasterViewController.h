//
// © Catchoom Technologies S.L.
// Licensed under the MIT license.
// https://github.com/Catchoom/ios-crc/blob/master/LICENSE
//
//
//  MasterViewController.h
//  

#import <UIKit/UIKit.h>
#import <Catchoom-iOS-SDK/Catchoom-iOS-SDK.h>

@class DetailViewController;

@interface MasterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, RKObjectLoaderDelegate, UIPopoverControllerDelegate, CatchoomServiceProtocol>

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIPopoverController *myPopoverControler;



@end

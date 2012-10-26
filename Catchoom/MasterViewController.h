//
//© Catchoom Technologies S.L.
//Licensed under the MIT license.
//http://github.com/Catchoom/ios-crc/blob/master/LICENSE.md
//
//
//  MasterViewController.h
//  Cachoom
//
//  Created by Crisredfi on 9/15/12.
//  Copyright (c) 2012 Catchoom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CRSMobile/CRSMobile.h>

@class DetailViewController;

@interface MasterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, RKObjectLoaderDelegate, UIPopoverControllerDelegate, CatchoomServiceProtocol>

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIPopoverController *myPopoverControler;



@end

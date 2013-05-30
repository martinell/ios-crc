//
// © Catchoom Technologies S.L.
// Licensed under the MIT license.
// https://github.com/Catchoom/ios-crc/blob/master/LICENSE
//
//
//  MasterViewController.m
// 

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "LogInViewController.h"
#import "CatchoomCellView.h"
#import <QuartzCore/QuartzCore.h>

#pragma mark -
#pragma mark - UIImagePickerController customization for iOS 6
//since ios 6 has changed orientation structure, we must ask the UIImagePickerController not to rotate.
@interface NonRotatingUIImagePickerController : UIImagePickerController

@end

@implementation NonRotatingUIImagePickerController

- (BOOL)shouldAutorotate
{
    return NO;
}

@end
/////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - class definition

@interface MasterViewController () {
    NSMutableArray *_parsedElements;
    UIView *_activityIndicatorView;

    __weak IBOutlet UIBarButtonItem *retakePictureButton;
    __weak IBOutlet UIBarButtonItem *cameraButton;
    __weak IBOutlet UIBarButtonItem *libraryButton;
    
}
@end

@implementation MasterViewController
@synthesize myPopoverController = _myPopoverController;


- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    UIImage *titleImage = [UIImage imageNamed:@"logo_title"];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:titleImage];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];

    self.navigationItem.titleView = titleImageView;
        self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        [self performSegueWithIdentifier:@"logInSegue" sender:self];
        
    }else{
        [self.navigationController setNavigationBarHidden:NO];
        self.navigationItem.hidesBackButton = YES;
    }
}

- (IBAction)presentMainCatchoomView:(id)sender {
    [self performSegueWithIdentifier:@"logInAnimated" sender:self];
}



- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];
}




- (void)viewDidUnload
{
    [self setTableView:nil];
    libraryButton = nil;
    cameraButton = nil;
    retakePictureButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

//ios 5 or lower
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        return (interfaceOrientation == UIInterfaceOrientationLandscapeRight );
    }else{
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
}


- (BOOL)shouldAutorotate{
    return NO;
}
//ios 6 or higher
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationMaskLandscapeRight;
}
- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        return UIInterfaceOrientationMaskLandscapeRight;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _parsedElements.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CatchoomSearchResponseItem *model = [_parsedElements objectAtIndex:indexPath.row];
    CatchoomCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"CatchoomCellView"];
    cell.titleLabel.text = model.iconName;
    cell.detailLabel.text = [NSString stringWithFormat:@"Score: %@", model.score];
    if(!model.iconImage){

        //add a placeholder while we are downloading.
        cell.logoImage.image = [UIImage imageNamed:@"viewport.png"];
        
        UIImageFromURL( [NSURL URLWithString:model.thumbnail], ^( UIImage * image )
                       {
                           cell.logoImage.image = image;
                           NSData *dataObj = UIImageJPEGRepresentation(image, 1.0);
                           model.iconImage = dataObj;
                       }, ^(void){
                           NSLog(@"%@",@"error!");
                       });
    }else {
        cell.logoImage.image = [UIImage imageWithData:model.iconImage];
    }
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        CatchoomSearchResponseItem *model = [_parsedElements objectAtIndex:indexPath.row];
        NSString *urlWithPrefix;
        if([model.url hasPrefix:@"http://"]){
            urlWithPrefix  = model.url;
            
        }else{
            urlWithPrefix = [NSString stringWithFormat:@"http://%@", model.url];
        }
        self.detailViewController.url = [NSURL URLWithString:urlWithPrefix];
        [self.detailViewController executeRequest];
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CatchoomSearchResponseItem *model = [_parsedElements objectAtIndex:indexPath.row];
        NSString *urlWithPrefix;
        if([model.url hasPrefix:@"http://"]){
            urlWithPrefix  = model.url;
            
        }else{
            urlWithPrefix = [NSString stringWithFormat:@"http://%@", model.url];
        }

        [[segue destinationViewController] loadWebViewWithContentUrl:[NSURL URLWithString:urlWithPrefix]];
        
    }else if ([[segue identifier]isEqualToString:@"logInSegue"]){
        
    }
}


#pragma mark - Take image

- (IBAction)pickImageFromResources:(id)sender
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){

        if ([self.myPopoverController isPopoverVisible]) {
            [self.myPopoverController dismissPopoverAnimated:YES];
        } else {
            if ([UIImagePickerController isSourceTypeAvailable:
                 UIImagePickerControllerSourceTypeSavedPhotosAlbum])
            {
                UIImagePickerController *imagePicker = [[NonRotatingUIImagePickerController alloc] init];
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.delegate = self;
                imagePicker.allowsEditing = NO;
                self.myPopoverController = [[UIPopoverController alloc]
                                           initWithContentViewController:imagePicker];
                
                _myPopoverController.delegate = self;
                
                [self.myPopoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp  animated:YES];
            }
        }
    }else{
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;
        [self presentModalViewController:imagePicker animated:YES];
    }
}

- (IBAction)takeImageFromCamera:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [[CatchoomService sharedCatchoom] setDelegate: self];
        [self prepareForSearch];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        if ([prefs boolForKey:@"finder_mode"]) {
            // Finder Mode
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                [[CatchoomService sharedCatchoom] startFinderMode:2 withPreview: self.detailViewController];
            }
            else{
                [[CatchoomService sharedCatchoom] startFinderMode:2 withPreview: self];
            }
        }
        else{
       
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                [[CatchoomService sharedCatchoom] startOneShotModeWithPreview: self.detailViewController];
            }
            else{
                [[CatchoomService sharedCatchoom] startOneShotModeWithPreview: self];
            }
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"WARNING" ,@"")
                                                        message:@"This device does not have a camera. Try selecting an image from your photo library."
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                              otherButtonTitles: nil];
        [alert show];
    }
}

#pragma mark -
#pragma mark - image picker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self.myPopoverController dismissPopoverAnimated:true];

    }

    
    UIImage *image = (UIImage*)[info valueForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissModalViewControllerAnimated:YES];
    
    [self prepareForSearch];
    [self willShowActivityIndicatorInMasterView];

    dispatch_queue_t backgroundQueue;
    backgroundQueue = dispatch_queue_create("com.catchoom.catchoom.background", NULL);
    dispatch_async(backgroundQueue, ^(void) {
        [self sendImageToServer:image];
    });
    
    
    dispatch_release(backgroundQueue);
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
    
}



#pragma mark - background thread sending image to catchoom server

-(void) prepareForSearch
{
    // Clean previsouly shown results
    if (_parsedElements == nil) {
        _parsedElements = [NSMutableArray array];
    }
    [_parsedElements removeAllObjects];
    
    [self.tableView reloadData];
    [self.tableView setScrollEnabled:NO];
    
    // Disable settings button while search is performed.
    UIBarButtonItem *settingsButton = self.navigationItem.leftBarButtonItem;
    settingsButton.enabled = NO;
}

-(void) restoreFromSearch
{
    [self.tableView reloadData];
    [self.tableView setScrollEnabled:TRUE];
    
    UIBarButtonItem *settingsButton = self.navigationItem.leftBarButtonItem;
    settingsButton.enabled = YES;
}

-(void) sendImageToServer:(UIImage*) image
{
    
    [[CatchoomService sharedCatchoom] setDelegate: self];
    [[CatchoomService sharedCatchoom] search:image];
    
}

- (void)didReceiveSearchResponse:(NSArray *)responseObjects {

    [_parsedElements removeAllObjects]; //remove all existing objects
    _parsedElements = [responseObjects mutableCopy];
    
    NSLog(@"%d matches found.",[_parsedElements count]);
    
    [self restoreFromSearch];
    
    if ([[CatchoomService sharedCatchoom] getSearchType] != kSearchTypeFinderMode) {
        if([_parsedElements count] == 0)
        {
            // The request was processed correctly. Show no match alert in _isOneShotModeON.
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NO MATCH", @"")
                                                            message:NSLocalizedString(@"there is no object in the collection that matches with any in the picture", @"")
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                                  otherButtonTitles: nil];
            
            [alert show];
            
        }
        
        if ([[CatchoomService sharedCatchoom] getSearchType] == kSearchTypeImage) {
            // if the image was taken from UIImagePickerControllerSourceTypePhotoLibrary
            __weak MasterViewController *currentSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [currentSelf willHideActivityIndicatorInMasterView];
            });
        }
    }

}

- (void)didFailLoadWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERROR",@"")
                                                    message:NSLocalizedString(@"there's been an error while trying to connect to the server", @"")
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"OK",@"")
                                          otherButtonTitles: nil];
    [alert show];
    
    if ([[CatchoomService sharedCatchoom] getSearchType] == kSearchTypeImage){
        // if the image was taken from UIImagePickerControllerSourceTypePhotoLibrary
        __weak MasterViewController *currentSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [currentSelf willHideActivityIndicatorInMasterView];
        });
    }
    
    [self restoreFromSearch];
}
- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    //delegate method that we are not going to use since we are using blocks
}




#pragma mark -
#pragma mark - activity indicator

- (void)willShowActivityIndicatorInMasterView {
    [self willHideActivityIndicatorInMasterView];

    _activityIndicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 200)];
    _activityIndicatorView.center = CGPointMake(self.tableView.frame.size.width / 2 ,
                                                (self.tableView.frame.size.height / 2) - 20 );
    _activityIndicatorView.layer.cornerRadius = 5.0f;
    _activityIndicatorView.layer.borderWidth = 1.0;
    _activityIndicatorView.layer.borderColor = [UIColor blackColor].CGColor;
    _activityIndicatorView.backgroundColor = [UIColor blackColor];
    _activityIndicatorView.alpha = 0.5f;
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 230, 100)];
    infoLabel.text = NSLocalizedString(@"Uploading the image to the server, this may take a while...", @"");
    infoLabel.numberOfLines = 3;
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.textAlignment = UITextAlignmentCenter;
    infoLabel.backgroundColor = [UIColor clearColor];
    [_activityIndicatorView addSubview:infoLabel];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.center = CGPointMake(_activityIndicatorView.frame.size.width / 2 ,
                                           (_activityIndicatorView.frame.size.height / 2) + 20 );
    [activityIndicator startAnimating];
    [_activityIndicatorView addSubview:activityIndicator];
    
    [self.tableView addSubview:_activityIndicatorView];
    
}

- (void)willHideActivityIndicatorInMasterView {
    [_activityIndicatorView removeFromSuperview];
}



@end

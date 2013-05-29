//
// © Catchoom Technologies S.L.
// Licensed under the MIT license.
// https://github.com/Catchoom/ios-crc/blob/master/LICENSE
//
//
//  LogInViewController.m
//  

#import "LogInViewController.h"
#import "AppDelegate.h"

@interface LogInViewController ()
//@property (weak, nonatomic) IBOutlet UISwitch *saveSwitch;

@end

//BOOL isTokenIntroduced = NO;

@implementation LogInViewController


#pragma mark - view lifecicle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.hidesBackButton = YES;
    
    self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.frame.size.width, self.mainScrollView.frame.size.height + 200);
    self.mainScrollView.scrollEnabled = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults boolForKey:@"isTokenIntroduced"]){
        //[self.saveSwitch setOn:YES];
        //self.collectionTextView.text = [defaults valueForKey:@"collection"];
        self.tokenTextView.text = [defaults valueForKey:@"token"];
    } else {
        //[defaults setObject:@"" forKey:@"collection"];
        [defaults setObject:@"" forKey:@"token"];
        //[self.saveSwitch setOn:NO];
    }

    
    UIImage *backgroundImage = [UIImage imageNamed:@"bg_main"];
    
    backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:floorf(backgroundImage.size.width/2) topCapHeight:floorf(backgroundImage.size.height/2)];
    self.backgroundImageView.image = backgroundImage;
    UIImage *bubbleImage = [UIImage imageNamed:@"bubble9"];
    bubbleImage = [bubbleImage stretchableImageWithLeftCapWidth:floorf(backgroundImage.size.width/2) topCapHeight:floorf(backgroundImage.size.height/2)];
    
    //self.bubbleImageView.image = bubbleImage;
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UIImage *titleImage = [UIImage imageNamed:@"logo_title"];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:titleImage];
    self.navigationItem.titleView = titleImageView;
    
    if (![[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.tabBarController.tabBar.hidden = YES;
        //iphone 5 compatibility
        long height = [[UIScreen mainScreen] bounds].size.height;
    
        [[self.tabBarController.view.subviews objectAtIndex:0] setFrame:CGRectMake(0, 0, 320, height)];
        
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(myKeyboardWillHideHandler:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }

    
        

}

- (void)viewDidUnload
{
    [self setBackgroundImageView:nil];
    //[self setBubbleImageView:nil];
    //[self setCollectionTextView:nil];
    [self setTokenTextView:nil];
    [self setMainScrollView:nil];
    //[self setSaveSwitch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {

    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight );
    }else{
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }
}
- (BOOL)shouldAutorotate{
    return YES;
}
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

- (void) hideTabBar {
    
    
    [UIView animateWithDuration:0.4 animations:^{
        [UIView setAnimationDuration:0.4];
        for(UIView *view in self.tabBarController.view.subviews)
        {
            CGRect _rect = view.frame;
            if([view isKindOfClass:[UITabBar class]])
            {

                    _rect.origin.y = 480;
                    [self.navigationController.view setFrame:_rect];
                
            }
    }
    } completion:^(BOOL finished) {
    }];
}


#pragma mark - iPad logIn

- (IBAction)didClickStartButton:(id)sender
{
    
    [[CatchoomService sharedCatchoom] setDelegate: self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [[CatchoomService sharedCatchoom] connect:[defaults stringForKey:@"token"]];

}

- (void)didReceiveConnectResponse:(id)sender {
    
    
    RKResponse *response = sender;
    NSArray *parsedResponse = [response parsedBody:NULL];
    if([parsedResponse count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERROR",@"")
                                                        message:NSLocalizedString(@"there's been an error while trying to connect to the server", @"")
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"OK",@"")
                                              otherButtonTitles: nil];
        [alert show];
    }else{
        if([parsedResponse valueForKey:@"message"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Token Invalid",@"")
                                                            message:[parsedResponse valueForKey:@"message"]
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"OK",@"")
                                                  otherButtonTitles: nil];
            [alert show];
        }else{
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                [self dismissModalViewControllerAnimated:YES];
                
            }else{
                [self performSegueWithIdentifier:@"pushToTableView" sender:self];
            }
            
            
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
}



#pragma mark - textfield delegate


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {


    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    [self saveTokenInDefaults];

}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    // called when clear button pressed. return NO to ignore (no notifications)
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //[self.collectionTextView resignFirstResponder];
    [self.tokenTextView resignFirstResponder];
    //[self.collectionTextView resignFirstResponder];
    [self.tokenTextView resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
        [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        self.mainScrollView.scrollEnabled = NO;
    });
    

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  // became first responder
    self.mainScrollView.scrollEnabled = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
        CGPoint bottomOffset = CGPointMake(0, self.mainScrollView.contentSize.height - self.mainScrollView.bounds.size.height);
        [self.mainScrollView setContentOffset:bottomOffset animated:YES];
    });

}

- (void)myKeyboardWillHideHandler:(NSNotification *)aNotification {
    [self saveTokenInDefaults];
    //[self.collectionTextView resignFirstResponder];
    [self.tokenTextView resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
        [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        self.mainScrollView.scrollEnabled = NO;
    });
    

}


- (void)saveTokenInDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults setObject:self.collectionTextView.text forKey:@"collection"];
    [defaults setObject:self.tokenTextView.text forKey:@"token"];
    [defaults synchronize];

    if(![defaults boolForKey:@"isTokenIntroduced"]){
        [defaults setBool:YES forKey:@"isTokenIntroduced"];
    }
}


#pragma mark - switch action

/*- (IBAction)didClickOnSwitch:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults boolForKey:@"isSaveEnabled"]){
        [defaults setBool:NO forKey:@"isSaveEnabled"];
    } else {
        [defaults setBool:YES forKey:@"isSaveEnabled"];

    }
}*/


NSString* utm_medium = @"iOS";
NSString* utm_source = @"CRCMobileApp";

- (IBAction)didClickOnSignUp:(id)sender{
    NSMutableString *urlString = [[NSMutableString alloc] initWithString: @"https://crs.catchoom.com/try-free?utm_source="];
    [urlString appendString:utm_source];
    [urlString appendString:@"&utm_medium="];
    [urlString appendString:utm_medium];
    [urlString appendString:@"&utm_campaign=SignUp"];

    NSString *escaped = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:escaped]];

}

- (IBAction)didClickOnHelpWithToken:(id)sender{
    NSMutableString *urlString = [[NSMutableString alloc] initWithString: @"http://catchoom.com/documentation/get-started/where-do-i-get-my-token/?utm_source="];
    [urlString appendString:utm_source];
    [urlString appendString:@"&utm_medium="];
    [urlString appendString:utm_medium];
    [urlString appendString:@"&utm_campaign=HelpWithToken"];
    
    NSString *escaped = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:escaped]];
    
}

- (IBAction)didClickOnAboutCatchoom:(id)sender{
    NSMutableString *urlString = [[NSMutableString alloc] initWithString: @"http://catchoom.com/?utm_source="];
    [urlString appendString:utm_source];
    [urlString appendString:@"&utm_medium="];
    [urlString appendString:utm_medium];
    [urlString appendString:@"&utm_campaign=CatchoomHome"];
    
    NSString *escaped = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:escaped]];
    
}
@end

//
//  stxViewController.m
//  screentest
//
//  Created by Stefan Jansen on 23/04/14.
//
//

#import "stxViewController.h"

@interface stxViewController ()

@end

@implementation stxViewController

- (void)setupScreenNotifications
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    // connect
    [center addObserver:self selector:@selector(handleScreenConnect:) name:UIScreenDidConnectNotification object:nil];
    // disconnect
    [center addObserver:self selector:@selector(handleScreenDisconnect:) name:UIScreenDidDisconnectNotification object:nil];
}

- (void)removeScreenNotifications
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIScreenDidConnectNotification object:nil];
    [center removeObserver:self name:UIScreenDidDisconnectNotification object:nil];
}

- (void)handleScreenConnect:(NSNotification *)aNotification
{
    UIScreen *newScreen = [aNotification object];
    CGRect bounds = newScreen.bounds;
    
    self.secondWindow = [[UIWindow alloc] initWithFrame:bounds];
    self.secondWindow.screen = newScreen;
    stxExternalViewController *rootVC = [self getVCWithIdentifier:@"henk" FromStoryboard:@"Main"];
    self.secondWindow.rootViewController = rootVC;
    self.secondWindow.hidden = NO;
    
    NSLog(@"Found a second screen!");
}

- (void)handleScreenDisconnect:(NSNotification *)aNotification
{
    if (self.secondWindow) {
        self.secondWindow.hidden = YES;
        self.secondWindow = nil;
    }
    NSLog(@"Removed the second screen!");
}

- (stxExternalViewController *)getVCWithIdentifier:(NSString *)identifier FromStoryboard:(NSString *)storyboard
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboard bundle:nil];
    stxExternalViewController *viewController = [sb instantiateViewControllerWithIdentifier:identifier];
    NSLog(@"ViewController: %@", viewController);
    return viewController;
}

- (void)showImagePicker
{
    self.picker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [self.picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    } else {
        NSLog(@"Error: no photolibrary source available");
        return;
    }
    
    [self.picker setDelegate:self];
    [self presentViewController:self.picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"Did cancel picking...");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self removeScreenNotifications];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupScreenNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

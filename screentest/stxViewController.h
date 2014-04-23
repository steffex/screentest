//
//  stxViewController.h
//  screentest
//
//  Created by Stefan Jansen on 23/04/14.
//
//

#import <UIKit/UIKit.h>
#import "stxExternalViewController.h"

@interface stxViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *selectImageButton;
@property (strong, nonatomic) UIWindow *secondWindow;
@property (strong, nonatomic) UIImagePickerController *picker;
@property (strong, nonatomic) UIImage *selectedImage;

@end

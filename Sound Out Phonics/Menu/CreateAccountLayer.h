//
//  CreateAccountLayer.h
//  Sound Out Phonics
//
//  Purpose: Create account layer that allows to create an account based on the user inputs
//
//  History: History of the file can be found here: https://github.com/TeamRedundantTeam/SoundOutPhonics/commits/master/Sound%20Out%20Phonics/Menu/CreateAccountLevel.h
//
//  Style: The source code will follow the general apple coding standard described
//         here: https://tinyurl.com/n8jtvj3
//         Furthermore, the source code will be self descriptive and the formating
//         will be consistent through the project. Long methods will be broken down
//         and will have description of what the method does. The variable names and
//         methods will follow the lower camel style (ex: selectedGraphemePosition),
//         the classes will follow the upper camel style (ex: GameLayer) and the
//         files will use the Cocos2d-iphone file name convention (ex: Lvl1-Apple-
//         Sprite.png). Finally, the code will have comments throughout various non
//         trivial operations.
//
//  Created on 2013-11-23.
//  Copyright (c) 2013 Team Redundant Team. All rights reserved.
//

#import "cocos2d.h"
#import <UIKit/UIKit.h>
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "MenuLayer.h"
#import "StateText.h"
#import "SOPDatabase.h"

@interface CreateAccountLayer : CCLayerColor <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UITextFieldDelegate>{
    CGSize _size;                           // Size of the screen
    int _accountLevel;                      // Keeps track of what account type should be created
    UITextField *_nameTextBox;              // account name textbox
    UITextField *_passwordTextBox;          // password textbox input field
    UITextField *_confirmPasswordTextBox;   // confirm password textbox input field
    StateText *_createAccountButton;        // Reference to create account button
    StateText *_updatePictureButton;        // Reference to picture button
    CCLabelTTF *_errorMessage;              // Reference to error message text
    CCSprite *_exitButton;                  // Reference to the exit button
    NSString *filePath;                     // Reference to path of image
}

// returns a CCScene that contains the LoginLayer as the only child
- (id)initWithColor:(ccColor4B)color withLevel:(int)accountLevel;

@property (retain, nonatomic) UITextField *nameTextBox;
@property (retain, nonatomic) UITextField *passwordTextBox;
@property (retain, nonatomic) UITextField *confirmPasswordTextBox;
@end

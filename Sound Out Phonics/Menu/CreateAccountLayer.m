//
//  CreateAccountLayer.m
//  Sound Out Phonics
//
//  Purpose: Create account layer that allows to create an account based on the user inputs
//
//  History: History of the file can be found here: https://github.com/TeamRedundantTeam/SoundOutPhonics/commits/master/Sound%20Out%20Phonics/Menu/CreateAccountLevel.m
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

#import "CreateAccountLayer.h"

#pragma mark - CreateAccountLayer

@implementation CreateAccountLayer
@synthesize nameTextBox = _nameTextBox;
@synthesize passwordTextBox = _passwordTextBox;
@synthesize confirmPasswordTextBox = _confirmPasswordTextBox;

// on "init" you need to initialize your instance
- (id)initWithColor:(ccColor4B)color withLevel:(int)accountLevel {
	if((self = [super initWithColor:color])) {
        filePath = @"";
        // store the account level into the class
        _accountLevel = accountLevel;
        
        // enable touch for this layer
        [self setTouchEnabled:YES];
        
        // get the screen size of the device
        _size = [[CCDirector sharedDirector] winSize];
        
        // create and initialize a background
        CCSprite *background = [CCSprite spriteWithFile:@"Default-Background.png"];
        background.position = ccp(_size.width/2, _size.height/2);
        background.scale = 0.75;
        [self addChild:background];
        
        // add CREATE account icon to victory layer
        CCSprite *createAccount = [CCSprite spriteWithFile:@"Plus-Icon.png"];
        createAccount.position = ccp(_size.width/2-145, _size.height-553);
        [self addChild: createAccount];
        
        // add update icon to edit account layer
        CCSprite *takePicture = [CCSprite spriteWithFile:@"Camera-Icon.png"];
        takePicture.position = ccp(_size.width/2-145, _size.height-471);
        [self addChild: takePicture];
        
        // create header text
        CCLabelTTF *layerName;
        if (accountLevel == 1)
            layerName = [CCLabelTTF labelWithString:@"create admin account" fontName:@"KBPlanetEarth" fontSize:48];
        else
            layerName = [CCLabelTTF labelWithString:@"create player account" fontName:@"KBPlanetEarth" fontSize:48];
        layerName.position = ccp(_size.width/2, _size.height-150);
        [self addChild:layerName];
        
        //
        // create the name textbox
        //
        self.nameTextBox = [[UITextField alloc] initWithFrame:CGRectMake(_size.width/2-100, _size.height/2-175, 200, 50)];
        self.nameTextBox.backgroundColor = [UIColor whiteColor];
        self.nameTextBox.delegate = self;
        self.nameTextBox.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.nameTextBox.adjustsFontSizeToFitWidth = true;
        
        // grey text inside the box
        NSAttributedString *nameText = [[NSAttributedString alloc] initWithString:@"Name"];
        self.nameTextBox.attributedPlaceholder = nameText;
        
        // disable spellchecker
        self.nameTextBox.spellCheckingType = UITextSpellCheckingTypeNo;
        
        [nameText release];
        [[CCDirector sharedDirector].view addSubview:self.nameTextBox];
        
        //
        // create the password textbox
        //
        self.passwordTextBox = [[UITextField alloc] initWithFrame:CGRectMake(_size.width/2-100, _size.height/2-100, 200, 50)];
        self.passwordTextBox.backgroundColor = [UIColor whiteColor];
        self.passwordTextBox.delegate = self;
        self.passwordTextBox.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.passwordTextBox.adjustsFontSizeToFitWidth = true;
        
        // grey text inside the box
        NSAttributedString *passwordName = [[NSAttributedString alloc] initWithString:@"Password"];
        self.passwordTextBox.attributedPlaceholder = passwordName;
        
        // no spellchecker and make the input text display as ****
        self.passwordTextBox.spellCheckingType = UITextSpellCheckingTypeNo;
        self.passwordTextBox.secureTextEntry = true;
        [passwordName release];
        [[CCDirector sharedDirector].view addSubview:self.passwordTextBox];
        
        //
        // create the confirm password textbox
        //
        self.confirmPasswordTextBox = [[UITextField alloc] initWithFrame:CGRectMake(_size.width/2-100, _size.height/2-25, 200, 50)];
        self.confirmPasswordTextBox.backgroundColor = [UIColor whiteColor];
        self.confirmPasswordTextBox.delegate = self;
        self.confirmPasswordTextBox.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.confirmPasswordTextBox.adjustsFontSizeToFitWidth = true;
        
        // grey text inside the box
        NSAttributedString *confirmPasswordName = [[NSAttributedString alloc] initWithString:@"Confirm Password"];
        self.confirmPasswordTextBox.attributedPlaceholder = confirmPasswordName;
        
        // no spellchecker and make the input text display as ****
        self.confirmPasswordTextBox.spellCheckingType = UITextSpellCheckingTypeNo;
        self.confirmPasswordTextBox.secureTextEntry = true;
        [confirmPasswordName release];
        [[CCDirector sharedDirector].view addSubview:self.confirmPasswordTextBox];
        
        // Add create account button
        _createAccountButton = [[StateText alloc] initWithString:@"create account" fontName:@"KBPlanetEarth" fontSize:48
                                                        position:ccp(_size.width/2+55, _size.height/2-174)];
        [self addChild:_createAccountButton];
        
        
        // Add Update Picture Button
        _updatePictureButton = [[StateText alloc] initWithString:@"add picture" fontName:@"KBPlanetEarth" fontSize:48
                                                        position:ccp(_size.width/2+23, _size.height-479)];
        [self addChild:_updatePictureButton];
        _updatePictureButton.state = true;

        // Add exit only if we are creating the user account
        if (accountLevel == 0) {
            _exitButton = [CCSprite spriteWithFile:@"Cancel-Icon-White.png"];
            _exitButton.position = ccp(_size.width/2 + 375, _size.height/2 + 290);
            [self addChild:_exitButton];
        }
        
        // error message which used to display any errors that might of occured
        _errorMessage = [CCLabelTTF labelWithString:@"" fontName:@"KBPlanetEarth" fontSize:24];
        _errorMessage.position = ccp(_size.width/2, _size.height/2 + 195);
        ccColor3B c = {255, 0, 0}; // red color
        _errorMessage.color = c;
        _errorMessage.visible = false;
        [self addChild:_errorMessage];
    }
    return self;
}

// dispatcher to catch the touch events
- (void)registerWithTouchDispatcher {
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

// occurs when return is pressed on the keyboard
- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    // terminate editing
    [textField resignFirstResponder];
    return YES;
}

// occurs when the editin is ended on the text field
- (void)textFieldDidEndEditing:(UITextField*)textField {
    // if the input text is empty then disable the submit button
    if ([self validateTextBoxes])
        _createAccountButton.state = true;
    else
        _createAccountButton.state = false;
}


-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    // Original Image
    UIImage *OriginalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Write out our image to the SOP directory
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    filePath =  [docDirPath stringByAppendingPathComponent:@"SOP"];
    
    //Create the SOP Directory if it doesn't exist
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:nil];
    //Create and store our image
    filePath =  [filePath stringByAppendingPathComponent:self.nameTextBox.text];
    filePath =  [NSString stringWithFormat:@"%@%@", filePath, @".png"];
    NSLog (@"File Path = %@", filePath);
    [filePath retain];
    
    //Resize our image to a power of 2
    CGRect rect = CGRectMake(0,0,100,150);
    UIGraphicsBeginImageContext( rect.size );
    [OriginalImage drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //[self.imageFromFile release];
    
    // Get PNG data from following method
    NSData *myData =     UIImagePNGRepresentation(picture1);
    // It is better to get JPEG data because jpeg data will store the location and other related information of image.
    [myData writeToFile:filePath atomically:YES];
    
    
    
    
    // Send an alert indicating that the update was successful
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Picture added!"
                                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
}




// handles the events that happen when the release occurs at a specific location
- (void)tapReleaseAt:(CGPoint)releaseLocation {
    if (_updatePictureButton.state && CGRectContainsPoint(_updatePictureButton.boundingBox, releaseLocation)) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            //Create a way to browse the gallery
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            UIPopoverController *popoverController=[[UIPopoverController alloc] initWithContentViewController:picker];
            CGSize winsize = [[CCDirector sharedDirector] winSize];
            //Show gallery bar
            [popoverController setPopoverContentSize:CGSizeMake(winsize.width,winsize.height) animated:NO];
            [popoverController presentPopoverFromRect:CGRectMake(0,0,10,10)  inView:[[CCDirector sharedDirector] view]
                             permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            [picker release];
        }
        else {
            UIAlertView *alert;
            alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                               message:@"This device doesn't support photo libraries."
                                              delegate:self cancelButtonTitle:@"Ok"
                                     otherButtonTitles:nil];
            [alert show];
        }
    }
    // occurs when the user presses the createe account button
    if (_createAccountButton.state && CGRectContainsPoint(_createAccountButton.boundingBox, releaseLocation)) {
        
        int accountId = [[SOPDatabase database] getLastAccountId] + 1;
        if ([[SOPDatabase database] createAccount:accountId withName:self.nameTextBox.text withPassword:self.passwordTextBox.text withLevel:_accountLevel withImage:filePath]) {
            
            // remove all the text boxes. TO-DO make transition more smooth
            [self.nameTextBox removeFromSuperview];
            [self.passwordTextBox removeFromSuperview];
            [self.confirmPasswordTextBox removeFromSuperview];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Account has been created!"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [alert release];
            
            // Cleanup when the layer is removed
            [self.parent scheduleOnce:@selector(updateAccounts) delay:0];
            [self.parent removeChild:self cleanup:YES];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not create the account at this time!"
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
    }
    
    if (_exitButton && CGRectContainsPoint(_exitButton.boundingBox, releaseLocation)) {
        
        // remove all the text boxes
        [self.nameTextBox removeFromSuperview];
        [self.passwordTextBox removeFromSuperview];
        [self.confirmPasswordTextBox removeFromSuperview];
        
        [self.parent scheduleOnce:@selector(updateAccounts) delay:0];
        [self.parent removeChild:self cleanup:YES];
    }
}

// event that is called when the touch has ended
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint releaseLocation = [touch locationInView:[touch view]];
    releaseLocation = [[CCDirector sharedDirector] convertToGL:releaseLocation];
    [self tapReleaseAt:releaseLocation];
}

// event that is called when the touch begins
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

// Check if the input in the text boxes is valid
- (BOOL) validateTextBoxes {
    _errorMessage.visible = false;
    
    int validTextBoxes = 0;
    // make sure that the name input box has a value in there
    if (![self.nameTextBox.text isEqualToString:@""] && self.nameTextBox.text != nil) {
        validTextBoxes++;
    }

    // make sure that the password input box has a value in there
    if (![self.passwordTextBox.text isEqualToString:@""] && self.passwordTextBox.text != nil)
        validTextBoxes++;
    
    // make sure that the confirm password input box has a value in there
    if (![self.confirmPasswordTextBox.text isEqualToString:@""] && self.confirmPasswordTextBox.text != nil) {
        // check that both password box and confirm box are equal
        if ([self.confirmPasswordTextBox.text isEqualToString:self.passwordTextBox.text]) {
            validTextBoxes++;
            _errorMessage.visible = false;
        }
        else {
            [_errorMessage setString:@"Error passwords do not match!"];
            _errorMessage.visible = true;
        }
    }
    
    // If all 3 textboxes are valid then validation was successful
    if (validTextBoxes == 3)
        return true;
    else
        return false;
}

- (void)dealloc {
    [_createAccountButton release];
    [_updatePictureButton release];
    [super dealloc];
}

#pragma mark CreateAccountLayer delegate
@end

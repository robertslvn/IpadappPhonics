//
//  PauseLayer.h
//  Sound Out Phonics
//
//  Purpose: Pause layer that is displayed when the user pauses the game
//
//  History: History of the file can be found here: https://github.com/TeamRedundantTeam/SoundOutPhonics/commits/master/Sound%20Out%20Phonics/Game/PauseLayer.h
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
//  Created on 2013-12-1.
//  Copyright (c) 2013 Team Redundant Team. All rights reserved.
//


#import "cocos2d.h"
#import "LevelSelectLayer.h"

@interface PauseLayer : CCLayerColor {
    CGSize _size;
    CCLabelTTF *_levelSelectButton;
    CCLabelTTF *_resumeButton;
}
@end

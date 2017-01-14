//
//  Slots.h
//  Sound Out Phonics
//
//  Purpose: Helper class that handles the slots creation and keeping track of the
//           graphemes that are associated to each of the slot
//
//  History: History of the file can be found here:
//           Version 0.1 - 0.5: https://github.com/TeamRedundantTeam/SoundOutPhonics/commits/master/Sound%20Out%20Phonics/Game/Slots.h
//           Version 0.6 + : https://github.com/TeamRedundantTeam/SoundOutPhonics/commits/master/Sound%20Out%20Phonics/Game/Slot.h
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
//  Created on 2013-10-26.
//  Copyright (c) 2013 Team Redundant Team. All rights reserved.
//

#import "CCSprite.h"
#import "CCLabelTTF.h"

@interface Slot : CCSprite {
    CCLabelTTF *grapheme; // grapheme that is associated with this slot
}
- (id)initWithPosition:(CGPoint)pos;

@property (retain, nonatomic) CCLabelTTF *grapheme;

@end

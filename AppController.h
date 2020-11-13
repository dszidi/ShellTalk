#import <Foundation/NSObject.h>
#import "Command.h"

@class NSWindow;
@class NSTextField;
@class NSNotification;


@interface AppController : NSObject
{
     NSWindow *window;
     NSTextField *label;
     Command *shell;
}

- (void)applicationWillFinishLaunching:(NSNotification *) not;
- (void)applicationDidFinishLaunching:(NSNotification *) not;
@end

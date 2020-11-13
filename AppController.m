#import "AppController.h"
#import "Command.h"
#import <AppKit/AppKit.h>

@implementation AppController
- (void) applicationWillFinishLaunching: (NSNotification *) not
{
  /* Create Menu */
  NSMenu *menu;
  NSMenu *info;

  menu = [NSMenu new];
  [menu addItemWithTitle: @"Info"
                  action: NULL
           keyEquivalent: @""];
  [menu addItemWithTitle: @"Hide"
                  action: @selector(hide:)
           keyEquivalent: @"h"];
  [menu addItemWithTitle: @"Quit"
                  action: @selector(terminate:)
           keyEquivalent: @"q"];

  info = [NSMenu new];
  [info addItemWithTitle: @"Info Panel..."
                  action: @selector(orderFrontStandardInfoPanel:)
           keyEquivalent: @""];
  [info addItemWithTitle: @"Preferences"
                  action: NULL 
           keyEquivalent: @""];
  [info addItemWithTitle: @"Help"
                  action: @selector (orderFrontHelpPanel:)
           keyEquivalent: @"?"];

  [menu setSubmenu: info 
           forItem: [menu itemWithTitle:@"Info"]];
  RELEASE(info);

  [NSApp setMainMenu:menu];
  RELEASE(menu);

  /* Create Window */
  window = [[NSWindow alloc] initWithContentRect: NSMakeRect(300, 300, 600, 400)
                                       styleMask: (NSTitledWindowMask |
                                           NSClosableWindowMask |
                                           NSMiniaturizableWindowMask)
                                       backing: NSBackingStoreBuffered
                                         defer: YES];
  [window setTitle: @"ShellTalk"];

  /* Create Label */
  label = [[NSTextField alloc] initWithFrame: NSMakeRect(30, 270, 240, 74)]; 
  [label setSelectable: NO];
  [label setBezeled: NO];
  [label setDrawsBackground: NO];
  [label setStringValue: @"This example application demonstrates how to get system data from the Unix interactive shell on BSD systems"];

  [[window contentView] addSubview: label];
  RELEASE(label);

  /* Run System Commands */
  Command *shell = [[Command alloc] init];
  [shell exec];
  RELEASE(shell);
}


- (void) applicationDidFinishLaunching: (NSNotification *) not
{
  [window makeKeyAndOrderFront: self];
}

- (void) dealloc
{
  RELEASE(window);
  RELEASE(shell);
  [super dealloc];
}

@end







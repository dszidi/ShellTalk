#import "Command.h"
#import <Foundation/Foundation.h>

@implementation Command

- (void) exec
{
  NSLog(@"Executing Command...");

  /* Execute Shell Command */
  
  //NSString *file; 
  NSArray *args;
  NSTask *task;
  //NSFileHandle *fileHandle; // <-- This is a socket. You can also use NSURL w/NSURLHandle

  NSArray *zfsArgs = [NSArray arrayWithObjects: [NSString stringWithFormat: @"list"], nil];
  NSArray *pingArgs = [NSArray arrayWithObjects: @"-c 4", @"google.com", nil];
  NSArray *catArgs = [NSArray arrayWithObjects: @"/etc/rc.conf", nil];
  NSArray *exampleArgs = [NSArray arrayWithObjects: @"/home/damianos", @"-name", @"-print", nil];
  args = pingArgs;

  //NSPipe *pipe = [[NSPipe alloc] init];
  ASSIGN(pipe, [NSPipe pipe]);

  task = [NSTask new]; 
  [task setLaunchPath:@"/sbin/ping"];
  //[task setLaunchPath:@"/sbin/zfs"];
  [task setArguments: args];
  [task setStandardOutput: pipe];
  
  fileHandle = [pipe fileHandleForReading];
  
  NSLog(@"PING");
  // Observables/Event Listeners
  [[NSNotificationCenter defaultCenter] addObserver: self // ObserverClass
                                           selector: @selector(taskEnded:) // Callback method
                                               name: NSTaskDidTerminateNotification // EventName
                                             object: nil]; // Sender
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector: @selector(readData:) // Callback method
                                               name: NSFileHandleReadCompletionNotification
                                             object: fileHandle];

  NSLog(@"PONG");
  [fileHandle readInBackgroundAndNotify];
  [task launch];
}

- (void) readData: (NSNotification *) not
{
  NSLog(@"ReadData Method...");
  
  NSData *data = [[not userInfo] objectForKey: NSFileHandleNotificationDataItem];
  NSString *result = [[NSString alloc] initWithData: data
                                            encoding: [NSString defaultCStringEncoding]];
  

  //[textView setString: string];
  NSLog(@"%@", result);
}

- (void) taskEnded: (NSNotification *) not
{
  NSLog(@"TaskEnded Method...");
  //NSLog(@"%@", not);
  [[NSNotificationCenter defaultCenter] removeObserver: self];
  [fileHandle closeFile];

}

- (void) dealloc
{
  [super dealloc];
}

@end







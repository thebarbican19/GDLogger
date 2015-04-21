# NSLogger
NSLogger is a lightweight class for iOS versions 3.0 and above. It allows developers to easily log different 'events' over time which are locally stored as a .txt file.

<h3>Setup</h3>
To use NSLogger add both of the following code samples to each view controller you wish to use.<p>
In your .h file add <code>#import "NSLogger.h"</code>
<br/>
In your .m file add <code>NSLogger *logger = [[NSLogger alloc] init];</code>

<h3>Debugging</h3>
to enable console debugging simply add this ¬ <br/>
<code>logger.degbugger = true;</code><p>

<h3>"Events"</h3>
Events are what are created every time you create a new item in NSLogger. They contain 2 objects, a "title" and "properties"<p>
"title" type: <strong>NSString</strong><br/>
"properties" type: <strong>NSDictionary</strong>

Creating an event can be done by calling the following method ¬ 

<code>[logger log:@"Event Title" properties:[NSDictionary dictionaryWithObjectsAndKeys:@"value", @"key", [NSNumber numberWithBool:true] ,@"installed"];</code>
<p><strong>NOTE</strong> title cannot be empty or NULL

<h3>Print</h3>
To print out the entire log file in the debugger console use  <br/>
<code>NSLog(@"Logger Print: %@" ,[logger logPrint]);</code><p>

<h3>BONUS: Send as Attachement</h3>
There will be many ways you will choose to utilize the saved data. Sending it as an attachment is the most common so we have added an example for you lazy folk out there

<pre>
MFMailComposeViewController *emailController = [[MFMailComposeViewController alloc] init];
[emailController setMailComposeDelegate:self];
[emailController setToRecipients:[[NSArray alloc] initWithObjects:@"email@gmail.com", nil]];
[emailController setSubject:@"Log File"];
[emailController setMessageBody:@"" isHTML:false];
[emailController addAttachmentData:[logger logData] mimeType:@"text/plain" fileName:@"logger.txt"];
[emailController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
[self presentViewController:emailController animated:true completion:nil];</pre>
        
<p><strong>NOTE</strong> the fileName for addAttachmentData can be anything




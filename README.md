# GDLogger
<strong>GDLogger</strong> is a lightweight class logging class for iOS versions 3.0 and above, build for <a href="http://gradoapp.com">Grado</a>. It allows for quick, strightforward creation, and appending of multiple, formatted log files.<p>

<h3>Setup</h3>
We now support CocoaPod's <code>pod 'GDLogger'</code><p>

Add <code>#import "GDLogger.h"</code>
<br/>
In your .m file add <code>GDLogger *logger = [[GDLogger alloc] init];</code>

<h3>Debugging</h3>
to enable console debugging simply set <code>logger.degbugger = true;</code><p>
<p>
	
<h3>Mutiple Logs</h3>
We recently updated <strong>GDLogger</strong> to support multiple log files. By default there will be only one log file saved locally <strong>"[YourApp]-logger.txt"</strong>. This is created when you log your first event. To create a new log file simply set the filename. <p>
<p>
<code>logger.filename = @"my-new-log";</code>
<p>
<strong>NOTE</strong> To revert back to the default log file set <code>logger.filename = nil;</code></br>
<strong>NOTE</strong> Do not include the file type when setting <code>logger.filename</code></br>

<p>

<h3>"Events"</h3>
Events are what are created every time you create a new item in GDLogger. They contain 2 objects, a "title" and "properties"<p>
<strong>title</strong> (NSString<br/>
<strong>properties</strong> (NSDictionary)<p>
<code>[logger log:@"Event Title" properties:@{@"key":@"value", @"installed":[NSNumber numberWithBool:true]}];</code>

<h3>Print</h3>
To print out the entire log file as a <strong>NSString</strong> use <code>logger.logPrint</code><p>
<p>
Alternatively, you can get the file content as <strong>NSData</strong> <code>logger.logData</code><p>
<strong>NOTE</strong> this will print out the default log file unless <code>logger.filename</code> has been set
<p>	
	
<h3>Files</h3>
There is two ways of getting access to the saved files.
<br/>
You can get the active most recent file by calling <code>logger.logPrint</code>
<p>
	
Or, you can get an array of <strong>all</strong> files by calling

<code>[self.logger logFiles:true]</code> (This will return the all the files with their full directories as an NSURL)<br/>
<code>[self.logger logFiles:false]</code> (This will return the all the files with just their respective file names as an NSString)
<p>
	
<h3>Remove/Destory</h3>
Calling <code>[self logDestory];</code> will destory the active log file. 
<p>
	
<h3>Share</h3>
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




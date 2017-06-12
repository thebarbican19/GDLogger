# NSLogger
<strong>NSLogger</strong> is a lightweight class for iOS versions 3.0 and above. It allows for quick, strightforward creation, and appending of formatted, multiple localized log files in your app. 

<h3>Setup</h3>
We now support CocoaPod's <code>pod 'NSLogger'</code><p>

Add<code>#import "NSLogger.h"</code>
<br/>
In your .m file add <code>NSLogger *logger = [[NSLogger alloc] init];</code>

<h3>Debugging</h3>
to enable console debugging simply add this ¬ <br/>
<code>logger.degbugger = true;</code><p>
<p>
	
<h3>Mutiple Logs</h3>
We recently updated NSLogger to support multiple log files. By default there will be only one log file saved locally. This is created when you log your first event. To create a new log file simply set the filename. Anything from now on will be saved into this new log. <br/>
<code>logger.filename = @"my-new-log";</code></br>
To revert back to the default log file set 
<code>logger.filename = nil;</code></br>
<p>

<h3>"Events"</h3>
Events are what are created every time you create a new item in NSLogger. They contain 2 objects, a "title" and "properties"<p>
"title" type: <strong>NSString</strong><br/>
"properties" type: <strong>NSDictionary</strong>

Creating an event can be done by calling the following method ¬ 

<code>[logger log:@"Event Title" properties:@{@"key":@"value", @"installed":[NSNumber numberWithBool:true]}];</code>

<h3>Print Out</h3>
To print out the entire log file as a string use<br/>
<code>logger.logPrint</code><p>
<p>
Alternatively you can get the file content as NSData <br/>
<code>logger.logData</code><p>
<strong>NOTE</strong> this will print out the default log file unless <code>logger.filename</code> has been set
<p>	
	
<h3>Files</h3>
There is two ways of getting access to the saved files.
<br/>
You can get the active most recent file by calling
<code>logger.logPrint</code><p>
Or, you can get an array of <strong>all</strong> files by calling<br/> 
<code>[self.logger logFiles:true]</code>(This will return the all the files with their full directories as an NSURL)<p>
<code>[self.logger logFiles:false]</code>(This will return the all the files with just their respective file names as an NSString)
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




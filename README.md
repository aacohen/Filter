# Filter
Filter is an app that processes incoming calls and filters unwanted text messages. 

# Phone Call Filtering

**In order to use the app must enable it on your device: iPhone settings -> Phone -> Call Blocking & Identification -> Toggle “Teltech Filter” to enable.

> For the purpose of this project: 

	  -The phone number 253-950-1212 is considered scam and automatically blocked by the system. 

	  -The phone number 425-950-1212 has been deemed suspicious/possible spam. The user will be notified when the call 	      comes in “Teltech Filter ID: Possible Spam”

> There is a use configurable list of blocked phone number that is persisted using Core Data however these numbers are not yet blocked by the system. I am still looking for a way to load the user data from CoreData after the app ext has been initialized. Once the app ext has been initialized there doesn’t seem to be away to reload data. 


# Message Filtering 

**To enable the filter on your device: In your iPhone settings -> Messages -> Unknown & Spam,  Toggle Teltech Filter to enable.

-Messages filter is for sms and mms messages only (not iMessages) and is supported in iOS11+. 

-Though there is a user configurable key word filter for the texts. It is not yet filtered by the system. It works if words are hard coded into the code. However, getting an error loading the CoreData model in the extension.

**The app currently only filters texts with the word "free" in it. These messages are put into the "Unknown & Junk" folder in Messages.

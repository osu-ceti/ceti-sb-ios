# ceti-sb-ios
The IOS version of the Delphos City School Business app
To get this app installed in your laptop you will need a Machintosh Operating System.

1. Install Xcode
2. Install cocoapods
3. Open terminal and cd to the directory where you cloned this git repo and type
>pod install
This command will install all the dependencies mentioned in the "Podfile"
4. Once all dependencies are installed you will notice a file with "xcworkspace". In my case it is "Delphos.xcworkspace". 
5. Open that file in Xcode and you will notice two folders. One named "Delphos" containing the code written by us and the other named "pods" containing all dowloaded third party dependencies.
6. SchoolBusiness.swift file has the links to point to production and test sites. Use "ceti-test-env.elasticbeanstalk.com" to point to test site for a test run of the app.

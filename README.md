# NJ-Transit-Widget
After opening the NJ Transit App, it would take you 7 clicks to find out the timing of the next train. Our goal is to allow users to quickly see when their train is arriving with just a quick glance.


Using the location of the user, we find the nearest NJ Transit train station and show the next train timings for the Eastbound and Westbound trains. This will be displayed as a widget on the users phone, allowing them to quickly glance at the widget and see the next train times instead of opening the app and clicking 7 times to find out the same information.


We built our project on the iOS Xcode IDE, using Swift and SwiftUI. We utilized NJ Transit API to find out the timings of the next trains, and NJ Transit Rail Data Sets for the exact locations of the train stations. Libraries we used in Swift include: CoreLocation to find out the users location, Foundation, and WidgetKit so we could format our widget and use it on a phone.
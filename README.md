# Overview
This is a simple app that uses the Omdb movie API to pull down search results based on the search text.

It was made using Xcode 14, so likely won't work on Xcode versions < 13.

## Setup
I'm unsure if Pods are fully bundled with the project in its current state on Github. If not, follow the instructions below:

Ensure you have Cocoapods installed on your machine. If not, follow the instructions here.

Once you can run the pod command, run `pod install` to install the Pods for Alamofire and Kingfisher.

The Omdb API key is included already. I know this is poor practice for production, but this is a small test app that will only be shared with Jacob (and potentially other Dfinitiv employees).

The final step would be cloning this Swift Package which contains the Omdb API calls: https://github.com/gbusto/Movie-App-Omdb-Package. Add it to the project and you should be good to go.

## Progress and current state
The previous app was built using Storyboard while this one uses SwiftUI. SwiftUI, after getting a basic understanding of it, was *much* simpler to use compared to Storyboards, CollectionViews, CollectionViewCells, etc. The UI in this version looks much better than in the original app that used Storyboards.

I was also able to get pagination working to load more movies, but the method has room for improvement.

One of the other things I did differently this time was to separate out the Alamofire Omdb request code into its own Package to test Swift Packages. This seems like a good option to allow for separation of logic to enable simpler, modular updates.

## Demo
https://user-images.githubusercontent.com/4229232/207699661-4f429e6f-22e0-4be7-b5be-804ddf2900b2.mov

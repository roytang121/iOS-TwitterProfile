![iOS-TwitterProfile](https://github.com/roytang121/iOS-TwitterProfile/blob/master/img/twitterProfile.png?raw=true)

A complete guide to implement the Twitter iOS App Profile UI in Swift.  This project mimics the elegant Twitter Profile User Interface design on iOS with a detailed guide of how I implemented each feature.
> This may not (and most probably not) be the same way as the Twitter app actually implements. I am just using my own way trying to mimic their user interface.



## Preview
![Video Demo](https://github.com/roytang121/iOS-TwitterProfile/blob/master/img/screencap_1.gif?raw=true)

## Features
- Sticky Profile Header with interactive blurring animation
- Interactive layout changes when scrolling
- **Multiple** UITableView (UICollectionView, UIScrollView, etc...) embedding in **ONE** UIScrollView, paging controlled by UISegmentedControl
  - Dynamically changing `scrollview.contentsize` with respect to child tableview contents 
  - UIScrollView Indicator offset
  - Touch handling with UIScrollView + UIButtons

## Why I made this guide ? 
> Understand (and implement) Twitter app's elegant user interface is fun. 

## Any third-party libraries used ?
> I tried to avoid using third-party libraries for this guide to keep it clean and easy to understand. Only [SnapKit](https://github.com/SnapKit/SnapKit) is being used because I believe it should replace the built-in AutoLayout system in every project.

## Requirements
- Swift 3
- Xcode 8
- Cocoapods 1.0.1

# Project Title

PWC Candidates Assignment.

## Description

A website built using flutter and Google's Map and Place APIs that allows users to search for any location on a map, it also provides suggestions on user.
## Getting Started

### Dependencies

* To run this website, you need the following:
    - Flutter SDK.
    - Google Maps API Key.

### Building

Clone the repo
```
git clone git@github.com:OmarAlzoubi/pwcmapassignment.git
```
Add your API key to lib/assets/apikey.dart

Add the following line to web/index.html file
```
<script src="https://maps.googleapis.com/maps/api/js?key=YOURAPIKEY"></script>
```


### Executing program

cd <pwcmapassignment>
Run this command
```
flutter run -d chrome 
```

## Authors

[Omar Alzoubi](https://www.linkedin.com/in/omar-alzoubi-823507217/)



## What to do next?

* Add marker to the currently selected place.
* Add the functionality to measure distance between two locations.
* Allow the use to switch the map type (Satalite, Normal..).

# Animated Leaderboard

An interactive animated leaderboard widget for Flutter apps. This package allows you to easily integrate a dynamic leaderboard UI with customizable user rankings, filters, and tap actions, providing a smooth and engaging experience for users.

## Features

- **Interactive**: Tap on user cards to trigger actions.
- **Animated**: Smooth animations for transitions and scrolling.
- **Customizable**: Easily configurable to suit your app's design.
- **Responsive**: Adapts to different screen sizes and devices.

## Screenshots

Here are some screenshots of the `AnimatedLeaderboard` in action:

![Leaderboard Screenshot](..%2FSimulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202024-12-01%20at%2023.12.32.png)
![Leaderboard Screenshot](..%2FSimulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202024-12-01%20at%2023.13.01.png)
![Leaderboard Screenshot](..%2FSimulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202024-12-01%20at%2023.12.41.png)
![Leaderboard Screenshot](..%2FSimulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202024-12-01%20at%2023.16.01.png)

## Installation

To use this package in your Flutter project, add it to your `pubspec.yaml` file:

```yaml
dependencies:
  animated_leaderboard: ^0.1.3
```

Then, run `flutter pub get` to install the package.

## Usage

To use the `AnimatedLeaderboard` widget, add the following code in your Flutter widget:

```dart
import 'package:animated_leaderboard/animated_leaderboard.dart';

AnimatedLeaderboard( 
    scrollController: _scrollController,
    topContainer: _topContainer,
    filterLabel1: 'Weekly',
    filterLabel2: 'All-time',
    users: _users,
    myId: _myId,
    isFirstFilterSelected: _isFirstFilterSelected,
    filterTapCallBack: _onFilterTap,
    radius: 20,
)
```

**Parameters:**

- `scrollController`: A `ScrollController` for controlling scrolling behavior.
- `topContainer`: A `double` indicating the position of the top container for animations.
- `filterLabel1 & filterLabel2`: Strings for the labels of the filters.
- `users`: A list of users to display in the leaderboard.
- `myId`: The ID of the current user.
- `isFirstFilterSelected`: A boolean indicating the selected filter.
- `filterTapCallBack`: A callback function for handling filter changes.
- `radius`: An optional radius for the rounded corners of the UI (default is 20).

## Example

Here is a complete example of how to use the leaderboard:

```dart
import 'package:animated_leaderboard/animated_leaderboard.dart';
import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  final ScrollController _scrollController = ScrollController();
  double _topContainer = 0;

  final List<User> _users = List.generate(
    10,
    (index) => User(
      index,
      'user$index',
      '',
      'https://shorturl.at/Jl6mL',
      (10 - index) * 10,
      (10 - index) * 50,
    ),
  );

  final int _myId = 2;
  bool _isWeeklyFiltered = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final double value = _scrollController.offset / 119;
    setState(() {
      _topContainer = value;
    });
  }

  void _filter(bool isFirstFilterSelected) {
    setState(() {
      _isWeeklyFiltered = isFirstFilterSelected;
    });
    // TODO: Sort the users based on the selected filter
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
        scrolledUnderElevation: 0,
      ),
      body: AnimatedLeaderboard(
        scrollController: _scrollController,
        topContainer: _topContainer,
        filterLabel1: 'Weekly',
        filterLabel2: 'All-time',
        users: _users,
        myId: _myId,
        isFirstFilterSelected: _isWeeklyFiltered,
        onFilterTap: _filter,
      ),
    );
  }
}

class User {
  final int id;
  final String photo;
  final String firstName;
  final String lastName;
  final int weeklyPoints;
  final int allTimePoints;

  User(this.id, this.firstName, this.lastName, this.photo, this.weeklyPoints, this.allTimePoints);

  int get firstFilterPoints => weeklyPoints;
  int get secondFilterPoints => allTimePoints;
}

class CustomDuration{
    final int _milliSeconds;

    // CustomDuration(this.milliSeconds);
    CustomDuration._fromMilliseconds(this._milliSeconds) {
        if (_milliSeconds < 0) { // Validation: duration must be >= 0
      throw ArgumentError('Duration cannot be negative!');
    }
  }
    // 1 hour = 60 minutes = 3,600 seconds = 3,600,000 milliseconds
    CustomDuration.fromHours(int hours) 
      : _milliSeconds = hours * 60 * 60 * 1000 {
    if (_milliSeconds < 0) {
      throw ArgumentError('Duration cannot be negative!');
    }
  }
    // 1 minute = 60 seconds = 60,000 milliseconds
  CustomDuration.fromMinutes(int minutes) 
      : _milliSeconds = minutes * 60 * 1000 {
    if (_milliSeconds < 0) {
      throw ArgumentError('Duration cannot be negative!');
    }
  }
    // 1 second = 1000 milliseconds
    CustomDuration.fromSeconds(int seconds) 
      : _milliSeconds = seconds * 1000 {
    if (_milliSeconds < 0) {
      throw ArgumentError('Duration cannot be negative!');
    }
  }

  int get inMilliSeconds => _milliSeconds;
    // Compare
  bool operator >(CustomDuration other) {
    return _milliSeconds > other._milliSeconds;
  }
    // Add two durations 
  CustomDuration operator +(CustomDuration other) {
    int sum = _milliSeconds + other._milliSeconds;
    return CustomDuration._fromMilliseconds(sum);
  }
  // minus two durations
  CustomDuration operator -(CustomDuration other) {
    int difference = _milliSeconds - other._milliSeconds;
    if (difference < 0) { //at this if result negative return 0 instead
      return CustomDuration._fromMilliseconds(0);
    }
    return CustomDuration._fromMilliseconds(difference);
  }
}
void main(){
    var d1 = CustomDuration.fromHours(2);
    var d2 = CustomDuration.fromMinutes(30);
    var d3 = CustomDuration.fromSeconds(45);

    print('in (2h): ${d1._milliSeconds} ms');
    print('in (30m): ${d2._milliSeconds} ms');
    print('in (45s): ${d3._milliSeconds} ms');

    // test >
    print('is d1>d2? ${d1>d2}');
    print('is d2>d1? ${d2>d1}');

    //test +
    var sum = d1+d2;
    print('d1+d2 = ${sum.inMilliSeconds} ms');
    print('That\'s ${sum.inMilliSeconds / 1000 / 60} minutes\n');

    // test -
    var diff1 = d1 - d2;
    print('d1 - d2 = ${diff1.inMilliSeconds} ms');

    var diff2 = d2 - d1; // if negative, so returns 0
    print('d2 - d1 = ${diff2.inMilliSeconds} ms (can\'t be negative!)\n');
}


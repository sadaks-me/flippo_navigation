# flippo_navigation

A Flutter package to make an animated navigation bar.

## Screenshots

https://github.com/sad1996/flippo/blob/master/Screenshot/Screenrecord.mp4
https://github.com/sad1996/flippo/blob/master/Screenshot/Screen1.png
https://github.com/sad1996/flippo/blob/master/Screenshot/Screen2.png

### Snippet

@override
  Widget build(BuildContext context) {
   return new Flippo(
      controller: controller,
      mask: new Scaffold(
        backgroundColor: Colors.white,
      ),
      body: new Scaffold(
        backgroundColor: Colors.white,
      ),
      drawer: new Scaffold(
        backgroundColor: Colors.black,
      ),
    );
  }
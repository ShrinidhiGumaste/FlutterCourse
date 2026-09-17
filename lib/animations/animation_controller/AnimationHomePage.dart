import 'package:flutter/material.dart';

class AnimationHomePage extends StatefulWidget { // This creates the AnimationHomePage screen.
  const AnimationHomePage({super.key});

  @override
  // Connects the AnimationBuilderHomePage widget to its State class.
  State<AnimationHomePage> createState() => _AnimationHomePageState();
}

class _AnimationHomePageState extends State<AnimationHomePage>
    with SingleTickerProviderStateMixin { // It helps provide a ticker for the animation controller.
  // A ticker basically gives the animation regular updates.
  late AnimationController _animationController; // This creates a variable for controlling the animation.

  @override
  void initState() { // Runs once first when the screen is created.
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController( // Creating the Controller.
      vsync: this, // Connects the controller to the ticker.
      duration: const Duration(milliseconds: 800), // The animation takes 0.8 seconds.
      lowerBound: 0.0, // Minimum animation value.
      upperBound: 1.0, // Maximum animation value.
    );

    _animationController.addListener(() {
      // addListener() => Whenever the animation value changes, It rebuilds the UI.
      setState(() {});
    });
  }

  // Play animation
  void openPanel() {
    _animationController.forward(); // moves the animation: Panel Moves up/open.
  }

  void closePanel() {
    _animationController.reverse(); // moves the animation: Panel moves down/close.
  }

  void stopAnimation() {
    _animationController.stop(); // Stops the animation at its Current State.
  }

  void resetAnimation() {
    _animationController.reset(); // Immediately returns the animation to its starting value.
  }

  void setAnimValue() {
    _animationController.value = 0.5; // Directly sets animation to 50%. So the panel goes to the middle position.
  }

  void flingUp() {
    // fling() gives the animation a quick movement.
    _animationController.fling(velocity: 2.0); // Positive Value means FlingUP. Upward Movement.
  }

  void flingDown() {
    _animationController.fling(velocity: -2.0); // Negative Value means FlingDown. Downward Movement.
  }

  @override
  void dispose() {
    // dispose() => When the screen is removed: Destroy the animation controller and free its resources.
    // Create controller → use it → dispose it.
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context).size.height * 0.55 => Calculating the Panel Height.
    // This gets the screen height and takes 55% of it.
    // So the Calculated panel height is approximately 440 pixels.
    final double panelHeight = MediaQuery.of(context).size.height * 0.55;

    // 1 - _animationController.value => This calculates where the panel should be placed.
    final double panelOffsets = panelHeight * (1 - _animationController.value);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation Controller Demo"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Stack( // Stack allows widgets to overlap each other.
        children: [
          Center( // Puts the animation information and buttons in the center.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.animation, size: 90, color: Colors.deepPurple),
                const SizedBox(height: 20),
                const Text(
                  "AnimationController",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  // .toStringAsFixed(2) => Converts to String and display up to Two Decimal Values.
                  "value: ${_animationController.value.toStringAsFixed(2)}", // This displays the current animation value.
                  // 45.5596296962922926 "45.559"
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 250,
                  child: LinearProgressIndicator( // Shows the animation value visually as a progress bar.
                    value: _animationController.value,
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 30),
                Wrap( // Wrap arranges buttons and automatically moves them to the next line if there isn't enough space.
                  spacing: 30, // Horizontal gap between items.
                  runSpacing: 10, // Vertical gap between rows.
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: openPanel, // Press button → openPanel() → forward().
                      icon: Icon(Icons.fast_forward_rounded),
                      label: Text("Forward"),
                    ),
                    ElevatedButton.icon(
                      onPressed: closePanel, // Press button → openPanel() → close().
                      icon: Icon(Icons.fast_rewind),
                      label: Text("Reverse"),
                    ),
                    ElevatedButton.icon(
                      onPressed: stopAnimation, // Press button → openPanel() → stopAnimation().
                      icon: Icon(Icons.stop),
                      label: Text("Stop"),
                    ),
                    ElevatedButton.icon(
                      onPressed: resetAnimation, // Press button → openPanel() → resetAnimation().
                      icon: Icon(Icons.refresh),
                      label: Text("Reset"),
                    ),
                    ElevatedButton.icon(
                      onPressed: setAnimValue, // Press button → openPanel() → setAnimation Value().
                      icon: Icon(Icons.linear_scale),
                      label: Text("Set 50%"),
                    ),
                    ElevatedButton.icon(
                      onPressed: flingUp, // Press button → openPanel() → FlingUpward().
                      icon: Icon(Icons.keyboard_arrow_up),
                      label: Text("Fling Up"),
                    ),
                    ElevatedButton.icon(
                      onPressed: flingDown, // Press button → openPanel() → FlingDownward().
                      icon: Icon(Icons.keyboard_arrow_down),
                      label: Text("Fling Down"),
                    ),
                  ],
                ),
              ],
            ),
          ),

          if (_animationController.value > 0) // Only show the dark background when the panel starts opening.
            Positioned.fill( // Positioned.fill makes it cover the available Stack area.
              child: GestureDetector( // GestureDetector detects taps.
                onTap: closePanel, // Tap the dark area → panel closes.
                child: Container(
                  color: Colors.black.withValues( // This makes the background progressively darker as the panel opens.
                    alpha: 0.35 * _animationController.value,
                  ),
                ),
              ),
            ),
          Positioned( // This positions your control panel.
            left: 0, // Panel stretches across the screen.
            right: 0,
            bottom: panelOffsets, // This is what moves the panel up and down based on animation value.
            height: panelHeight, // Panel gets 55% of screen height.
            child: Material( // Creates the white panel with: Shadow, Rounded top corners, White background.
              elevation: 20,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Control Panel",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const ListTile(
                      leading: Icon(
                        Icons.notifications,
                        color: Colors.deepOrange,
                      ),
                      title: Text("Notifications"),
                      subtitle: Text("You have 3 notifications"),
                    ),
                    const ListTile(
                      leading: Icon(Icons.settings, color: Colors.deepOrange),
                      title: Text("Settings"),
                      subtitle: Text("Manage your application settings"),
                    ),
                    const Spacer(), // It takes all available extra space and pushes the Close Panel button to the bottom.
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: closePanel,
                        child: const Text("Close Panel"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AnimationBuilderHomePage extends StatefulWidget { // This creates the AnimationBuilderHomePage screen.
  const AnimationBuilderHomePage({super.key});

  @override
  State<AnimationBuilderHomePage> createState() =>
      _AnimationBuilderHomePageState(); // Connects the AnimationBuilderHomePage widget to its State class.
}

class _AnimationBuilderHomePageState extends State<AnimationBuilderHomePage>
    with SingleTickerProviderStateMixin { // It helps provide a ticker for the animation controller.
  // A ticker basically gives the animation regular updates.
  late AnimationController _controller; // This creates a variable for controlling the animation.

  late Animation<double> _scaleAnimation; // Makes card grow/shrink.
  late Animation<double> _rotationAnimation; // Rotates card.
  late Animation<double> _fadeAnimation; // Controls transparency.
  late Animation<double> _slideAnimation; // Moves card up/down.

  @override
  @override
  void initState() { // initState() runs once when the screen is created.

    super.initState();

    _controller = AnimationController(
      vsync: this, // Connects the controller to the ticker.
      duration: const Duration(milliseconds: 1500), // Animation Takes 1.5seconds to Start.
    );

    _scaleAnimation = Tween<double>( // Tween means "Give me values between start and end."
      begin: 0.5,
      end: 1.0,
       // Curves.elasticOut makes the animation have an elastic/bouncy effect.
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _rotationAnimation = Tween<double>( // Controls the rotation.
      begin: -0.1,
      end: 0.0,// So the card starts slightly rotated and becomes straight.
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>( // Controls opacity/transparency.
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<double>( // Moves the card vertically.
      begin: 50,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward(); // Tells controller that "Start the animation from beginning to end."
  }

  @override
  void dispose() {
    // dispose() => When the screen is removed: Destroy the animation controller and free its resources.
    // Create controller → use it → dispose it.
    _controller.dispose();
    super.dispose();
  }

  void replayAnimation() { // This is called when user press Replay Animation.
    _controller.reset(); // Goes back to the beginning.
    _controller.forward(); // Starts Again.
  }

  @override
  Widget build(BuildContext context) { // Defines what appears on the screen.
    return Scaffold(
      appBar: AppBar(title: const Text("AnimationBuilder EX.")),
      body: Center(
        child: Column(
          children: [
            AnimatedBuilder( // It listens to the animation controller.
              // Whenever the Animation Changes (Controller changes, AnimatesBuilder rebuilds, Card changes Position/size/rotation.)
              animation: _controller,
              builder: (context, child) {
                return Opacity( // Makes the card visible according to the given Value.
                  opacity: 0.2,  // Makes the card 20% visible.
                  child: Transform.translate(
                    // (0) means do not move left/right & _slideAnimation.value means move Up/Down.
                    offset: Offset(0, _slideAnimation.value),
                    child: Transform.rotate( // Rotates the card according to _rotationAnimation.
                      angle: _rotationAnimation.value,
                      child: Transform.scale( // Changes the size according to _scaleAnimation.
                        scale: _scaleAnimation.value,
                        child: child, // The actual widget being animated is passed here.
                      ),
                    ),
                  ),
                );
              },
              child: ProfileCard(),
            ),
            const SizedBox(height: 20),

            FilledButton.icon(
              onPressed: replayAnimation,
              label: Text("Replay Animation"),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget { // This creates the actual profile card.
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( // Creates a Box.
      width: 320,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration( // Gives the card a gradient background.
        gradient: const LinearGradient(colors: [Colors.grey, Colors.black87]),
      ),
      child: Column(
        children: [
          const CircleAvatar( // Creates the round profile icon.
            radius: 55,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.deepPurple),
          ),
          const SizedBox(height: 20),
          const Text("Shinu"),
          const Text("IT Engineer"),
        ],
      ),
    );
  }
}

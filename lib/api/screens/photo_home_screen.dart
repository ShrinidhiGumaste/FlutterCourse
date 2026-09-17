import 'package:flutter/material.dart';
import 'package:fluttercourse/api/models/photo.dart';
import '../services/api_service.dart';
import '../widgets/photo_card.dart';

class PhotoHomeScreen extends StatefulWidget {
  const PhotoHomeScreen({super.key});

  @override
  State<PhotoHomeScreen> createState() => _PhotoHomeScreenState(); // Connects the main widget to its State class.
}

class _PhotoHomeScreenState extends State<PhotoHomeScreen> {
  final ApiService apiService = ApiService(); // Creates an object of your ApiService.

  // Future => Data comes Later.
  // List<Photo> => List of Multiple Photo Objects.
  late Future<List<Photo>> photosFuture; // This means In the future, I will receive a list of Photo objects.

  @override
  // This runs Firstly when the screen is created.
  void initState() {
    super.initState();
    photosFuture = apiService.getPhotos();
  }

  Future<void> refreshPhotos() async {
    setState(() {
      // setState() tells Flutter That Something changed, Build the UI again.
      photosFuture = apiService.getPhotos();
    });

    await photosFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text(
          'My Photo Gallery 📸',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white, // Used to change the Color of Text/Icons.
        actions: [
          IconButton(onPressed: refreshPhotos, icon: const Icon(Icons.refresh)),
        ],
      ),

      body: FutureBuilder<List<Photo>>(
        // FutureBuilder has mainly 3 Situations => LOADING , ERROR, DATA.
        // It means "Watch this Future and show the correct UI depending on its state."
        // LOADING....
        future: photosFuture,
        builder: (context, snapshot) { // snapshot contains the current status/result of your API request.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) { // Means Did the API request fail?
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 15),
                  const Text(
                    'Something went wrong!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: refreshPhotos,
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // !snapshot.hasData => No Data received.
            // snapshot.data!.isEmpty => Data received but the List is Empty.
            return const Center(
              child: Text(
                'No Photos Found 📭',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }

          final photos = snapshot.data!; // This takes the data from snapshot.

          return RefreshIndicator( // Allows to pull down to refresh.
            onRefresh: refreshPhotos,
            child: Column(
              children: [
                Container( // HEADER CONTAINER => creates the white header box
                  margin: const EdgeInsets.all(12), // space outside the container.
                  padding: const EdgeInsets.all(15), // space inside the container.
                  decoration: BoxDecoration( // Controls the appearance of Color, Rounded Corners, Shadow.
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 5),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blue.shade100,
                        child: const Icon(
                          Icons.photo_library,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Photo Collection',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Explore your photos',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        '${photos.length}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded( // It Means Give the remaining available screen space to the GridView.
                  // Without this there may be Overflow problems.
                  child: GridView.builder( // This displays photos in a grid.
                    padding: const EdgeInsets.all(8),
                    itemCount: photos.length, // Shows the number of photos.
                    gridDelegate: // It defines the grid layout "How should my GridView arrange the items".
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          // SliverGridDelegateWithFixedCrossAxisCount => This is used with GridView.builder to tell Flutter how the grid should be arranged.
                          crossAxisCount: 2, // Means 2 columns.
                          crossAxisSpacing: 8, // Used to give horizontal space between columns.
                          mainAxisSpacing: 8, //  Used to give vertical space between rows.
                          childAspectRatio: 0.55, // This controls the shape/size of each grid item.
                        ),
                    itemBuilder: (context, index) {
                      final photo = photos[index]; // This gets one photo from the list.

                      // PhotoCard Displays Image, Title, Album, Favorite, View Photo.
                      return PhotoCard(photo: photo); // This sends the selected photo to PhotoCard.
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

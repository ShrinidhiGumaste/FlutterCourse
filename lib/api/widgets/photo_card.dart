import 'package:flutter/material.dart';
import 'package:fluttercourse/api/models/photo.dart';

class PhotoCard extends StatefulWidget { // We use StatefulWidget because the favorite icon changes.
  final Photo photo; // This card receives one Photo object.

  const PhotoCard({super.key, required this.photo});

  @override
  // This connects the screen to its State class.
  State<PhotoCard> createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  bool isFavorite = false; // This remembers whether the photo is favorite or not.

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Used for Shadow.
      margin: const EdgeInsets.all(5), // Used to give Space outside Card.
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)), // Used for Rounded Corners.
      // Clip.antiAlias => Makes the image respect the card's rounded corners. Without it Image may extend beyond the Shape.
      clipBehavior: Clip.antiAlias,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack( // Stack allows widgets to be placed on top of another widget. Our Image is in Background and thet Favourite Button and Other Thsings are in font.
            children: [
              Image.network( // Loads an image from an internet URL.
                'https://picsum.photos/id/${widget.photo.id % 1000}/600/400',
                height: 150,// Image Height
                width: double.infinity, // Uses all Available Width.
                fit: BoxFit.cover,// fill the image area properly

                // context => Used to tell Flutter where this widget is....
                // error => contains information about what went wrong.
                // stackTrace => gives technical details about where/how the error happened.
                errorBuilder: (context, error, stackTrace) { //This runs if the image fails to load.
                  return Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),

              Positioned( // It places the widget at a specific position.
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    // Because this is inside the _PhotoCardState class.
                    // The PhotoCard widget that this State belongs to.
                    // widget.photo.id => It means that Give me the ID of the photo received by PhotoCard.
                    '#${widget.photo.id}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 7,
                right: 7,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {
                      setState(() { // This Customises when button is Clicked Icon must Change.
                        isFavorite = !isFavorite; // It means that Change isFavorite to its opposite value.
                      });
                    },
                    icon: Icon(// When button is clicked, The icon itself is controlled by this Ternary operator.
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 5),
            child: Text(
              widget.photo.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis, //  When the Text is too Long it is used to prevent from Overflow.
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),

          const Spacer(),// This pushes the content below it toward the bottom.

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(
                  Icons.photo_album_outlined,
                  size: 18,
                  color: Colors.blue,
                ),
                const SizedBox(width: 6),
                Text(
                  'Album ${widget.photo.albumId}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog( // Opens a popup.
                    context: context,
                    builder: (context) {
                      return AlertDialog( // Used to Design the PopUp Box.
                        title: const Text('Photo Details'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              'https://picsum.photos/id/${widget.photo.id % 1000}/600/400',
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.photo.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('Photo ID: ${widget.photo.id}'),
                            Text('Album ID: ${widget.photo.albumId}'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.visibility_outlined, size: 18),
                label: const Text('View Photo'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

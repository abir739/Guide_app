import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guide_app/destination/place_description.dart';
//import 'package:guide_app/destination/place_description_test.dart';

import '../notification/notification.dart';
import '../planning/guide_plan.dart';
import '../users/client_list.dart';

class DestinationScreen extends StatefulWidget {
  const DestinationScreen({super.key});

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _categories = [
    {"name": "Museums", "icon": "🏛️"},
    {"name": "Mountains", "icon": "⛰️"},
    {"name": "Beaches", "icon": "🏖️"},
    {"name": "Amusement Parks", "icon": "🎢"},
    {"name": "Forests", "icon": "🌳"},
  ];

  final List<Map<String, dynamic>> _places = [
    {
      "name": "Museum of Natural History",
      "category": "Museums",
      "image":
          "https://media.tacdn.com/media/attractions-splice-spp-674x446/06/70/0f/b9.jpg",
      "price": "\$10",
      'description':
          'Mount Everest is Earth\'s highest mountain above sea level, located in the Mahalangur Himal sub-range of the Himalayas. The China–Nepal border runs across its summit point. The current official elevation of 8,848 m (29,029 ft), recognized by China and Nepal, was established by a 1955 Indian survey and subsequently confirmed by a Chinese survey in 1975.',
    },
    {
      "name": "Museum of Bardo",
      "category": "Museums",
      "image":
          "https://static.lpnt.fr/images/2015/03/18/3131691-jpg_2781378_1000x667.jpg",
      "price": "\$40",
      'description':
          'Mount Everest is Earth\'s highest mountain above sea level, located in the Mahalangur Himal sub-range of the Himalayas. The China–Nepal border runs across its summit point. The current official elevation of 8,848 m (29,029 ft), recognized by China and Nepal, was established by a 1955 Indian survey and subsequently confirmed by a Chinese survey in 1975.',
    },
    {
      "name": "Museum of Modern Art",
      "category": "Museums",
      "image":
          "https://historiadeldisseny.org/web/wp-content/uploads/FHD_Recursos_museu_MoMa.jpg",
      "price": "\$20",
      'description':
          'Mount Everest is Earth\'s highest mountain above sea level, located in the Mahalangur Himal sub-range of the Himalayas. The China–Nepal border runs across its summit point. The current official elevation of 8,848 m (29,029 ft), recognized by China and Nepal, was established by a 1955 Indian survey and subsequently confirmed by a Chinese survey in 1975.',
    },
    {
      "name": "Museum of Natural History",
      "category": "Museums",
      "image":
          "https://media.tacdn.com/media/attractions-splice-spp-674x446/06/70/0f/b9.jpg",
      "price": "\$10",
      'description':
          'Mount Everest is Earth\'s highest mountain above sea level, located in the Mahalangur Himal sub-range of the Himalayas. The China–Nepal border runs across its summit point. The current official elevation of 8,848 m (29,029 ft), recognized by China and Nepal, was established by a 1955 Indian survey and subsequently confirmed by a Chinese survey in 1975.',
    },
    {
      "name": "Museum of Bardo",
      "category": "Museums",
      "image":
          "https://static.lpnt.fr/images/2015/03/18/3131691-jpg_2781378_1000x667.jpg",
      "price": "\$40",
      'description':
          'Mount Everest is Earth\'s highest mountain above sea level, located in the Mahalangur Himal sub-range of the Himalayas. The China–Nepal border runs across its summit point. The current official elevation of 8,848 m (29,029 ft), recognized by China and Nepal, was established by a 1955 Indian survey and subsequently confirmed by a Chinese survey in 1975.',
    },
    {
      "name": "Museum of Modern Art",
      "category": "Museums",
      "image":
          "https://historiadeldisseny.org/web/wp-content/uploads/FHD_Recursos_museu_MoMa.jpg",
      "price": "\$20",
      'description':
          'Mount Everest is Earth\'s highest mountain above sea level, located in the Mahalangur Himal sub-range of the Himalayas. The China–Nepal border runs across its summit point. The current official elevation of 8,848 m (29,029 ft), recognized by China and Nepal, was established by a 1955 Indian survey and subsequently confirmed by a Chinese survey in 1975.',
    },
    {
      "name": "Rocky Mountains",
      "category": "Mountains",
      "image":
          "https://i.natgeofe.com/n/11e30e6f-6fd8-4755-9647-0df41738713a/92565_3x2.jpg",
      "price": "\$50",
      'description':
          'Mount Everest is Earth\'s highest mountain above sea level, located in the Mahalangur Himal sub-range of the Himalayas. The China–Nepal border runs across its summit point. The current official elevation of 8,848 m (29,029 ft), recognized by China and Nepal, was established by a 1955 Indian survey and subsequently confirmed by a Chinese survey in 1975.',
    },
    {
      "name": "Blue Mountain",
      "category": "Mountains",
      "image":
          "https://img.traveltriangle.com/blog/wp-content/uploads/2018/12/Blue-Mountains-In-Australia.jpg",
      "price": "\$20",
      'description':
          'Mount Everest is Earth\'s highest mountain above sea level, located in the Mahalangur Himal sub-range of the Himalayas. The China–Nepal border runs across its summit point. The current official elevation of 8,848 m (29,029 ft), recognized by China and Nepal, was established by a 1955 Indian survey and subsequently confirmed by a Chinese survey in 1975.',
    },
    {
      "name": "Rocky Mountains",
      "category": "Mountains",
      "image":
          "https://www.meganstarr.com/wp-content/uploads/2020/11/Moraine-Lake-in-Banff-Canada.jpg",
      "price": "\$40",
    },
    {
      "name": "Yellowstone National Park",
      "category": "Forests",
      "image": "https://picsum.photos/200",
      "price": "\$15",
      'description':
          'Mount Everest is Earth\'s highest mountain above sea level, located in the Mahalangur Himal sub-range of the Himalayas. The China–Nepal border runs across its summit point. The current official elevation of 8,848 m (29,029 ft), recognized by China and Nepal, was established by a 1955 Indian survey and subsequently confirmed by a Chinese survey in 1975.',
    },
    {
      "name": "Coco Beach Bizerte",
      "category": "Beaches",
      "image":
          "https://media-cdn.tripadvisor.com/media/photo-s/1d/7f/09/01/lacasadecocotn.jpg",
      "price": "\$25",
      'description':
          'Mount Everest is Earth\'s highest mountain above sea level, located in the Mahalangur Himal sub-range of the Himalayas. The China–Nepal border runs across its summit point. The current official elevation of 8,848 m (29,029 ft), recognized by China and Nepal, was established by a 1955 Indian survey and subsequently confirmed by a Chinese survey in 1975.',
    },
    {
      "name": "Waikiki Beach",
      "category": "Beaches",
      "image":
          "https://www.hawaiiactivities.com/travelguide/wp-content/uploads/WaikikiBeach_Aerial_DiamondHead_Oahu_Hawaii_shutterstock_684224887.png",
      "price": "\$25",
      'description':
          'Mount Everest is Earth\'s highest mountain above sea level, located in the Mahalangur Himal sub-range of the Himalayas. The China–Nepal border runs across its summit point. The current official elevation of 8,848 m (29,029 ft), recognized by China and Nepal, was established by a 1955 Indian survey and subsequently confirmed by a Chinese survey in 1975.',
    },
    {
      "name": "Disneyland",
      "category": "Amusement Parks",
      "image":
          "https://media.vogue.fr/photos/5e96df03c685e90008104f1d/1:1/w_875,h_875,c_limit/disney.jpg",
      "price": "\$50",
      'description':
          'Mount Everest is Earth\'s highest mountain above sea level, located in the Mahalangur Himal sub-range of the Himalayas. The China–Nepal border runs across its summit point. The current official elevation of 8,848 m (29,029 ft), recognized by China and Nepal, was established by a 1955 Indian survey and subsequently confirmed by a Chinese survey in 1975.',
    },
  ];

  List<Map<String, dynamic>> _filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    _filteredPlaces = _places;
  }

  void _filterPlaces(String query) {
    setState(() {
      if (query.isNotEmpty) {
        _filteredPlaces = _places
            .where((place) =>
                place['name'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        _filteredPlaces = _places;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/Logo.svg',
          fit: BoxFit.cover,
          height: 36.0,
        ),
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications screen when button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Show menu options when button is pressed
              _showMenu(context);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            //padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bonjour John',
                  style: TextStyle(
                    fontSize: 27.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/1.jpg'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            child: TextField(
              controller: _searchController,
              onChanged: _filterPlaces,
              decoration: InputDecoration(
                hintText: 'Search destinations...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _filteredPlaces = _places
                          .where((place) =>
                              place['category'] == _categories[index]['name'])
                          .toList();
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _categories[index]['icon']!,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _categories[index]['name']!,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredPlaces.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaceDescriptionScreen(
                            place: _filteredPlaces[index]),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image:
                                  NetworkImage(_filteredPlaces[index]['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _filteredPlaces[index]['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Price is: " + _filteredPlaces[index]['price'],
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _showMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Navigate to home screen
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.playlist_add_circle_outlined),
              title: const Text('Destination'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DestinationScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Schedule'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScheduleScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.groups),
              title: const Text('Clients'),
              onTap: () {
                // Navigate to activites screen when pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClientScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Feedbacks'),
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/Feedbacks');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to settings screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                // Navigate to about screen
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      );
    },
  );
}

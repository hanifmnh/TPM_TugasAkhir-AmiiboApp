import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectakhir/screen/detail_screen.dart';
import 'package:projectakhir/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<dynamic> characters = [];
  List<dynamic> filteredCharacters = [];
  TextEditingController searchController = TextEditingController();

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initial();
    fetchCharacters();
  }

  void initial() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> fetchCharacters() async {
    final response = await http.get(Uri.parse('https://www.amiiboapi.com/api/amiibo'));
    if (response.statusCode == 200) {
      setState(() {
        characters = jsonDecode(response.body)['amiibo'];
        filteredCharacters = characters;
      });
    } else {
      throw Exception('Failed to fetch characters');
    }
  }

  void filterCharacters(String query) {
    setState(() {
      filteredCharacters = characters.where((character) {
        final name = character['name'].toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amiibo Characters'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: navigateToLogout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: filterCharacters,
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Search by name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: characters.isEmpty ? const Center(
              child: CircularProgressIndicator(),
            ) : GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: filteredCharacters.length,
              itemBuilder: (context, index) {
                final character = filteredCharacters[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DetailScreen(character: character),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            character['image'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            character['name'].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,

                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      )
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void navigateToLogout() async {
    await prefs.remove("username");

    _showSnackbar('Logout successful');

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ), (route) => false
    );
  }
}

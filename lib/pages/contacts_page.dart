import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  // Generate 15 dummy users
  List<Map<String, String>> generateDummyContacts() {
    return List.generate(15, (index) {
      return {
        "name": "User ${index + 1}",
        "avatar": "https://i.pravatar.cc/150?img=${(index % 70) + 1}"
      };
    });
  }

  // Group contacts by the number in "User X"
  Map<String, List<Map<String, String>>> groupContactsByLetter(
      List<Map<String, String>> contacts) {
    Map<String, List<Map<String, String>>> grouped = {};
    for (var contact in contacts) {
      String digitGroup = contact['name']!.split(" ")[1][0]; // Get first digit
      if (!grouped.containsKey(digitGroup)) {
        grouped[digitGroup] = [];
      }
      grouped[digitGroup]!.add(contact);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final dummyContacts = generateDummyContacts();
    final groupedContacts = groupContactsByLetter(dummyContacts);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Contact List
          Expanded(
            child: ListView.builder(
              itemCount: groupedContacts.keys.length,
              itemBuilder: (context, index) {
                String groupKey = groupedContacts.keys.elementAt(index);
                List<Map<String, String>> group = groupedContacts[groupKey]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Header
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "Group $groupKey",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    // Contacts under this group
                    ...group.map((contact) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(contact['avatar']!),
                        ),
                        title: Text(contact['name']!),
                        onTap: () {}, // Add functionality if needed
                      );
                    }).toList(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

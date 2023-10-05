import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  final List<String> _classPokemon = [
    'Normal',
    'Figthting',
    'Flying',
    'Poison',
    'Ground',
    'Rock',
    'Bug',
    'Ghost',
    'Steel',
    'Fire',
    'Water',
    'Grass',
    'Electric',
    'Psychic',
    'Ice',
    'Dragon',
    'Dark',
    'Fairy',
    'Unknown',
    'Shadow',
    '-------'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practica 10 - Pokédex'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          itemCount: _classPokemon.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {},
              title: Text('${_classPokemon[index]}'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1RuDkgqHQMTa7733I-6iWt-vgZjrkL4JsgR8r8Y2mGQ&s'),
                radius: 16.0,
              ),
            );
          }),
    );
  }
}

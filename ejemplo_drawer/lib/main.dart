import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool isDrawerOpen = false;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(1, 0), // Comienza desde el lado derecho
      end: Offset(0, 0), // Termina en el centro
    ).animate(_animationController);
  }

  void toggleDrawer() {
    setState(() {
      if (isDrawerOpen) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
      isDrawerOpen = !isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Drawer Example'),
      ),
      body: Stack(
        children: [
          // Contenido principal
          Container(
              // Contenido principal
              ),
          // Cajón lateral
          Positioned(
            right: -200 + (200 * _animationController.value),
            top: 0,
            bottom: 0,
            width: 200,
            child: GestureDetector(
              onPanUpdate: (details) {
                // Detectar deslizamiento horizontal para cerrar el cajón
                if (details.primaryDelta! < -10) {
                  toggleDrawer();
                }
              },
              child: Container(
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                      onTap: () {
                        // Agrega aquí la lógica para manejar la selección de "Home"
                        toggleDrawer();
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                      onTap: () {
                        // Agrega aquí la lógica para manejar la selección de "Settings"
                        toggleDrawer();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleDrawer,
        child: Icon(Icons.menu),
      ),
    );
  }
}

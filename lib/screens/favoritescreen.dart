import 'package:ecommer_app/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {


  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favprv = context.watch<FavoriteProvider>().favorites;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Favorites",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
            ),
          )
      ),
      body: favprv.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/favorite_logo.png"),
                  Text(
                    "No Favorites Yet",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: favprv.length,
              itemBuilder: (context, index) {
                final fp = favprv[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  elevation: 2,
                  shadowColor: Colors.orange,
                  child: ListTile(
                    leading: Image.network(fp.thumbnail),
                    title: Text(fp.title),
                    subtitle: Text("\$${fp.price}", style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFFF6A00),
                      fontWeight: FontWeight.bold,
                    ),),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<FavoriteProvider>().toggleFavorite(fp);
                      },
                      icon: Icon(Icons.delete, color: Colors.orange),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

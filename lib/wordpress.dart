import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html_unescape/html_unescape.dart';

class WordpressPage extends StatefulWidget {
  @override
  _WordpressPageState createState() => _WordpressPageState();
}

class _WordpressPageState extends State<WordpressPage> {
  List<dynamic> _posts = [];
  final _htmlUnescape = HtmlUnescape();

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    var response = await http.get(Uri.parse('https://variety.com/wp-json/wp/v2/posts?per_page=3'));
    if (response.statusCode == 200) {
      setState(() {
        _posts = json.decode(response.body);
      });
    } else {
      print('Error en la solicitud HTTP: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Variety News'),
      ),
      body: Container(
        color: Color.fromRGBO(4, 187, 163, 1),
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/Variety.png',
                height: 130,
                width: 300, 
              ),
            ),
            Text(
              'Últimas Noticias',
              style: TextStyle(color: Color.fromRGBO(44, 44, 68, 1), fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (BuildContext context, int index) {
                  String title = _htmlUnescape.convert(_posts[index]['title']['rendered']);
                  String excerpt = _htmlUnescape.convert(_posts[index]['excerpt']['rendered']);
                  return Card(
                    color: Color.fromRGBO(44, 44, 68, 1),
                    child: ListTile(
                      title: Text(
                        title,
                        style: TextStyle(color: Color.fromRGBO(4, 187, 163, 1), fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        excerpt,
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

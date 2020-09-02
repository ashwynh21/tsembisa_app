import 'package:flutter/material.dart';
import 'articles.dart';

class Single extends StatelessWidget {
  final int index;

  Single({@required this.index});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(articles[index]['background'], fit: BoxFit.cover),
          SingleChildScrollView(
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.64),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 80),
                      child: Text(
                        articles[index]['topic'],
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.4
                        ),
                      )
                    ),

                    /*
                    * Down here we then iterate the subtopics and layout the
                    * descriptions on each...
                    * */
                    Container(
                      margin: EdgeInsets.only(left: 32, right: 32, top: 40),
                      child: Column(
                        children: (articles[index]['subtopics'] as List<dynamic>).map((topic) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(topic['title'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 16),
                                  child: Text(topic['description'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15
                                    ),
                                  ),
                                ),
                              ],
                            )
                          );
                        }).toList(),
                      )
                    )

                  ],
                )
              ),
            ),
          )
        ],
      )
    );
  }
}

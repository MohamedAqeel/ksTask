import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tes/detailsPage.dart';

class FemaleMale extends StatefulWidget {
  const FemaleMale({super.key});

  @override
  State<FemaleMale> createState() => _FemaleMaleState();
}

class _FemaleMaleState extends State<FemaleMale> {
  List male = [];
  List fmales = [];

  @override
  void initState() {
    super.initState();
  }

  getDetails() async {
    String baseUrl = "https://randomuser.me/api";
    var res = await http.get(Uri.parse(baseUrl));
    var data = jsonDecode(res.body);
    print(res.body);

    if (data['results'][0]['gender'] == "male") {
      male.add(data['results'][0]);
    } else {
      fmales.add(data['results'][0]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        getDetails();
      }),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: male.length,
                      itemBuilder: (b, i) {
                        return cardItem(male[i], i);
                      })),
              Expanded(
                  child: ListView.builder(
                      itemCount: fmales.length,
                      itemBuilder: (b, i) {
                        return cardItem(fmales[i], i, isMale: false);
                      }))
            ],
          ),
        ),
      ),
    );
  }

  cardItem(data, index, {isMale = true}) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
            context, MaterialPageRoute(builder: (b) => DetailsPage(data)));
        if (isMale) {
          male.removeAt(index);
        } else {
          fmales.removeAt(index);
        }
        setState(() {});
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(data['name']['first']),
              Text(data['name']['last']),
              Text(data['location']['street']['name']),
              Text(data['location']['city']),
              Text(data['location']['state']),
              Text(
                  "${data['location']['coordinates']['latitude']} , ${data['location']['coordinates']['longitude']}"),
            ],
          ),
        ),
      ),
    );
  }
}

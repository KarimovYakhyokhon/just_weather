import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_weather/colors.dart';
import 'package:just_weather/data_service.dart';
import 'package:just_weather/models.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse _response;

  appBar() {
    return AppBar(
      title: Center(
          child: Text(
        'The World Weather',
        style: TextStyle(color: kTextColor),
      )),
      elevation: 0,
      backgroundColor: kBackgroundColor,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: kTextColor,
        ),
        onPressed: () {},
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.notifications, color: kTextColor),
            onPressed: () {})
      ],
    );
  }

  next7Days() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Next 7 Days',
            style: TextStyle(fontSize: 20, color: kTextColor),
          ),
          TextButton(
            child: Text(
              'see more',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ),
            onPressed: () {
              openUrl();
            },
          )
        ],
      ),
    );
  }

  textFormField() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.3,
            height: MediaQuery.of(context).size.height / 14,
            child: TextFormField(
              controller: _cityTextController,
              decoration: InputDecoration(
                hintText: 'Enter the City',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: kTextColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: kTextColor)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: FloatingActionButton(
            onPressed: _search,
            child: Icon(Icons.refresh),
            backgroundColor: Colors.blueGrey,
          ),
        )
      ],
    );
  }

  weatherContainer() {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.15,
          height: MediaQuery.of(context).size.height / 3.9,
          decoration: BoxDecoration(
              color: kBaackgroundColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black12)]),
          child: Column(
            children: [
              Text(
                _response.cityName,
                style: TextStyle(fontSize: 28, color: kWhiteColor),
              ),
              Text(DateFormat().add_MMMMEEEEd().format(DateTime.now()),
                  style: TextStyle(fontSize: 15, color: kWhiteColor)),
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Column(
                      children: [
                        Text(
                          _response.weatherInfo.description,
                          style: TextStyle(fontSize: 15, color: kWhiteColor),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${_response.tempInfo.temperature}°C',
                          style: TextStyle(fontSize: 35, color: kWhiteColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 70),
                  Image.network(_response.iconUrl),
                ],
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: appBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            textFormField(),
            if (_response != null) weatherContainer(),
            next7Days(),
          ],
        ),
      ),
    );
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }

  openUrl() {
    String url1 =
        "https://www.accuweather.com/en/uz/tashkent/351199/april-weather/351199";
    launch(url1);
  }
}
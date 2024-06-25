import 'package:flutter/material.dart';

class AdBannerPage extends StatefulWidget {
  @override
  _AdBannerPageState createState() => _AdBannerPageState();
}

class _AdBannerPageState extends State<AdBannerPage> {
  final List<String> ads = [
    'https://www.hdcarwallpapers.com/walls/lamborghini_aventador_supercar-HD.jpg',
    'https://img.goodfon.ru/original/2560x1600/6/9b/bugatti-veyron-sport-car-avto.jpg',
    'https://torrent-mars.ru/_ld/205/28488868.jpg',
    'https://i.pinimg.com/originals/b2/72/53/b272536d23bb4cfa15897cee5452f2d9.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad Banner Example'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AdBanner(ads: ads),
        ),
      ),
      body: const Center(
        child: Text('Content goes here'),
      ),
    );
  }
}

class AdBanner extends StatefulWidget {
  final List<String> ads;

  AdBanner({required this.ads});

  @override
  _AdBannerState createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        setState(() {
          _scrollPosition = _scrollController.position.minScrollExtent;
        });
      }
    });
    _startScrolling();
  }

  void _startScrolling() async {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      if (_scrollController.hasClients) {
        _scrollPosition += 1.0;
        if (_scrollPosition >= _scrollController.position.maxScrollExtent) {
          _scrollPosition = 0.0;
        }
        _scrollController.jumpTo(_scrollPosition);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: Colors.black,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.ads.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Image.network(
              widget.ads[index],
              fit: BoxFit.cover,
              width: 300,
              height: 100,
            ),
          );
        },
      ),
    );
  }
}
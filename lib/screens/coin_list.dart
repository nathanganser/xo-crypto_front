import 'package:flutter/material.dart';
import 'package:xo/models/api.dart';
import 'package:xo/models/coin.dart';
import 'package:xo/components/coin_card.dart';

import 'coin_grid.dart';

class CoinList extends StatefulWidget {
  static String id = '/crypto_list';

  @override
  _CoinListState createState() => _CoinListState();
}

class _CoinListState extends State<CoinList> {
  List<Coin> _listCoin = [];
  int _selectedIndex = 0;

  void _onTap(int index) {
    _selectedIndex = index;
    print(_selectedIndex);
    Navigator.pushNamed(context, CoinGrid.id);
    setState(() {});
  }

  Future<void> load_coins() async {
    List<Coin> listTemp = await Api.get_cryptos();
    setState(() {
      _listCoin = listTemp;
    });
  }

  @override
  void initState() {
    load_coins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('crypto_list build');
    print(_listCoin);

    return Scaffold(
      appBar: AppBar(
        title: Text('xo-crypto.com'),
      ),
      body: _buildListView(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: _listCoin.length,
      itemBuilder: (context, index) {
        var item = _listCoin[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 2.0,
          ),
          child: CoinCard(
            _listCoin[index],
          ),
        );
      },
    );
  }

  BottomNavigationBar _buildBottomNav() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lightbulb),
          label: 'Analysis',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      onTap: _onTap,
    );
  }
}

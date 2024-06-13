import 'package:flutter/material.dart';
import 'package:pos_app/model/table.dart';
import 'package:pos_app/view/table_details_page.dart';
import 'package:pos_app/view_model/table_page_view_model.dart';
import 'package:provider/provider.dart';

class TablePage extends StatelessWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TablePageViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: _buildGridView(viewModel),
        );
      },
    );
  }

  Widget _buildGridView(TablePageViewModel viewModel) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: viewModel.tables.length,
      itemBuilder: (context, index) {
        Tables tables = viewModel.tables[index];
        return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => TablePageViewModel(),
                      child: TabledetailsPage(
                        table: tables,
                      ),
                    ),
                  ));
            },
            child: _buildGridTile(tables));
      },
    );
  }

  Widget _buildGridTile(Tables tables) {
    Color backgroundColor;
    if (tables.status == 'available') {
      backgroundColor = Colors.green;
    } else {
      backgroundColor = Colors.red;
    }

    return GridTile(
        child: Card(
      color: const Color.fromRGBO(46, 99, 110, 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/table.png',
            width: 120,
            height: 120,
          ),
          Container(
            color: backgroundColor,
            height: 30,
            width: 30,
            alignment: Alignment.center,
            child: Text(
              tables.name,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    ));
  }
}

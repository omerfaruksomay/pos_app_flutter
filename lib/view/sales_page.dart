import 'package:flutter/material.dart';
import 'package:pos_app/model/sale_details.dart';
import 'package:pos_app/model/table.dart';
import 'package:pos_app/view/custom_widgets/custom_button.dart';
import 'package:pos_app/view_model/table_page_view_model.dart';
import 'package:provider/provider.dart';

class SalesPage extends StatelessWidget {
  Tables table;

  SalesPage({required this.table, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildGetOrdersButton(context),
        Consumer<TablePageViewModel>(
          builder: (context, viewModel, child) {
            return Expanded(
              child: ListView.builder(
                itemCount: viewModel.sales.length,
                itemBuilder: (context, index) {
                  SaleDetails sale = viewModel.sales[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Color.fromRGBO(46, 99, 110, 150),
                      child: ListTile(
                        title: Text(sale.menu_name),
                        trailing: Text(sale.menu_price.toString() + ' \$'),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }

  Padding _buildGetOrdersButton(BuildContext context) {
    TablePageViewModel viewModel = Provider.of(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CustomButton(
          label: 'Show active orders',
          labelColor: Colors.black,
          buttonColor: Color.fromRGBO(46, 99, 110, 150),
          minWidth: 300,
          minHeight: 50,
          onPressed: () {
            viewModel.getSaleDetails(table.id);
          },
        ),
      ),
    );
  }
}

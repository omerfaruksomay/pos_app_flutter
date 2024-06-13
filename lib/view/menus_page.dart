import 'package:flutter/material.dart';
import 'package:pos_app/model/table.dart';
import 'package:pos_app/view_model/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../model/category.dart';
import '../model/menu.dart';
import '../view_model/table_page_view_model.dart';
import 'custom_widgets/custom_button.dart';

class MenusPage extends StatelessWidget {
  Tables table;

  MenusPage({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    TablePageViewModel viewModel = Provider.of(context);

    return Column(
      children: [
        _buildCategorySelection(),
        viewModel.menus.isEmpty
            ? const Center(
                child: Text('Please select a category'),
              )
            : _buildMenusSection(),
      ],
    );
  }

  Expanded _buildMenusSection() {
    return Expanded(
      child: Consumer<TablePageViewModel>(
        builder: (context, viewModel, child) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                Menu menus = viewModel.menus[index];
                return _buildGridTile(context, menus, viewModel);
              },
              itemCount: viewModel.menus.length,
            ),
          );
        },
      ),
    );
  }

  Widget _buildGridTile(
      BuildContext context, Menu menus, TablePageViewModel viewModel) {
    AuthViewModel authViewModel = Provider.of(context, listen: false);
    return InkWell(
      onTap: () async {
        await viewModel.orderFood(
          token: authViewModel.token,
          menuId: menus.id,
          tableId: table.id,
          tableName: table.name,
          quantity: 1,
        );
      },
      child: GridTile(
        child: Card(
          color: const Color.fromRGBO(46, 99, 110, 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'http://10.0.2.2:8000/menu_images/${menus.image}',
                width: 150,
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(menus.name),
                  Text(menus.price + '\$'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _buildCategorySelection() {
    return Container(
      height: 60,
      child: Consumer<TablePageViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Categories categories = viewModel.categories[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.center,
                  child: _buildCategorySelectionButton(categories, context),
                ),
              );
            },
            itemCount: viewModel.categories.length,
          );
        },
      ),
    );
  }

  CustomButton _buildCategorySelectionButton(
      Categories categories, BuildContext context) {
    TablePageViewModel viewModel = Provider.of(context, listen: false);
    return CustomButton(
      label: categories.name,
      labelColor: Colors.black,
      buttonColor: Color.fromRGBO(46, 99, 110, 150),
      minWidth: 100,
      minHeight: 250,
      onPressed: () {
        viewModel.getMenus(categories.id);
      },
    );
  }
}

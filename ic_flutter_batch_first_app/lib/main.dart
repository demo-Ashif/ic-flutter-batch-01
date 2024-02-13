import 'package:flutter/material.dart';
import 'package:ic_flutter_batch_first_app/product.dart';

void main() {
  // runApp(GridViewWidget());
  runApp(ProductGrid());
}

class GridViewWidget extends StatelessWidget {
  GridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> sampleNames = [
      'Alice',
      'Bob',
      'Charlie',
      'Diana',
      'Evan',
      'Fiona',
      'George',
      'Hannah',
      'Ian',
      'Jenna',
      'Kyle',
      'Luna',
      'Mike',
      'Nora',
      'Oliver'
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: SafeArea(
        child: Scaffold(
          body: GridView.builder(
            // scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: sampleNames.length,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.redAccent,
                child: Center(
                  child: Text(
                    sampleNames[index],
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.8),
        appBar: AppBar(
          title: Text('Shopper'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '\$ ${products[index].price.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Image.network(
                        '${products[index].image}',
                        height: 70,
                        fit: BoxFit.fitHeight,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Text(
                          '${products[index].title}',
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '${products[index].category}',
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        child: Text(
                          '${products[index].description}',
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

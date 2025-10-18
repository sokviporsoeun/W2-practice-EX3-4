enum DeliveryType{delivered, pickup}
class Product{
  String name;
  double price;

  Product({required this.name, required this.price});
  @override //to display product info
  String toString() {
    return '$name - \$${price.toStringAsFixed(2)}';
  }

}
class Order{
  List<Product> product;
  DeliveryType deliveryType;
  String? deliveryAddress;

  Order({required this.product, required this.deliveryType, this.deliveryAddress,}) {
    if (deliveryType == DeliveryType.delivered && deliveryAddress == null) {
      throw ArgumentError('Delivery address is required for delivered orders!');
    }

    if (deliveryType == DeliveryType.pickup && deliveryAddress != null) {
      throw ArgumentError('Pickup orders should not have a delivery address!');
    }
  }

  double calculateTotalAmount() {
    double total = 0.0;
    for (var product in product) {
      total += product.price;
    }
return total;
}
void displayOrderInfo() {
  print('Delivery Type: ${deliveryType == DeliveryType.delivered ? "Delivered" : "Pickup"}');
    if (deliveryType == DeliveryType.delivered) {
      print('Delivery Address: $deliveryAddress');
    } else {
      print('Pickup Location: Shop');
    }
    
    print('\nProducts:');
    for (var product in product) {
      print('  - $product');
    }

     print('\nTotal Amount: \$${calculateTotalAmount().toStringAsFixed(2)}');
}

void main(){

  var laptop = Product(name: 'Laptop', price: 999.99);
  var mouse = Product(name: 'Wireless Mouse', price: 25.50);
  var keyboard = Product(name: 'Mechanical Keyboard', price: 89.99);
  var headphones = Product(name: 'Headphones', price: 149.00);
  
  print('Available Products:');
  print('  $laptop');
  print('  $mouse');
  print('  $keyboard');
  print('  $headphones');

  // Test 1 
  var order1 = Order(
    product: [laptop, mouse, keyboard],
    deliveryType: DeliveryType.delivered,
    deliveryAddress: '123 Main Street, Phnom Penh',
  );
  order1.displayOrderInfo();

  // test2
  var order2 = Order(
    product: [headphones, mouse],
    deliveryType: DeliveryType.pickup,
    // No address needed for pickup
  );
  order2.displayOrderInfo();

  // Test 3
  var order3 = Order(
    product: [laptop],
    deliveryType: DeliveryType.delivered,
    deliveryAddress: '456 Tech Avenue, Phnom Penh',
  );
  order3.displayOrderInfo();

  // Test4
  print('--- Test 4: Manual Total Calculation ---');
  print('Order 1 total: \$${order1.calculateTotalAmount()}');
  print('Order 2 total: \$${order2.calculateTotalAmount()}');
  print('Order 3 total: \$${order3.calculateTotalAmount()}');
  
  // Test 5
  try {
    var invalidOrder = Order(
      product: [laptop],
      deliveryType: DeliveryType.delivered,
      // Missing address, this should throw an error!
    );
  } catch (e) {
    print('Error caught: $e');
  }
  print('All tests complete!');
}
}
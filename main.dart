import 'dart:io'; //(stdin.readLineSync()을 사용하기 위해 추가)

// 상품 클래스 정의
class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

// 쇼핑몰 클래스 정의
class Shoppingmall {
  List<Product> products = [
    Product("셔츠", 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  ];

  List<String> cartItems = []; //장바구니에 담긴 상품 이름
  int total = 0;

  // 상품 목록을 출력하는 함수
  void showProducts() {
    print("\n 판매중인 상품 목록");
    // for-in문을 사용하여 리스트에 있는 모든 상품을 하나씩 출력
    for (final product in products) {
      print('${product.name} / ${product.price}원');
    }
  }

  // 장바구니에 상품을 추가하는 함수
  void addToCart() {
    print('장바구니에 담을 상품을 선택해주세요');
    String? name = stdin.readLineSync();
    print('상품 개수를 입력해주세요');
    String? inputcount = stdin.readLineSync() ?? "";
    try {
      Product product = products.firstWhere(
        (product) => product.name == name,
      ); // 입력받은 상품명과 일치하는 상품을 찾는다.
      int count = int.parse(inputcount); // 입력받은 문자열을 정수로 변환
      if (count > 0) {
        total += (product.price * count);

        //추가된 코드 시작
        for (var i = 0; i < count; i++) {
          cartItems.add(product.name);
        }
        print('장바구니에 상품이 추가되었습니다.');

        //추가된 코드('장바구니에 상품이 추가되었습니다.');
      } else {
        print('상품 개수는 1개 이상이어야 합니다.');
      }
    } catch (error) {
      print('해당 상품이 존재하지 않습니다.');
    }
  }

  void showTotal() {
    if (cartItems.isEmpty) {
      print('장바구니에 담긴 상품이 없습니다.');
    } else {
      String items = cartItems.join(',');
      print('장바구니에 담긴 상품: $items');
    }
    print('장바구니에 담긴 상품의 총 가격은 $total원 입니다.');
  }

  void clearCart() {
    if (total == 0) {
      print('장바구니에 담긴 상품이 없습니다.');
    } else {
      total = 0;
      print('장바구니가 초기화 되었습니다.');
    }
  }
}

// 쇼핑몰 객체 생성 (프로그램 실행 시작점)
void main() {
  Shoppingmall shoppingmall = Shoppingmall();
  bool isTerminated = false; // 프로그램 종료 여부를 저장하는 변수
  while (!isTerminated) {
    print('---------------------------------');
    print(
      '[1] 상품 목록 출력 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료 / [6] 장바구니 초기화',
    );
    print('---------------------------------');
    String? input = stdin.readLineSync(); // 사용자 입력을 받는다.
    switch (input) {
      case '1':
        shoppingmall.showProducts();
        break;
      case '2':
        shoppingmall.addToCart();
        break;
      case '3':
        shoppingmall.showTotal();
        break;
      case '4':
        print('정말 종료하시겠습니까? (5를 입력하면 종료됩니다.)');
        String? confirmInput = stdin.readLineSync();
        if (confirmInput == '5') {
          print('프로그램을 종료합니다.');

          isTerminated = true;
        } else {
          print('프로그램이 종료되지 않습니다.');
        }
        break;
      case '6': //'6' 입력시 장바구니 초기화
        shoppingmall.clearCart();
        break;
      default:
        print('지원하지 않는 기능입니다! 다시 시도해주세요...');
        break;
    }
  }
}

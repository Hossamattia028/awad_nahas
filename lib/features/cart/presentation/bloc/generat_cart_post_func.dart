import 'dart:convert';

import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/data/models/cart_model.dart';
import 'package:awad_nahas/features/products/data/models/product_small_model.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';

class GenerateCartJson{
  static Map<String,dynamic> generate({required List<ProductsEntity> productList,required String total}){
    Map<String,dynamic> mapData = {};
    print("s $total");
    for(var i in productList){
      var key = "22210129b${DateTime.now().millisecondsSinceEpoch.toString().substring(0,3)}852d73ea41affbbd9${DateTime.now().millisecond.toString().substring(0,3)}";
      mapData.addAll({
        key:{
          "key": key,
          "product_id": i.id,
          "variation_id": 0,
          "variation": [],
          "quantity": i.quantity,
          "data_hash": "b5c1d5ca8bae6d4896cf1807cdf763f0",
          "line_tax_data": {
            "subtotal": {
              "1": 120
            },
            "total": {
              "1": 120
            }
          },
          "line_subtotal": 800,
          "line_subtotal_tax": 120,
          "line_total": 800,
          "line_tax": 120
        }
      });
    }
    var data = {
      "cart": mapData,
      "cart_totals": {
        "subtotal": total.toString(),
        "subtotal_tax": 336.8999999999999772626324556767940521240234375,
        "shipping_total": "0",
        "shipping_tax": 0,
        "shipping_taxes": [],
        "discount_total": 0,
        "discount_tax": 0,
        "cart_contents_total": "2246",
        "cart_contents_tax": 336.8999999999999772626324556767940521240234375,
        "cart_contents_taxes": {
          "1": 336.8999999999999772626324556767940521240234375
        },
        "fee_total": "0",
        "fee_tax": 0,
        "fee_taxes": [],
        "total": total.toString(),
        "total_tax": 336.8999999999999772626324556767940521240234375
      },
      "applied_coupons": [],
      "coupon_discount_totals": [],
      "coupon_discount_tax_totals": [],
      "removed_cart_contents": [],
      "customer": {
        "id": Util.getUserID(),
        "date_modified": "2023-05-04T15:04:25+03:00",
        "postcode": "",
        "city": "",
        "address_1": "",
        "address": "",
        "address_2": "",
        "state": "",
        "country": "SA",
        "shipping_postcode": "",
        "shipping_city": "",
        "shipping_address_1": "",
        "shipping_address": "",
        "shipping_address_2": "",
        "shipping_state": "",
        "shipping_country": "SA",
        "is_vat_exempt": "",
        "calculated_shipping": "",
        "first_name": "",
        "last_name": "",
        "company": "",
        "phone": "",
        "email": Util.getEmail(),
        "shipping_first_name": "",
        "shipping_last_name": "",
        "shipping_company": "",
        "shipping_phone": ""
      },
      "shipping_for_package_0": {
        "package_hash": "wc_ship_275b839ff476516ca8eb2c2bc7dccf27",
        "rates": {
          "free_shipping:2": {
            "__PHP_Incomplete_Class_Name": "WC_Shipping_Rate"
          }
        }
      },
      "previous_shipping_methods": [
        [
          "free_shipping:2"
        ]
      ],
      "chosen_shipping_methods": [
        "free_shipping:2"
      ],
      "shipping_method_counts": [
        1
      ],
    };
    // print(data);
    return data;
  }
}
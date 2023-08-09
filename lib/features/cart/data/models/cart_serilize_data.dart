
class CartSerialize {
  Cart? cart;
  CartTotals? cartTotals;
  List<void>? appliedCoupons;
  List<void>? couponDiscountTotals;
  List<void>? couponDiscountTaxTotals;
  List<void>? removedCartContents;
  Customer? customer;
  ShippingForPackage0? shippingForPackage0;
  List<List>? previousShippingMethods;
  List<String>? chosenShippingMethods;
  List<int>? shippingMethodCounts;

  CartSerialize({
      this.cart,
      this.cartTotals,
      this.appliedCoupons,
      this.couponDiscountTotals,
      this.couponDiscountTaxTotals,
      this.removedCartContents,
      this.customer,
      this.shippingForPackage0,
      this.previousShippingMethods,
      this.chosenShippingMethods,
      this.shippingMethodCounts
  });


  CartSerialize.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
    cartTotals = json['cart_totals'] != null
        ? CartTotals.fromJson(json['cart_totals'])
        : null;
    if (json['applied_coupons'] != null) {
      appliedCoupons = <Null>[];
      // json['applied_coupons'].forEach((v) { appliedCoupons!.add(Null.fromJson(v)); });
    }
    if (json['coupon_discount_totals'] != null) {
      couponDiscountTotals = <Null>[];
      // json['coupon_discount_totals'].forEach((v) { couponDiscountTotals!.add(Null.fromJson(v)); });
    }
    if (json['coupon_discount_tax_totals'] != null) {
      couponDiscountTaxTotals = <Null>[];
      // json['coupon_discount_tax_totals'].forEach((v) { couponDiscountTaxTotals!.add(Null.fromJson(v)); });
    }
    if (json['removed_cart_contents'] != null) {
      removedCartContents = <Null>[];
      // json['removed_cart_contents'].forEach((v) { removedCartContents!.add(Null.fromJson(v)); });
    }
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    shippingForPackage0 = json['shipping_for_package_0'] != null
        ? ShippingForPackage0.fromJson(json['shipping_for_package_0'])
        : null;
    if (json['previous_shipping_methods'] != null) {
      previousShippingMethods = <List>[];
      // json['previous_shipping_methods'].forEach((v) { previousShippingMethods!.add(List.fromJson(v)); });
    }
    chosenShippingMethods = json['chosen_shipping_methods'].cast<String>();
    shippingMethodCounts = json['shipping_method_counts'].cast<int>();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cart != null) {
      data['cart'] = cart!.toJson();
    }
    if (cartTotals != null) {
      data['cart_totals'] = cartTotals!.toJson();
    }
    if (appliedCoupons != null) {
      // data['applied_coupons'] = appliedCoupons!.map((v) => v.toJson()).toList();
    }
    if (couponDiscountTotals != null) {
      // data['coupon_discount_totals'] = couponDiscountTotals!.map((v) => v.toJson()).toList();
    }
    if (couponDiscountTaxTotals != null) {
      // data['coupon_discount_tax_totals'] = couponDiscountTaxTotals!.map((v) => v.toJson()).toList();
    }
    if (removedCartContents != null) {
      // data['removed_cart_contents'] = removedCartContents!.map((v) => v.toJson()).toList();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (shippingForPackage0 != null) {
      data['shipping_for_package_0'] = shippingForPackage0!.toJson();
    }
    if (previousShippingMethods != null) {
      // data['previous_shipping_methods'] = previousShippingMethods!.map((v) => v.toJson()).toList();
    }
    data['chosen_shipping_methods'] = chosenShippingMethods;
    data['shipping_method_counts'] = shippingMethodCounts;

    return data;
  }
}

class Cart {
  String? key;
  int? productId;
  int? variationId;
  List<void>? variation;
  int? quantity;
  String? dataHash;
  LineTaxData? lineTaxData;
  int? lineSubtotal;
  int? lineSubtotalTax;
  int? lineTotal;
  int? lineTax;

  Cart(
      {this.key,
      this.productId,
      this.variationId,
      this.variation,
      this.quantity,
      this.dataHash,
      this.lineTaxData,
      this.lineSubtotal,
      this.lineSubtotalTax,
      this.lineTotal,
      this.lineTax});

  Cart.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    productId = json['product_id'];
    variationId = json['variation_id'];
    if (json['variation'] != null) {
      variation = <Null>[];
          // json['variation'].forEach((v) { variation!.add(Null.fromJson(v)); });
    }
    quantity = json['quantity'];
    dataHash = json['data_hash'];
    lineTaxData = json['line_tax_data'] != null
        ? LineTaxData.fromJson(json['line_tax_data'])
        : null;
    lineSubtotal = json['line_subtotal'];
    lineSubtotalTax = json['line_subtotal_tax'];
    lineTotal = json['line_total'];
    lineTax = json['line_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['product_id'] = productId;
    data['variation_id'] = variationId;
    if (variation != null) {
// data['variation'] = variation!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = quantity;
    data['data_hash'] = dataHash;
    if (lineTaxData != null) {
      data['line_tax_data'] = lineTaxData!.toJson();
    }
    data['line_subtotal'] = lineSubtotal;
    data['line_subtotal_tax'] = lineSubtotalTax;
    data['line_total'] = lineTotal;
    data['line_tax'] = lineTax;
    return data;
  }
}

class LineTaxData {
  Subtotal? subtotal;
  Subtotal? total;

  LineTaxData({this.subtotal, this.total});

  LineTaxData.fromJson(Map<String, dynamic> json) {
    subtotal =
        json['subtotal'] != null ? Subtotal.fromJson(json['subtotal']) : null;
    total = json['total'] != null ? Subtotal.fromJson(json['total']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subtotal != null) {
      data['subtotal'] = subtotal!.toJson();
    }
    if (total != null) {
      data['total'] = total!.toJson();
    }
    return data;
  }
}

class Subtotal {
  int? i1;

  Subtotal({this.i1});

  Subtotal.fromJson(Map<String, dynamic> json) {
    i1 = json['1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['1'] = i1;
    return data;
  }
}

class CartTotals {
  String? subtotal;
  double? subtotalTax;
  String? shippingTotal;
  int? shippingTax;
  List<void>? shippingTaxes;
  int? discountTotal;
  int? discountTax;
  String? cartContentsTotal;
  double? cartContentsTax;
  CartContentsTaxes? cartContentsTaxes;
  String? feeTotal;
  int? feeTax;
  List<void>? feeTaxes;
  String? total;
  double? totalTax;

  CartTotals(
      {this.subtotal,
      this.subtotalTax,
      this.shippingTotal,
      this.shippingTax,
      this.shippingTaxes,
      this.discountTotal,
      this.discountTax,
      this.cartContentsTotal,
      this.cartContentsTax,
      this.cartContentsTaxes,
      this.feeTotal,
      this.feeTax,
      this.feeTaxes,
      this.total,
      this.totalTax});

  CartTotals.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    subtotalTax = json['subtotal_tax'];
    shippingTotal = json['shipping_total'];
    shippingTax = json['shipping_tax'];
    if (json['shipping_taxes'] != null) {
      shippingTaxes = <Null>[];
        // json['shipping_taxes'].forEach((v) { shippingTaxes!.add(Null.fromJson(v)); });
    }
    discountTotal = json['discount_total'];
    discountTax = json['discount_tax'];
    cartContentsTotal = json['cart_contents_total'];
    cartContentsTax = json['cart_contents_tax'];
    cartContentsTaxes = json['cart_contents_taxes'] != null
        ? CartContentsTaxes.fromJson(json['cart_contents_taxes'])
        : null;
    feeTotal = json['fee_total'];
    feeTax = json['fee_tax'];
    if (json['fee_taxes'] != null) {
      feeTaxes = <Null>[];
        // json['fee_taxes'].forEach((v) { feeTaxes!.add(Null.fromJson(v)); });
    }
    total = json['total'];
    totalTax = json['total_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subtotal'] = subtotal;
    data['subtotal_tax'] = subtotalTax;
    data['shipping_total'] = shippingTotal;
    data['shipping_tax'] = shippingTax;
    if (shippingTaxes != null) {
// data['shipping_taxes'] = shippingTaxes!.map((v) => v.toJson()).toList();
    }
    data['discount_total'] = discountTotal;
    data['discount_tax'] = discountTax;
    data['cart_contents_total'] = cartContentsTotal;
    data['cart_contents_tax'] = cartContentsTax;
    if (cartContentsTaxes != null) {
      data['cart_contents_taxes'] = cartContentsTaxes!.toJson();
    }
    data['fee_total'] = feeTotal;
    data['fee_tax'] = feeTax;
    if (feeTaxes != null) {
// data['fee_taxes'] = feeTaxes!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['total_tax'] = totalTax;
    return data;
  }
}

class CartContentsTaxes {
  double? d1;

  CartContentsTaxes({this.d1});

  CartContentsTaxes.fromJson(Map<String, dynamic> json) {
    d1 = json['1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['1'] = d1;
    return data;
  }
}

class Customer {
  String? id;
  String? dateModified;
  String? postcode;
  String? city;
  String? address1;
  String? address;
  String? address2;
  String? state;
  String? country;
  String? shippingPostcode;
  String? shippingCity;
  String? shippingAddress1;
  String? shippingAddress;
  String? shippingAddress2;
  String? shippingState;
  String? shippingCountry;
  String? isVatExempt;
  String? calculatedShipping;
  String? firstName;
  String? lastName;
  String? company;
  String? phone;
  String? email;
  String? shippingFirstName;
  String? shippingLastName;
  String? shippingCompany;
  String? shippingPhone;

  Customer(
      {this.id,
      this.dateModified,
      this.postcode,
      this.city,
      this.address1,
      this.address,
      this.address2,
      this.state,
      this.country,
      this.shippingPostcode,
      this.shippingCity,
      this.shippingAddress1,
      this.shippingAddress,
      this.shippingAddress2,
      this.shippingState,
      this.shippingCountry,
      this.isVatExempt,
      this.calculatedShipping,
      this.firstName,
      this.lastName,
      this.company,
      this.phone,
      this.email,
      this.shippingFirstName,
      this.shippingLastName,
      this.shippingCompany,
      this.shippingPhone});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateModified = json['date_modified'];
    postcode = json['postcode'];
    city = json['city'];
    address1 = json['address_1'];
    address = json['address'];
    address2 = json['address_2'];
    state = json['state'];
    country = json['country'];
    shippingPostcode = json['shipping_postcode'];
    shippingCity = json['shipping_city'];
    shippingAddress1 = json['shipping_address_1'];
    shippingAddress = json['shipping_address'];
    shippingAddress2 = json['shipping_address_2'];
    shippingState = json['shipping_state'];
    shippingCountry = json['shipping_country'];
    isVatExempt = json['is_vat_exempt'];
    calculatedShipping = json['calculated_shipping'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    phone = json['phone'];
    email = json['email'];
    shippingFirstName = json['shipping_first_name'];
    shippingLastName = json['shipping_last_name'];
    shippingCompany = json['shipping_company'];
    shippingPhone = json['shipping_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date_modified'] = dateModified;
    data['postcode'] = postcode;
    data['city'] = city;
    data['address_1'] = address1;
    data['address'] = address;
    data['address_2'] = address2;
    data['state'] = state;
    data['country'] = country;
    data['shipping_postcode'] = shippingPostcode;
    data['shipping_city'] = shippingCity;
    data['shipping_address_1'] = shippingAddress1;
    data['shipping_address'] = shippingAddress;
    data['shipping_address_2'] = shippingAddress2;
    data['shipping_state'] = shippingState;
    data['shipping_country'] = shippingCountry;
    data['is_vat_exempt'] = isVatExempt;
    data['calculated_shipping'] = calculatedShipping;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['company'] = company;
    data['phone'] = phone;
    data['email'] = email;
    data['shipping_first_name'] = shippingFirstName;
    data['shipping_last_name'] = shippingLastName;
    data['shipping_company'] = shippingCompany;
    data['shipping_phone'] = shippingPhone;
    return data;
  }
}

class ShippingForPackage0 {
  String? packageHash;
  Rates? rates;

  ShippingForPackage0({this.packageHash, this.rates});

  ShippingForPackage0.fromJson(Map<String, dynamic> json) {
    packageHash = json['package_hash'];
    rates = json['rates'] != null ? Rates.fromJson(json['rates']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['package_hash'] = packageHash;
    if (rates != null) {
      data['rates'] = rates!.toJson();
    }
    return data;
  }
}

class Rates {
  FreeShipping2? freeShipping2;

  Rates({this.freeShipping2});

  Rates.fromJson(Map<String, dynamic> json) {
    freeShipping2 = json['free_shipping:2'] != null
        ? FreeShipping2.fromJson(json['free_shipping:2'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (freeShipping2 != null) {
      data['free_shipping:2'] = freeShipping2!.toJson();
    }
    return data;
  }
}

class FreeShipping2 {
  String? sPHPIncompleteClassName;

  FreeShipping2({this.sPHPIncompleteClassName});

  FreeShipping2.fromJson(Map<String, dynamic> json) {
    sPHPIncompleteClassName = json['__PHP_Incomplete_Class_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['__PHP_Incomplete_Class_Name'] = sPHPIncompleteClassName;
    return data;
  }
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  return data;
}

class ApiPaths {
  static String products() => 'products/';
  static String product(String id) => 'products/$id';
  static String user(String uid) => 'users/$uid';
  static String cartItem(String uid, String cartItemId) =>
      'users/$uid/cartItems/$cartItemId';
  static String cartItems(String uid) => 'users/$uid/cartItems/';
  static String addresses(String uid) => 'users/$uid/addresses/';
  static String paymentMethods(String uid) => 'users/$uid/paymentMethods/';
  static favProduct(String uid, String favProductID) =>
      "/users/$uid/favProducts/$favProductID";
  static favProducts(String uid) => "/users/$uid/favProducts/";

  static announcements() => "announcements/";
  static announcement(String announcementID) =>
      "announcements/$announcementID/";

  static categories() => "categories/";
  static category(String categoryID) => "categories/$categoryID/";
}

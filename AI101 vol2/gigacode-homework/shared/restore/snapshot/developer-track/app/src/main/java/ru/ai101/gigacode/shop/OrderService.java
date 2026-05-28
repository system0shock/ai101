package ru.ai101.gigacode.shop;

import java.util.List;

public class OrderService {
    private final DiscountPolicy discountPolicy = new DiscountPolicy();

    public int totalRub(List<CartItem> items) {
        int subtotal = items.stream().mapToInt(item -> item.quantity() * item.priceRub()).sum();
        int itemCount = items.stream().mapToInt(CartItem::quantity).sum();
        int discount = discountPolicy.discountPercent(itemCount);
        return subtotal - subtotal * discount / 100;
    }
}


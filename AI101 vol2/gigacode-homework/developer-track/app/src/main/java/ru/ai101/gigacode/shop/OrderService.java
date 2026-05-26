package ru.ai101.gigacode.shop;

import java.util.List;

public final class OrderService {
    private static final int FREE_SHIPPING_THRESHOLD_RUB = 1_000;
    private static final int SHIPPING_FEE_RUB = 199;

    private final DiscountPolicy discountPolicy;

    public OrderService(DiscountPolicy discountPolicy) {
        this.discountPolicy = discountPolicy;
    }

    public int totalRub(List<CartItem> items, String promoCode) {
        int subtotal = items.stream()
                .mapToInt(CartItem::subtotalRub)
                .sum();
        int discounted = discountPolicy.applyPromo(subtotal, promoCode);
        int shipping = discounted >= FREE_SHIPPING_THRESHOLD_RUB ? 0 : SHIPPING_FEE_RUB;
        return discounted + shipping;
    }
}

package ru.ai101.gigacode.shop;

public final class DiscountPolicy {
    public int applyPromo(int subtotalRub, String promoCode) {
        if (subtotalRub < 0) {
            throw new IllegalArgumentException("subtotalRub must be non-negative");
        }
        if (promoCode == null || promoCode.isBlank()) {
            return subtotalRub;
        }
        if ("WELCOME10".equalsIgnoreCase(promoCode)) {
            return Math.max(0, subtotalRub - 10);
        }
        return subtotalRub;
    }
}

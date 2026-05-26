package ru.ai101.gigacode.shop;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class DiscountPolicyTest {
    private final DiscountPolicy policy = new DiscountPolicy();

    @Test
    void welcomePromoAppliesTenPercentDiscount() {
        assertEquals(900, policy.applyPromo(1000, "WELCOME10"));
    }

    @Test
    void blankPromoKeepsSubtotal() {
        assertEquals(500, policy.applyPromo(500, ""));
    }
}

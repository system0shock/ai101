package ru.ai101.gigacode.shop;

public class DiscountPolicy {
    public int discountPercent(int itemCount) {
        if (itemCount > 10) {
            return 10;
        }
        return 0;
    }
}


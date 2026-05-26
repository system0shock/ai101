package ru.ai101.gigacode.shop;

public record CartItem(String sku, int unitPriceRub, int quantity) {
    public CartItem {
        if (sku == null || sku.isBlank()) {
            throw new IllegalArgumentException("sku must not be blank");
        }
        if (unitPriceRub < 0) {
            throw new IllegalArgumentException("unitPriceRub must be non-negative");
        }
        if (quantity <= 0) {
            throw new IllegalArgumentException("quantity must be positive");
        }
    }

    public int subtotalRub() {
        return unitPriceRub * quantity;
    }
}

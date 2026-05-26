package ru.ai101.gigacode.shop;

import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

class OrderServiceTest {
    @Test
    void totalIncludesShippingWhenDiscountedTotalBelowThreshold() {
        OrderService service = new OrderService(new DiscountPolicy());

        int total = service.totalRub(
                List.of(new CartItem("book", 500, 1)),
                ""
        );

        assertEquals(699, total);
    }
}

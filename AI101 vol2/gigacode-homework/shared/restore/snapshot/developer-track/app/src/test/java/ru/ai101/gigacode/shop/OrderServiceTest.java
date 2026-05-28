package ru.ai101.gigacode.shop;

import org.junit.jupiter.api.Test;
import java.util.List;
import static org.junit.jupiter.api.Assertions.assertEquals;

class OrderServiceTest {
    @Test
    void appliesBulkDiscountFromTenItems() {
        OrderService service = new OrderService();
        int total = service.totalRub(List.of(new CartItem("book", 10, 100)));
        assertEquals(900, total);
    }
}


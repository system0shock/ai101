# Expected: review summary

Хороший ответ по заданию 02 выглядит примерно так:

---

**Баг:** `DiscountPolicy.discountPercent` применяет скидку только при `itemCount > 10`,
но бизнес-правило — "от 10 товаров включительно".

**Evidence:**
- `DiscountPolicy.java:5`: `if (itemCount > 10)` — граница строгая
- `OrderServiceTest.java`: тест `appliesBulkDiscountFromTenItems` передаёт ровно 10 товаров

**Минимальная правка:**
```java
// было
if (itemCount > 10)
// стало
if (itemCount >= 10)
```

**Команда проверки:** `./gradlew test`

**Tool calls:** search → read DiscountPolicy.java → read OrderServiceTest.java → edit → shell test

---

Ваш ответ не обязан совпадать дословно. Главное: есть file:line evidence,
объяснение граничного условия и команда проверки.

# Сводка ожидаемого исправления

Минимальное исправление:

```java
if ("WELCOME10".equalsIgnoreCase(promoCode)) {
    return subtotalRub - (subtotalRub / 10);
}
```

После исправления команда проверки должна завершиться успешно:

```text
.\scripts\run-tests.ps1
```

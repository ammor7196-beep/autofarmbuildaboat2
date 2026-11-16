<div align="center">

# ⛵ AutoFarm — Build a Boat for Treasure

**Автофарм для Roblox Build a Boat for Treasure** — автоматическое прохождение маршрута, Anti-AFK и нулевая гравитация для быстрого перемещения.

![Lua](https://img.shields.io/badge/language-Lua%20%7C%20Luau-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Game](https://img.shields.io/badge/game-Build%20a%20Boat-E2244A?style=for-the-badge&logo=roblox&logoColor=white)
![Status](https://img.shields.io/badge/status-active-success?style=for-the-badge)
![Executor](https://img.shields.io/badge/executor-Xeno-8A2BE2?style=for-the-badge)

</div>

---

## 📥 Установка

Скопируйте строку ниже и вставьте в консоль вашего инжектора:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/ammor7196-beep/autofarmbuildaboat2/refs/heads/main/autofarmbuildaboat.lua"))()
```

Обновления применяются автоматически — код всегда берётся напрямую из этого репозитория.

## ✨ Возможности

| Функция | Описание |
|---|---|
| 🚜 AutoFarm | Автоматически прогоняет персонажа по 3 контрольным точкам карты по кругу |
| 🛌 Anti-AFK | Каждые 15 секунд имитирует нажатие клавиши — вас не кикнет за AFK |
| 🌌 Zero Gravity | Во время перелётов гравитация отключается — движение плавное и быстрое |
| 🖱️ Удобный GUI | Компактное перетаскиваемое окно: вкл/выкл в один клик |
| ♻️ Умный цикл | Скрипт переживает смерть персонажа и продолжает фарм автоматически |
| 🧩 Anti-дубль | Повторный запуск не создаёт второй GUI — старый удаляется |

## ⚙️ Как это работает

1. Скрипт создаёт GUI в `PlayerGui` с кнопкой **AutoFarm + AntiAfk**.
2. При включении персонаж по Tween-маршруту летит через 3 точки карты (с выключенной гравитацией).
3. После завершения маршрута скрипт ждёт смерти персонажа, восстанавливает гравитацию и начинает цикл заново.
4. Параллельно работает поток Anti-AFK, имитирующий нажатия клавиш через `VirtualInputManager`.

## 🎮 Управление

| Кнопка | Действие |
|---|---|
| **AutoFarm + AntiAfk** | Запуск автофарма |
| **Stop AutoFarm** | Остановка и восстановление гравитации |
| **X** | Полное закрытие скрипта |

## 📂 Структура

```
.
├── autofarmbuildaboat.lua   # Основной скрипт
├── LICENSE                  # Лицензия MIT
└── README.md                # Этот файл
```

## ❓ FAQ

**Подойдёт ли для других игр?** Нет, контрольные точки привязаны к координатам Build a Boat for Treasure.

**Какой инжектор нужен?** Скрипт написан под Xeno, но должен работать в большинстве инжекторов с поддержкой `request` и `VirtualInputManager`.

## 📄 Лицензия

Распространяется под лицензией **MIT** — см. [LICENSE](LICENSE).

<div align="center">

**⚠️ Disclaimer:** Используйте на свой страх и риск. Автор не несёт ответственности за блокировки аккаунтов или нарушение правил платформы.

</div>

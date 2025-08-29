# 🐳 Docker Container Manager (Bash)

Этот скрипт — простой **TUI-менеджер Docker-контейнеров** на Bash.  
Позволяет удобно просматривать список контейнеров, управлять ими и запускать команды прямо из терминала.

This script is a simple **TUI Docker container manager** written in Bash.  
It allows you to easily view running containers, manage them, and execute commands directly from the terminal.

---

## ✨ Возможности / Features
- 📋 Автоматически обновляет список каждые `5` секунд  
  📋 Automatically refreshes the list every `5` seconds
- 🎨 Красивый цветной вывод  
  🎨 Colorful terminal output
- ✅ Отображает / Shows:
  - Имя контейнера / Container name
  - Статус (**active** / **stopped**)  
  - Образ (с обрезкой длинных названий) / Image (with truncation for long names)
  - Проброшенные порты / Exposed ports
- ⚡ Управление контейнерами / Container management:
  - 🔄 Перезапустить / Restart
  - ▶️ Запустить / Start
  - ⏹ Остановить / Stop
  - 📜 Показать последние 30 строк логов / Show last 30 log lines
  - 🐚 Зайти внутрь контейнера через `bash` / Enter container via `bash`
- 🖥 Удобный интерфейс / Simple interactive menu

---

## 🚀 Установка и запуск / Installation & Usage

# Скачайте скрипт / Download script
wget https://example.com/docker_manager.sh -O docker_manager.sh

# Сделайте его исполняемым / Make it executable
chmod +x docker_manager.sh

# Запустите / Run
./docker_manager.sh

---

# 🛠 Требования
  - Linux / macOS с поддержкой Bash
  - Установленный Docker
  - Доступ к управлению контейнерами (docker ps, docker exec, и т.д.)

# 🖱 Управление
  После запуска скрипта:
  - Введите номер контейнера → попадёте в меню управления
  - q → выход
  - r → обновить список контейнеров вручную
  Меню контейнера
  - 1 → Перезапустить
  - 2 → Запустить
  - 3 → Остановить
  - 4 → Показать логи (30 строк)
  - 5 → Войти в контейнер (bash)
  - b → Назад
  - q → Выход

# 📷 Пример работы
```bash
=== Менеджер Docker-контейнеров ===
(обновление списка каждые 5 сек)

 №  | Имя                  | Статус     | Образ                          | Порты
------------------------------------------------------------------------------------------
  1 | my_app               | active     | myimage:latest                 | 8080
  2 | redis                | stopped    | redis:alpine                   | N/A

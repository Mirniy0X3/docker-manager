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
```shell
wget https://example.com/docker_manager.sh -O docker_manager.sh
```

# Сделайте его исполняемым / Make it executable
```shell
chmod +x docker_manager.sh
```

# Запустите / Run
```shell
./docker_manager.sh
```

---

# 🛠 Требования / Requirements
  - Linux / macOS с поддержкой Bash, Linux / macOS with Bash
  - Установленный Docker, Installed Docker
  - Доступ к управлению контейнерами (docker ps, docker exec, и т.д.) Access to manage containers

# 🖱 Управление / Controls
  После запуска скрипта / After starting the script:
  - Введите номер контейнера → попадёте в меню управления, Enter container number → open management menu
  - q → выход / quit
  - r → обновить список контейнеров вручную / refresh manually
  Меню контейнера / Container menu
  - 1 → Перезапустить / Restart
  - 2 → Запустить / Start
  - 3 → Остановить / Stop
  - 4 → Показать логи (30 строк) / Show logs (30 lines)
  - 5 → Войти в контейнер (bash) / Enter container (bash)
  - b → Назад / Back
  - q → Выход / Quit

# Лицензия / License

Этот проект распространяется под лицензией MIT.
This project is licensed under the MIT License.

# 📷 Пример работы / Example Output
```bash
=== Менеджер Docker-контейнеров ===
(обновление списка каждые 5 сек)

 №  | Имя                  | Статус     | Образ                          | Порты
------------------------------------------------------------------------------------------
  1 | my_app               | active     | myimage:latest                 | 8080
  2 | redis                | stopped    | redis:alpine                   | N/A
```

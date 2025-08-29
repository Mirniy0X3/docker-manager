#!/bin/bash

# 🎨 Цвета
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # reset

# 🔄 Интервал автообновления (секунды)
REFRESH=5
MAX_IMAGE_LEN=30  # максимальная длина названия образа

while true; do
    clear
    echo -e "${CYAN}=== Менеджер Docker-контейнеров ===${NC}"
    echo "(обновление списка каждые $REFRESH сек)"
    echo

    # список контейнеров
    mapfile -t containers < <(docker ps -a --format "{{.Names}}|{{.Status}}|{{.Image}}|{{.Ports}}")

    if [ ${#containers[@]} -eq 0 ]; then
        echo -e "${RED}Контейнеров не найдено.${NC}"
        exit 0
    fi

    # заголовок таблицы
    printf "%3s | %-20s | %-10s | %-30s | %-20s\n" "№" "Имя" "Статус" "Образ" "Порты"
    echo "------------------------------------------------------------------------------------------------"

    # вывод контейнеров
    for i in "${!containers[@]}"; do
        name=$(echo "${containers[$i]}"      | cut -d'|' -f1 | xargs)
        status_raw=$(echo "${containers[$i]}"| cut -d'|' -f2 | xargs)
        image=$(echo "${containers[$i]}"     | cut -d'|' -f3 | xargs)
        ports=$(echo "${containers[$i]}"     | cut -d'|' -f4 | xargs)

        # Статус: только active или stopped
        if [[ "$status_raw" == Up* ]]; then
            status="${GREEN}active${NC}"
        else
            status="${RED}stopped${NC}"
        fi

        # Обрезка длинного названия образа
        if [ ${#image} -gt $MAX_IMAGE_LEN ]; then
            image="${image:0:$((MAX_IMAGE_LEN-3))}..."
        fi

        # Порты: выводим все через запятую, если есть, иначе N/A
        if [[ -n "$ports" ]]; then
            ports_filtered=$(echo "$ports" | grep -oP '(\d+)->\d+' | cut -d'>' -f1 | paste -sd',' -)
            [[ -z "$ports_filtered" ]] && ports_filtered="N/A"
        else
            ports_filtered="N/A"
        fi

        # выводим с корректной интерпретацией ANSI-кодов
        printf "%3d | ${YELLOW}%-20s${NC} | %b | %-30s | %-20s\n" \
            $((i+1)) "$name" "$status" "$image" "$ports_filtered"
    done

    echo
    echo -e "Введите номер контейнера для управления"
    echo -e "или ${YELLOW}q${NC} для выхода, ${YELLOW}r${NC} чтобы обновить список:"
    read -t $REFRESH choice

    if [[ $? -gt 128 ]]; then
        continue
    fi

    if [[ "$choice" == "q" ]]; then
        echo "Выход..."
        exit 0
    fi

    if [[ "$choice" == "r" ]]; then
        continue
    fi

    if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#containers[@]} )); then
        container_name=$(echo "${containers[$((choice-1))]}" | cut -d'|' -f1 | xargs)

        while true; do
            clear
            echo -e "${CYAN}=== Управление контейнером: ${YELLOW}$container_name${NC} ==="
            echo -e "1) ${GREEN}Перезапустить 🔄${NC}"
            echo -e "2) ${GREEN}Запустить ▶️${NC}"
            echo -e "3) ${RED}Остановить ⏹${NC}"
            echo -e "4) ${YELLOW}Показать логи (последние 30 строк) 📜${NC}"
            echo -e "5) ${CYAN}Открыть bash внутри контейнера 🐚${NC}"
            echo -e "b) Назад к списку"
            echo -e "q) Выход"
            echo
            read -p "Выберите действие: " action

            case "$action" in
                1)
                    docker restart "$container_name"
                    echo -e "${GREEN}Контейнер перезапущен.${NC}"
                    read -p "Нажмите Enter..."
                    ;;
                2)
                    docker start "$container_name"
                    echo -e "${GREEN}Контейнер запущен.${NC}"
                    read -p "Нажмите Enter..."
                    ;;
                3)
                    docker stop "$container_name"
                    echo -e "${RED}Контейнер остановлен.${NC}"
                    read -p "Нажмите Enter..."
                    ;;
                4)
                    echo -e "${YELLOW}--- Логи контейнера ($container_name) ---${NC}"
                    docker logs --tail 30 "$container_name"
                    echo -e "${YELLOW}------------------------------------------${NC}"
                    read -p "Нажмите Enter..."
                    ;;
                5)
                    echo -e "${CYAN}Открываю bash внутри контейнера... (exit для выхода)${NC}"
                    docker exec -it "$container_name" bash
                    ;;
                b)
                    break
                    ;;
                q)
                    echo "Выход..."
                    exit 0
                    ;;
                *)
                    echo -e "${RED}Неверный выбор!${NC}"
                    sleep 1
                    ;;
            esac
        done
    else
        echo -e "${RED}Неверный ввод!${NC}"
        sleep 1
    fi
done

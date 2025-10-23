cat > tiktokbot.sh << 'EOF'
#!/bin/bash

# TikTok Bot Sederhana untuk Termux
# Single File Version

# Warna
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# File konfigurasi
HISTORY_FILE="tiktok_history.log"

# Banner
show_banner() {
    clear
    echo -e "${GREEN}"
    echo "┌──────────────────────────────────┐"
    echo "│         TIKTOK BOT TERMUX        │"
    echo "│         SALIN TAUTAN ONLY        │"
    echo "└──────────────────────────────────┘"
    echo -e "${NC}"
}

# Log activity
log_action() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $HISTORY_FILE
}

# Bot Salin Tautan
bot_salin_tautan() {
    clear
    echo -e "${BLUE}┌──────────────────────────────────┐${NC}"
    echo -e "${BLUE}│         BOT SALIN TAUTAN         │${NC}"
    echo -e "${BLUE}└──────────────────────────────────┘${NC}"
    echo ""
    
    # Input URL
    read -p "Masukkan URL video TikTok: " video_url
    
    # Validasi URL sederhana
    if [ -z "$video_url" ]; then
        echo -e "${RED}Error: URL tidak boleh kosong!${NC}"
        sleep 2
        return
    fi
    
    # Input jumlah
    read -p "Jumlah salinan (1-20): " jumlah
    
    # Validasi jumlah
    if ! [[ "$jumlah" =~ ^[0-9]+$ ]] || [ "$jumlah" -lt 1 ] || [ "$jumlah" -gt 20 ]; then
        echo -e "${RED}Error: Jumlah harus angka 1-20!${NC}"
        sleep 2
        return
    fi
    
    # Konfirmasi
    echo ""
    echo -e "${YELLOW}╔════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║           KONFIRMASI           ║${NC}"
    echo -e "${YELLOW}╠════════════════════════════════╣${NC}"
    echo -e "${YELLOW}║${NC} URL: ${video_url:0:30}...    ${YELLOW}║${NC}"
    echo -e "${YELLOW}║${NC} Jumlah: $jumlah salinan           ${YELLOW}║${NC}"
    echo -e "${YELLOW}╚════════════════════════════════╝${NC}"
    echo ""
    
    read -p "Lanjutkan? (y/n): " confirm
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        echo -e "${YELLOW}Dibatalkan!${NC}"
        return
    fi
    
    # Proses salin tautan
    echo -e "\n${GREEN}🚀 Memulai proses salin tautan...${NC}"
    echo -e "${YELLOW}⏳ Mohon tunggu...${NC}"
    
    for ((i=1; i<=jumlah; i++)); do
        # Simulasi proses copy
        echo -e "${BLUE}[$i/$jumlah]${NC} Menyalin tautan TikTok..."
        
        # Log activity
        log_action "SALIN_TAUTAN - URL: $video_url - Salinan: $i"
        
        # Progress bar sederhana
        percentage=$((i * 100 / jumlah))
        bars=$((percentage / 2))
        spaces=$((50 - bars))
        printf "\r[${GREEN}%-${bars}s${NC}%${spaces}s] %d%%" "" "" "$percentage"
        
        # Delay acak 1-3 detik
        sleep $((1 + RANDOM % 3))
    done
    
    echo -e "\n\n${GREEN}✅ SUKSES! Berhasil menyalin $jumlah tautan!${NC}"
    echo -e "${YELLOW}📝 Catatan: Tautan telah disalin tanpa digunakan${NC}"
    
    # Tampilkan log terakhir
    echo -e "\n${BLUE}📋 Log terakhir:${NC}"
    tail -3 "$HISTORY_FILE"
    
    read -p "Tekan Enter untuk kembali ke menu..."
}

# Bot Follow (simulasi)
bot_follow() {
    clear
    echo -e "${BLUE}┌──────────────────────────────────┐${NC}"
    echo -e "${BLUE}│           BOT FOLLOW            │${NC}"
    echo -e "${BLUE}└──────────────────────────────────┘${NC}"
    echo ""
    
    read -p "Masukkan username TikTok: " username
    read -p "Jumlah follow (15-30): " follow_count
    read -p "Jumlah suntikan: " suntikan
    
    if [ "$follow_count" -lt 15 ] || [ "$follow_count" -gt 30 ]; then
        echo -e "${RED}Error: Jumlah follow harus 15-30!${NC}"
        sleep 2
        return
    fi
    
    total_follow=$((follow_count * suntikan))
    
    echo -e "\n${YELLOW}📊 SUMMARY:${NC}"
    echo "Username: @$username"
    echo "Follow per suntik: $follow_count"
    echo "Jumlah suntikan: $suntikan"
    echo "Total follow: $total_follow"
    
    read -p "Lanjutkan? (y/n): " confirm
    if [ "$confirm" = "y" ]; then
        echo -e "\n${GREEN}Memulai bot follow...${NC}"
        for ((i=1; i<=suntikan; i++)); do
            echo "Suntikan ke-$i: Follow $follow_count akun"
            log_action "FOLLOW - User: $username - Suntikan: $i"
            sleep 1
        done
        echo -e "${GREEN}✅ Berhasil!${NC}"
    else
        echo -e "${YELLOW}❌ Dibatalkan${NC}"
    fi
    read -p "Tekan Enter untuk kembali..."
}

# Bot Like (simulasi)
bot_like() {
    clear
    echo -e "${BLUE}┌──────────────────────────────────┐${NC}"
    echo -e "${BLUE}│            BOT LIKE             │${NC}"
    echo -e "${BLUE}└──────────────────────────────────┘${NC}"
    echo ""
    
    read -p "Masukkan URL video: " video_url
    read -p "Jumlah like per suntik: " like_count
    read -p "Jumlah suntikan: " suntikan
    
    total_like=$((like_count * suntikan))
    
    echo -e "\n${YELLOW}📊 SUMMARY:${NC}"
    echo "URL: $video_url"
    echo "Like per suntik: $like_count"
    echo "Jumlah suntikan: $suntikan"
    echo "Total like: $total_like"
    
    read -p "Lanjutkan? (y/n): " confirm
    if [ "$confirm" = "y" ]; then
        echo -e "\n${GREEN}Memulai bot like...${NC}"
        for ((i=1; i<=suntikan; i++)); do
            echo "Suntikan ke-$i: Like $like_count video"
            log_action "LIKE - URL: $video_url - Suntikan: $i"
            sleep 1
        done
        echo -e "${GREEN}✅ Berhasil!${NC}"
    else
        echo -e "${YELLOW}❌ Dibatalkan${NC}"
    fi
    read -p "Tekan Enter untuk kembali..."
}

# Bot View (simulasi)
bot_view() {
    clear
    echo -e "${BLUE}┌──────────────────────────────────┐${NC}"
    echo -e "${BLUE}│            BOT VIEW             │${NC}"
    echo -e "${BLUE}└──────────────────────────────────┘${NC}"
    echo ""
    
    read -p "Masukkan URL video: " video_url
    read -p "Jumlah view: " jumlah_view
    
    echo -e "\n${YELLOW}📊 SUMMARY:${NC}"
    echo "URL: $video_url"
    echo "Jumlah view: $jumlah_view"
    
    read -p "Lanjutkan? (y/n): " confirm
    if [ "$confirm" = "y" ]; then
        echo -e "\n${GREEN}Memulai bot view...${NC}"
        for ((i=1; i<=jumlah_view; i++)); do
            echo "View ke-$i"
            log_action "VIEW - URL: $video_url - View: $i"
            sleep 1
        done
        echo -e "${GREEN}✅ Berhasil menambah $jumlah_view view!${NC}"
    else
        echo -e "${YELLOW}❌ Dibatalkan${NC}"
    fi
    read -p "Tekan Enter untuk kembali..."
}

# Menu utama
main_menu() {
    while true; do
        show_banner
        echo -e "${BLUE}╔════════════════════════════════╗${NC}"
        echo -e "${BLUE}║           MENU UTAMA           ║${NC}"
        echo -e "${BLUE}╠════════════════════════════════╣${NC}"
        echo -e "${BLUE}║${NC} 1. ${GREEN}Bot Salin Tautan${NC}           ${BLUE}║${NC}"
        echo -e "${BLUE}║${NC} 2. ${GREEN}Bot Follow Akun${NC}            ${BLUE}║${NC}"
        echo -e "${BLUE}║${NC} 3. ${GREEN}Bot Like Video${NC}             ${BLUE}║${NC}"
        echo -e "${BLUE}║${NC} 4. ${GREEN}Bot View Video${NC}             ${BLUE}║${NC}"
        echo -e "${BLUE}║${NC} 5. ${YELLOW}Lihat History${NC}              ${BLUE}║${NC}"
        echo -e "${BLUE}║${NC} 6. ${RED}Keluar${NC}                     ${BLUE}║${NC}"
        echo -e "${BLUE}╚════════════════════════════════╝${NC}"
        echo ""
        read -p "Pilih menu [1-6]: " choice
        
        case $choice in
            1) bot_salin_tautan ;;
            2) bot_follow ;;
            3) bot_like ;;
            4) bot_view ;;
            5) 
                echo -e "\n${YELLOW}📜 HISTORY:${NC}"
                if [ -f "$HISTORY_FILE" ]; then
                    tail -20 "$HISTORY_FILE"
                else
                    echo "Belum ada history"
                fi
                read -p "Tekan Enter untuk kembali..."
                ;;
            6) 
                echo -e "${GREEN}Terima kasih! 👋${NC}"
                exit 0 
                ;;
            *) 
                echo -e "${RED}Pilihan tidak valid!${NC}"
                sleep 1
                ;;
        esac
    done
}

# Inisialisasi
echo -e "${GREEN}Memulai TikTok Bot...${NC}"
sleep 1

# Buat file history jika belum ada
touch "$HISTORY_FILE"

# Jalankan menu utama
main_menu
EOF

#!/bin/bash

# Bot Salin Tautan TikTok
# Hanya menyalin tanpa menggunakan tautan

source ../config.sh

copy_link_bot() {
    clear
    echo -e "${BLUE}╔════════════════════════════════╗${NC}"
    echo -e "${BLUE}║         BOT SALIN TAUTAN       ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════╝${NC}"
    echo ""
    
    # Input URL
    read -p "Masukkan URL video TikTok: " video_url
    
    # Validasi URL
    if [[ ! $video_url == *"tiktok.com"* ]]; then
        echo -e "${RED}Error: URL tidak valid!${NC}"
        sleep 2
        return
    fi
    
    # Input jumlah suntikan
    read -p "Jumlah suntikan (1-100): " jumlah
    
    # Validasi jumlah
    if [[ ! $jumlah =~ ^[0-9]+$ ]] || [ $jumlah -lt 1 ] || [ $jumlah -gt 100 ]; then
        echo -e "${RED}Error: Jumlah tidak valid!${NC}"
        sleep 2
        return
    fi
    
    # Konfirmasi
    echo ""
    echo -e "${YELLOW}Konfirmasi:${NC}"
    echo "URL: $video_url"
    echo "Jumlah: $jumlah suntikan"
    echo ""
    read -p "Lanjutkan? (y/n): " confirm
    
    if [[ $confirm != "y" ]]; then
        echo -e "${YELLOW}Dibatalkan!${NC}"
        return
    fi
    
    # Proses menyalin tautan
    echo -e "\n${GREEN}Memulai proses salin tautan...${NC}"
    
    for ((i=1; i<=$jumlah; i++))
    do
        # Simulasi proses copy link
        echo -e "${BLUE}[$i/$jumlah]${NC} Menyalin tautan..."
        
        # Generate random delay antara 1-5 detik
        delay=$(( RANDOM % 5 + 1 ))
        sleep $delay
        
        # Simpan ke log
        log_action "COPY_LINK - URL: $video_url - Attempt: $i"
        
        # Progress bar sederhana
        progress=$(( i * 100 / jumlah ))
        echo -ne "Progress: [$progress%]\\r"
    done
    
    echo -e "\n${GREEN}✅ Berhasil menyalin $jumlah tautan!${NC}"
    echo -e "${YELLOW}📝 Tautan telah disalin dan tidak digunakan.${NC}"
    
    # Tampilkan summary
    echo ""
    echo -e "${BLUE}╔════════════════════════════════╗${NC}"
    echo -e "${BLUE}║           SUMMARY              ║${NC}"
    echo -e "${BLUE}╠════════════════════════════════╣${NC}"
    echo -e "${BLUE}║${NC} Total: $jumlah tautan disalin     ${BLUE}║${NC}"
    echo -e "${BLUE}║${NC} URL: $(echo $video_url | cut -c1-20)... ${BLUE}║${NC}"
    echo -e "${BLUE}║${NC} Status: ${GREEN}COMPLETED${NC}           ${BLUE}║${NC}"
    echo -e "${BLUE}╚════════════════════════════════╝${NC}"
    
    sleep 3
}

# Run bot
copy_link_bot

#!/bin/bash

# Bot Like Video TikTok

source ../config.sh

like_bot() {
    clear
    echo -e "${BLUE}╔════════════════════════════════╗${NC}"
    echo -e "${BLUE}║           BOT LIKE VIDEO       ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════╝${NC}"
    
    read -p "Masukkan URL video: " video_url
    read -p "Jumlah like per suntik: " like_per_suntik
    read -p "Jumlah suntikan: " jumlah_suntik
    
    total_like=$(( like_per_suntik * jumlah_suntik ))
    
    echo -e "\n${YELLOW}Summary:${NC}"
    echo "URL: $video_url"
    echo "Like per suntik: $like_per_suntik"
    echo "Jumlah suntikan: $jumlah_suntik"
    echo "Total like: $total_like"
    
    read -p "Lanjutkan? (y/n): " confirm
    
    if [[ $confirm == "y" ]]; then
        echo -e "\n${GREEN}Memulai bot like...${NC}"
        # Implementasi like bot disini
        sleep 2
        echo -e "${GREEN}Berhasil!${NC}"
    fi
}

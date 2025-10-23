#!/bin/bash

# Bot Follow Akun TikTok

source ../config.sh

follower_bot() {
    clear
    echo -e "${BLUE}╔════════════════════════════════╗${NC}"
    echo -e "${BLUE}║          BOT FOLLOW AKUN       ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════╝${NC}"
    
    read -p "Masukkan username TikTok: " username
    read -p "Jumlah follow (15-30 per suntik): " follow_per_suntik
    read -p "Jumlah suntikan: " jumlah_suntik
    
    # Validasi input
    if [[ $follow_per_suntik -lt 15 || $follow_per_suntik -gt 30 ]]; then
        echo -e "${RED}Error: Jumlah follow per suntik harus 15-30${NC}"
        return
    fi
    
    total_follow=$(( follow_per_suntik * jumlah_suntik ))
    
    echo -e "\n${YELLOW}Summary:${NC}"
    echo "Username: @$username"
    echo "Follow per suntik: $follow_per_suntik"
    echo "Jumlah suntikan: $jumlah_suntik"
    echo "Total follow: $total_follow"
    
    read -p "Lanjutkan? (y/n): " confirm
    
    if [[ $confirm == "y" ]]; then
        echo -e "\n${GREEN}Memulai bot follow...${NC}"
        # Implementasi follow bot disini
        sleep 2
        echo -e "${GREEN}Berhasil!${NC}"
    fi
}

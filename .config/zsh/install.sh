#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════════════
#  ZSH Configuration Dependencies Installer
#  Supports: macOS (Homebrew) & Arch Linux (pacman/AUR)
# ═══════════════════════════════════════════════════════════════════════════════

set -e  # Exit on error (except in conditional checks)

# ═══════════════════════════════════════════════════════════════════════════════
#  COLOR DEFINITIONS
# ═══════════════════════════════════════════════════════════════════════════════

if [[ -t 1 ]]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    MAGENTA='\033[0;35m'
    CYAN='\033[0;36m'
    BOLD='\033[1m'
    DIM='\033[2m'
    RESET='\033[0m'
else
    RED=''
    GREEN=''
    YELLOW=''
    BLUE=''
    MAGENTA=''
    CYAN=''
    BOLD=''
    DIM=''
    RESET=''
fi

# ═══════════════════════════════════════════════════════════════════════════════
#  GLOBAL VARIABLES
# ═══════════════════════════════════════════════════════════════════════════════

TOTAL_INSTALLED=0
TOTAL_SKIPPED=0
TOTAL_FAILED=0
FAILED_PACKAGES=()

# ═══════════════════════════════════════════════════════════════════════════════
#  PACKAGE LISTS
# ═══════════════════════════════════════════════════════════════════════════════

# macOS - Homebrew packages
BREW_PACKAGES=(
    "eza"
    "bat"
    "git-delta"
    "ripgrep"
    "fzf"
    "zoxide"
    "starship"
    "neovim"
    "lazygit"
    "yazi"
    "lf"
    "zellij"
    "jq"
    "imagemagick"
    "ffmpeg"
    "docker"
    "mise"
    "uv"
    "1password-cli"
    "zsh-history-substring-search"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
)

# Arch Linux - Official repositories (pacman)
PACMAN_PACKAGES=(
    "eza"
    "bat"
    "git-delta"
    "ripgrep"
    "fzf"
    "zoxide"
    "starship"
    "neovim"
    "lazygit"
    "yazi"
    "lf"
    "zellij"
    "jq"
    "imagemagick"
    "ffmpeg"
    "docker"
    "mise"
    "uv"
    "lsof"
    "xdg-utils"
    "parted"
    "exfatprogs"
    "zsh-history-substring-search"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
)

# Arch Linux - AUR packages (yay)
AUR_PACKAGES=(
    "1password-cli"
)

# ═══════════════════════════════════════════════════════════════════════════════
#  HELPER FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════════

print_header() {
    echo -e "\n${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${BOLD}${CYAN} $1${RESET}"
    echo -e "${BOLD}${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
}

print_section() {
    echo -e "\n${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${BOLD}${BLUE}$1${RESET}"
    echo -e "${BOLD}${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
}

print_error() {
    echo -e "${RED}✗${RESET} $1"
}

print_success() {
    echo -e "${GREEN}✓${RESET} $1"
}

print_skip() {
    echo -e "${YELLOW}⊙${RESET} $1"
}

print_info() {
    echo -e "${CYAN}ℹ${RESET} $1"
}

# ═══════════════════════════════════════════════════════════════════════════════
#  OS DETECTION
# ═══════════════════════════════════════════════════════════════════════════════

detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ -f /etc/arch-release ]]; then
        echo "arch"
    else
        echo "unknown"
    fi
}

# ═══════════════════════════════════════════════════════════════════════════════
#  PREREQUISITE CHECKS
# ═══════════════════════════════════════════════════════════════════════════════

check_homebrew() {
    if ! command -v brew &>/dev/null; then
        print_error "Homebrew is not installed"
        echo ""
        echo "To install Homebrew, run:"
        echo -e "${CYAN}  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"${RESET}"
        echo ""
        exit 1
    fi
    print_success "Homebrew is installed"
}

check_pacman() {
    if ! command -v pacman &>/dev/null; then
        print_error "pacman not found - this doesn't appear to be an Arch Linux system"
        exit 1
    fi
    print_success "pacman is available"
}

check_yay() {
    if ! command -v yay &>/dev/null; then
        print_section "⚠️  yay (AUR helper) is not installed"
        echo "To install yay, run the following commands:"
        echo ""
        echo -e "${CYAN}  sudo pacman -S --needed git base-devel"
        echo "  git clone https://aur.archlinux.org/yay.git"
        echo "  cd yay"
        echo -e "  makepkg -si${RESET}"
        echo ""
        echo "After installing yay, re-run this script to install AUR packages."
        print_section "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        return 1
    fi
    print_success "yay is installed"
    return 0
}

# ═══════════════════════════════════════════════════════════════════════════════
#  INSTALLATION FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════════

install_brew_packages() {
    local total=${#BREW_PACKAGES[@]}
    local current=0

    print_section "📦 Installing ${total} packages via Homebrew..."

    for package in "${BREW_PACKAGES[@]}"; do
        current=$((current + 1))
        local pkg_name="${package}"
        local cmd_check="${package}"
        
        # Handle special cases for command checks
        case "$package" in
            "git-delta") cmd_check="delta" ;;
            "imagemagick") cmd_check="magick" ;;
            "neovim") cmd_check="nvim" ;;
            "1password-cli") cmd_check="op" ;;
            "google-cloud-sdk") cmd_check="gcloud" ;;
            "azure-cli") cmd_check="az" ;;
            "databricks") cmd_check="databricks" ;;
        esac

        printf "[%2d/%2d] %-30s " "$current" "$total" "$pkg_name"
        
        # Check if already installed
        if command -v "$cmd_check" &>/dev/null; then
            echo -e "${YELLOW}⊙${RESET} ${DIM}(already installed)${RESET}"
            TOTAL_SKIPPED=$((TOTAL_SKIPPED + 1))
            continue
        fi

        # Try to install
        if brew install "$package" &>/dev/null; then
            echo -e "${GREEN}✓${RESET} ${DIM}(installed)${RESET}"
            TOTAL_INSTALLED=$((TOTAL_INSTALLED + 1))
        else
            echo -e "${RED}✗${RESET} ${DIM}(failed)${RESET}"
            TOTAL_FAILED=$((TOTAL_FAILED + 1))
            FAILED_PACKAGES+=("$package")
        fi
    done
}

install_pacman_packages() {
    local total=${#PACMAN_PACKAGES[@]}
    local current=0

    print_section "📦 Installing ${total} packages via pacman..."

    for package in "${PACMAN_PACKAGES[@]}"; do
        current=$((current + 1))
        
        printf "[%2d/%2d] %-30s " "$current" "$total" "$package"
        
        # Check if already installed
        if pacman -Q "$package" &>/dev/null; then
            echo -e "${YELLOW}⊙${RESET} ${DIM}(already installed)${RESET}"
            TOTAL_SKIPPED=$((TOTAL_SKIPPED + 1))
            continue
        fi

        # Try to install
        if sudo pacman -S --noconfirm "$package" &>/dev/null; then
            echo -e "${GREEN}✓${RESET} ${DIM}(installed)${RESET}"
            TOTAL_INSTALLED=$((TOTAL_INSTALLED + 1))
        else
            echo -e "${RED}✗${RESET} ${DIM}(failed)${RESET}"
            TOTAL_FAILED=$((TOTAL_FAILED + 1))
            FAILED_PACKAGES+=("$package")
        fi
    done
}

install_aur_packages() {
    local total=${#AUR_PACKAGES[@]}
    local current=0

    print_section "📦 Installing ${total} packages via yay (AUR)..."

    for package in "${AUR_PACKAGES[@]}"; do
        current=$((current + 1))
        
        printf "[%2d/%2d] %-30s " "$current" "$total" "$package"
        
        # Check if already installed
        if yay -Q "$package" &>/dev/null; then
            echo -e "${YELLOW}⊙${RESET} ${DIM}(already installed)${RESET}"
            TOTAL_SKIPPED=$((TOTAL_SKIPPED + 1))
            continue
        fi

        # Try to install
        if yay -S --noconfirm "$package" &>/dev/null; then
            echo -e "${GREEN}✓${RESET} ${DIM}(installed)${RESET}"
            TOTAL_INSTALLED=$((TOTAL_INSTALLED + 1))
        else
            echo -e "${RED}✗${RESET} ${DIM}(failed)${RESET}"
            TOTAL_FAILED=$((TOTAL_FAILED + 1))
            FAILED_PACKAGES+=("$package")
        fi
    done
}

# ═══════════════════════════════════════════════════════════════════════════════
#  POST-INSTALL REMINDERS
# ═══════════════════════════════════════════════════════════════════════════════

show_docker_reminder() {
    if [[ "$1" == "arch" ]]; then
        echo ""
        print_section "🐳 Docker Post-Installation"
        echo "To use Docker without sudo, add your user to the docker group:"
        echo ""
        echo -e "${CYAN}  sudo usermod -aG docker \$USER"
        echo -e "  newgrp docker${RESET}"
        echo ""
        echo -e "${DIM}Note: You may need to log out and back in for group changes to take effect.${RESET}"
        print_section "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    fi
}

# ═══════════════════════════════════════════════════════════════════════════════
#  SUMMARY REPORT
# ═══════════════════════════════════════════════════════════════════════════════

show_summary() {
    local total=$((TOTAL_INSTALLED + TOTAL_SKIPPED + TOTAL_FAILED))
    
    print_section "📊 Installation Summary"
    
    echo -e "${BOLD}Total packages:${RESET}    $total"
    echo -e "${GREEN}✓ Installed:${RESET}       $TOTAL_INSTALLED"
    echo -e "${YELLOW}⊙ Already present:${RESET} $TOTAL_SKIPPED"
    echo -e "${RED}✗ Failed:${RESET}          $TOTAL_FAILED"
    
    if [[ $TOTAL_FAILED -gt 0 ]]; then
        echo ""
        echo -e "${BOLD}Failed packages:${RESET}"
        for pkg in "${FAILED_PACKAGES[@]}"; do
            echo -e "  ${RED}•${RESET} $pkg"
        done
        
        echo ""
        echo -e "${BOLD}To retry failed packages:${RESET}"
        if [[ "$OS" == "macos" ]]; then
            echo -e "${CYAN}  brew install ${FAILED_PACKAGES[*]}${RESET}"
        elif [[ "$OS" == "arch" ]]; then
            # Determine if failed packages are from pacman or AUR
            local pacman_failed=()
            local aur_failed=()
            
            for pkg in "${FAILED_PACKAGES[@]}"; do
                if [[ " ${PACMAN_PACKAGES[*]} " =~ " ${pkg} " ]]; then
                    pacman_failed+=("$pkg")
                elif [[ " ${AUR_PACKAGES[*]} " =~ " ${pkg} " ]]; then
                    aur_failed+=("$pkg")
                fi
            done
            
            if [[ ${#pacman_failed[@]} -gt 0 ]]; then
                echo -e "${CYAN}  sudo pacman -S ${pacman_failed[*]}${RESET}"
            fi
            if [[ ${#aur_failed[@]} -gt 0 ]]; then
                echo -e "${CYAN}  yay -S ${aur_failed[*]}${RESET}"
            fi
        fi
    fi
    
    print_section "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    if [[ $TOTAL_FAILED -eq 0 ]]; then
        echo -e "${GREEN}${BOLD}✓ All packages installed successfully!${RESET}"
        echo ""
        echo -e "${DIM}You may need to restart your shell or run 'source ~/.zshrc'${RESET}"
    else
        echo -e "${YELLOW}⚠ Installation completed with some failures.${RESET}"
        echo -e "${DIM}Review the failed packages above and retry manually.${RESET}"
    fi
    
    echo ""
}

# ═══════════════════════════════════════════════════════════════════════════════
#  MAIN EXECUTION
# ═══════════════════════════════════════════════════════════════════════════════

main() {
    print_header "ZSH Configuration Dependencies Installer"
    
    # Detect operating system
    OS=$(detect_os)
    
    if [[ "$OS" == "macos" ]]; then
        print_info "Detected OS: ${BOLD}macOS (Darwin)${RESET}"
        echo ""
        check_homebrew
        install_brew_packages
        
    elif [[ "$OS" == "arch" ]]; then
        print_info "Detected OS: ${BOLD}Arch Linux${RESET}"
        echo ""
        check_pacman
        install_pacman_packages
        
        # Install AUR packages if yay is available
        if check_yay; then
            install_aur_packages
        else
            # Add AUR packages to failed count
            TOTAL_FAILED=$((TOTAL_FAILED + ${#AUR_PACKAGES[@]}))
            for pkg in "${AUR_PACKAGES[@]}"; do
                FAILED_PACKAGES+=("$pkg (AUR - yay not installed)")
            done
        fi
        
        # Show Docker reminder
        show_docker_reminder "arch"
        
    else
        print_error "Unsupported operating system"
        echo ""
        echo "This script supports:"
        echo "  • macOS (with Homebrew)"
        echo "  • Arch Linux (with pacman/yay)"
        echo ""
        exit 1
    fi
    
    # Display summary
    show_summary
}

# Run main function
main

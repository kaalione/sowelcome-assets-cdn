#!/bin/bash

echo "🔍 SOWLCOME FEATURE STATUS CHECK"
echo "================================="
echo ""

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to check if file exists and has content
check_file() {
    if [ -f "$1" ]; then
        size=$(wc -c < "$1")
        if [ $size -gt 100 ]; then
            echo -e "${GREEN}✅ EXISTS${NC} (${size} bytes): $1"
        else
            echo -e "${YELLOW}📁 EMPTY${NC} (${size} bytes): $1"
        fi
    else
        echo -e "${RED}❌ MISSING${NC}: $1"
    fi
}

echo "📂 AUTH PAGES:"
check_file "src/app/auth/login/page.tsx"
check_file "src/app/auth/signup/page.tsx"
check_file "src/app/auth/forgot-password/page.tsx"
check_file "src/app/auth/reset-password/page.tsx"
check_file "src/app/auth/verify-email/page.tsx"
echo ""

echo "📂 LEGAL PAGES:"
check_file "src/app/legal/privacy/page.tsx"
check_file "src/app/legal/terms/page.tsx"
check_file "src/app/legal/cookies/page.tsx"
echo ""

echo "📂 PROFILE PAGES:"
check_file "src/app/profile/page.tsx"
check_file "src/app/profile/edit/page.tsx"
check_file "src/app/profile/events/page.tsx"
check_file "src/app/profile/settings/page.tsx"
echo ""

echo "📂 EVENT PAGES:"
check_file "src/app/events/page.tsx"
check_file "src/app/events/[id]/page.tsx"
check_file "src/app/rsvp/[id]/page.tsx"
echo ""

echo "📂 COMPONENTS:"
check_file "src/components/footer.tsx"
check_file "src/components/cookie-banner.tsx"
check_file "src/components/social-links.tsx"
check_file "src/components/header.tsx"
echo ""

echo "📂 SPECIAL PAGES:"
check_file "src/app/not-found.tsx"
check_file "src/app/error.tsx"
check_file "src/app/loading.tsx"
check_file "src/app/contact/page.tsx"
echo ""

echo "📂 UI COMPONENTS:"
check_file "src/components/ui/button.tsx"
check_file "src/components/ui/input.tsx"
check_file "src/components/ui/card.tsx"
check_file "src/components/ui/toast.tsx"
check_file "src/lib/utils.ts"
echo ""

# Count summary
echo "================================="
echo "📊 SUMMARY:"
total=$(grep -c "check_file" $0)
exists=$(grep -c "✅ EXISTS" /tmp/status_output 2>/dev/null || echo 0)
empty=$(grep -c "📁 EMPTY" /tmp/status_output 2>/dev/null || echo 0)
missing=$(grep -c "❌ MISSING" /tmp/status_output 2>/dev/null || echo 0)

echo "Total files to check: $total"
echo -e "${GREEN}✅ Files with content: Run script to see${NC}"
echo -e "${YELLOW}📁 Empty folders: Run script to see${NC}"
echo -e "${RED}❌ Missing files: Run script to see${NC}"


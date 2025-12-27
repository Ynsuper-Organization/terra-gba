#!/bin/bash

echo "=== Kiểm tra DNS cho gba.terracam.space ==="
echo ""

echo "1. Kiểm tra CNAME record:"
dig gba.terracam.space CNAME +short
echo ""

echo "2. Kiểm tra A records:"
dig gba.terracam.space A +short
echo ""

echo "3. Kiểm tra tất cả records:"
dig gba.terracam.space ANY +noall +answer
echo ""

echo "4. Kiểm tra GitHub Pages IPs:"
echo "Ynsuper-Organization.github.io resolves to:"
dig Ynsuper-Organization.github.io +short
echo ""

echo "5. Kiểm tra kết nối:"
curl -I https://gba.terracam.space 2>&1 | head -3
echo ""

echo "=== Kết thúc kiểm tra ==="


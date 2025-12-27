#!/bin/bash

echo "=========================================="
echo "Kiểm tra DNS cho gba.terracam.space"
echo "=========================================="
echo ""

DOMAIN="gba.terracam.space"
EXPECTED_IPS=("185.199.108.153" "185.199.109.153" "185.199.110.153" "185.199.111.153")

echo "1. Kiểm tra A records:"
A_RECORDS=$(dig $DOMAIN A +short | sort)
echo "$A_RECORDS"
echo ""

if [ -z "$A_RECORDS" ]; then
    echo "❌ KHÔNG tìm thấy A records!"
    echo "   → Cần thêm 4 A records trong DNS provider"
else
    A_COUNT=$(echo "$A_RECORDS" | wc -l | tr -d ' ')
    echo "✅ Tìm thấy $A_COUNT A record(s)"
    
    if [ "$A_COUNT" -lt 4 ]; then
        echo "⚠️  CẢNH BÁO: Chỉ có $A_COUNT A record, cần 4 A records!"
    fi
    
    # Kiểm tra từng IP
    for ip in "${EXPECTED_IPS[@]}"; do
        if echo "$A_RECORDS" | grep -q "$ip"; then
            echo "   ✅ $ip - OK"
        else
            echo "   ❌ $ip - MISSING"
        fi
    done
fi

echo ""
echo "2. Kiểm tra CNAME record:"
CNAME=$(dig $DOMAIN CNAME +short)
if [ -z "$CNAME" ]; then
    echo "✅ Không có CNAME (đúng - nên dùng A records)"
else
    echo "⚠️  Tìm thấy CNAME: $CNAME"
    echo "   → Nên XÓA CNAME và dùng A records thay thế"
fi

echo ""
echo "3. Kiểm tra kết nối HTTP/HTTPS:"
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 http://$DOMAIN 2>/dev/null || echo "000")
HTTPS_CODE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 -k https://$DOMAIN 2>/dev/null || echo "000")

if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "301" ] || [ "$HTTP_CODE" = "302" ]; then
    echo "✅ HTTP đang hoạt động (Status: $HTTP_CODE)"
else
    echo "❌ HTTP chưa hoạt động (Status: $HTTP_CODE)"
fi

if [ "$HTTPS_CODE" = "200" ] || [ "$HTTPS_CODE" = "301" ] || [ "$HTTPS_CODE" = "302" ]; then
    echo "✅ HTTPS đang hoạt động (Status: $HTTPS_CODE)"
else
    echo "⚠️  HTTPS chưa hoạt động hoặc chưa có SSL certificate (Status: $HTTPS_CODE)"
fi

echo ""
echo "=========================================="
echo "Kết luận:"
echo "=========================================="

if [ -z "$A_RECORDS" ]; then
    echo "❌ CẦN HÀNH ĐỘNG: Thêm 4 A records trong DNS provider"
elif [ "$A_COUNT" -lt 4 ]; then
    echo "⚠️  CẦN HÀNH ĐỘNG: Thêm đủ 4 A records"
else
    echo "✅ DNS đã được cấu hình đúng"
    echo "   → Nếu GitHub vẫn báo lỗi, thử xóa và thêm lại domain trong GitHub Settings"
fi

echo ""

